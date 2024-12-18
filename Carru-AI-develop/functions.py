import pandas as pd
import numpy as np
import xgboost as xgb
import os, shutil, joblib

# Global
model_file_path_first_route = 'Models/First_Route_Model.json'
model_file_path_first_stopover = 'Models/First_Stopover_Model.json'
model_file_path_second_stopover = 'Models/Second_Stopover_Model.json'
product_file_path = 'Dataset/PRODUCT.xlsx'
product_df = pd.read_excel(product_file_path)

# 첫 번째 경로 예측 함수
def predict_first_route(model_first, X_first_scaled):
    dtest_first = xgb.DMatrix(X_first_scaled)
    y_pred_first = model_first.predict(dtest_first)
    return y_pred_first


# 가장 가까운 상품 매칭 함수
def match_closest_product(pred_departure_lat, pred_departure_lon, pred_destination_lat, pred_destination_lon,
                          product_df):

    product_departure_latitudes = product_df['departure_lat']
    product_departure_longitudes = product_df['departure_long']
    product_destination_latitudes = product_df['destination_lat']
    product_destination_longitudes = product_df['destination_long']

    departure_distances = np.sqrt((pred_departure_lat - product_departure_latitudes) ** 2 +
                                  (pred_departure_lon - product_departure_longitudes) ** 2)
    destination_distances = np.sqrt((pred_destination_lat - product_destination_latitudes) ** 2 +
                                    (pred_destination_lon - product_destination_longitudes) ** 2)

    total_distances = departure_distances + destination_distances
    closest_index = np.argmin(total_distances)

    closest_product = product_df.iloc[closest_index]
    return closest_product


# 첫 번째 경로 예측 및 상품 매칭 함수
def predict_and_match_first_route(input_df):
    if 'departure' in input_df.columns and input_df['departure'].dtype == 'object':
        input_df.drop(columns=['departure'], inplace=True)

    if 'destination' in input_df.columns and input_df['destination'].dtype == 'object':
        input_df.drop(columns=['destination'], inplace=True)

    if 'user_id' in input_df.columns:
        input_df.drop(columns=['user_id'], inplace=True)

    feature_cols = ['departure_lat', 'departure_long', 'destination_lat',
                    'destination_long', 'preference']

    scaler = joblib.load('Develop/scaler.pkl')  # 'scaler.pkl' 파일을 로드
    X_first_scaled = scaler.transform(input_df[feature_cols])

    model_first = xgb.Booster()
    model_first.load_model(model_file_path_first_route)


    first_route_predictions = predict_first_route(model_first, X_first_scaled)
    closest_products = []

    for i, pred in enumerate(first_route_predictions):
        pred_departure_lat = pred[0]
        pred_departure_lon = pred[1]
        pred_destination_lat = pred[2]
        pred_destination_lon = pred[3]

        X_first_row = input_df.iloc[i]

        closest_product = match_closest_product(pred_departure_lat, pred_departure_lon,
                                                pred_destination_lat, pred_destination_lon, product_df)

        if closest_product is not None:
            product_weight = closest_product['weight']
            closest_products.append({
                'departure_lat': X_first_row['departure_lat'],
                'departure_long': X_first_row['departure_long'],
                'destination_lat': X_first_row['destination_lat'],
                'destination_long': X_first_row['destination_long'],
                'pred_departure_lat': pred_departure_lat,
                'pred_departure_long': pred_departure_lon,
                'closest_product_departure_lat': closest_product['departure_lat'],
                'closest_product_departure_long': closest_product['departure_long'],
                'closest_product_destination_lat': closest_product['destination_lat'],
                'closest_product_destination_long': closest_product['destination_long'],
                'product_weight': product_weight,
                'closest_products': closest_product.to_dict()
            })
            print(f"1차 경로 매칭 성공")
        else:
            print(f"매칭 실패")

    closest_products_df = pd.DataFrame(closest_products)

    return closest_products_df

def predict_stopover(model_stopover, X_stopover_scaled):
    dtest_stopover = xgb.DMatrix(X_stopover_scaled)
    y_pred_stopover = model_stopover.predict(dtest_stopover)
    return y_pred_stopover

# 가장 가까운 상위 N개의 상품 매칭 함수
def match_top_n_products(pred_departure_lat, pred_departure_lon, pred_destination_lat, pred_destination_lon, product_df,
                         n=3):
    product_departure_latitudes = product_df['departure_lat']
    product_departure_longitudes = product_df['departure_long']
    product_destination_latitudes = product_df['destination_lat']
    product_destination_longitudes = product_df['destination_long']

    departure_distances = np.sqrt((pred_departure_lat - product_departure_latitudes) ** 2 +
                                  (pred_departure_lon - product_departure_longitudes) ** 2)
    destination_distances = np.sqrt((pred_destination_lat - product_destination_latitudes) ** 2 +
                                    (pred_destination_lon - product_destination_longitudes) ** 2)

    total_distances = departure_distances + destination_distances
    top_n_indices = np.argsort(total_distances)[:n]
    top_n_products = product_df.iloc[top_n_indices]

    return top_n_products


# 데이터 로드 및 경유지 예측 수행 함수
def predict_stopovers_and_match(input_df, closest_products_df):
    stopover_input = pd.concat([
        input_df[['departure_lat', 'departure_long', 'destination_lat', 'destination_long']],  # 1차 경로 예측값
        closest_products_df[['closest_product_departure_lat', 'closest_product_departure_long',
                             'closest_product_destination_lat', 'closest_product_destination_long']]  # 상품 매칭 결과
    ], axis=1)

    feature_cols_stopover = ['departure_lat', 'departure_long', 'destination_lat', 'destination_long',
                             'closest_product_departure_lat', 'closest_product_departure_long',
                             'closest_product_destination_lat', 'closest_product_destination_long']

    scaler_stopover = joblib.load('Develop/stopover_scaler.pkl')
    X_stopover_scaled = scaler_stopover.fit_transform(stopover_input[feature_cols_stopover])

    model_stopover = xgb.Booster()
    model_stopover.load_model(model_file_path_first_stopover)

    stopover_predictions_scaled = predict_stopover(model_stopover, X_stopover_scaled)
    stopover_predictions_scaled = stopover_predictions_scaled.reshape(-1, 4)
    stopover_predictions_scaled = np.hstack(
        [stopover_predictions_scaled, np.zeros((stopover_predictions_scaled.shape[0], 4))])
    stopover_predictions = scaler_stopover.inverse_transform(stopover_predictions_scaled)

    results = []

    for i, pred in enumerate(stopover_predictions):
        stopover_departure_lat = pred[0]
        stopover_departure_lon = pred[1]
        stopover_destination_lat = pred[2]
        stopover_destination_lon = pred[3]

        # 가장 가까운 상위 3개의 상품 찾기
        top_products = match_top_n_products(stopover_departure_lat, stopover_departure_lon,
                                            stopover_destination_lat, stopover_destination_lon,
                                            product_df, n=3)

        stopover_input_row = stopover_input.iloc[i]

        for _, product in top_products.iterrows():
            result = {
                'user_departure_lat': stopover_input_row['departure_lat'],
                'user_departure_long': stopover_input_row['departure_long'],
                'user_destination_lat': stopover_input_row['destination_lat'],
                'user_destination_long': stopover_input_row['destination_long'],
                'main_departure_lat': stopover_input_row['closest_product_departure_lat'],
                'main_departure_long': stopover_input_row['closest_product_departure_long'],
                'main_destination_lat': stopover_input_row['closest_product_destination_lat'],
                'main_destination_long': stopover_input_row['closest_product_destination_long'],
                'stopover_departure_lat': product['departure_lat'],
                'stopover_departure_lon': product['departure_long'],
                'stopover_destination_lat': product['destination_lat'],
                'stopover_destination_lon': product['destination_long'],
                'product_price': product['price'],
                'product_weight': product['weight']
            }
            results.append(result)
            print(f"1차 경유지 매칭 성공")

    df_results = pd.DataFrame(results)
    return df_results

# 2차 경유지 예측 함수
def predict_second_stopover(model, X_scaled):
    dtest = xgb.DMatrix(X_scaled)  # DataFrame을 DMatrix로 변환
    y_pred = model.predict(dtest)  # 예측
    return y_pred

# 2차 경유지 예측 및 상품 매칭 함수
def predict_second_stopovers_and_match(input_df):
    second_stopover_input_combined = pd.concat([
        input_df[
            ['user_departure_lat', 'user_departure_long', 'user_destination_lat', 'user_destination_long']],
        input_df[
            ['main_departure_lat', 'main_departure_long', 'main_destination_lat', 'main_destination_long']],
        input_df[['stopover_departure_lat', 'stopover_departure_lon', 'stopover_destination_lat',
                               'stopover_destination_lon']]
    ], axis=1)

    feature_cols_stopover = ['user_departure_lat', 'user_departure_long', 'user_destination_lat',
                             'user_destination_long',
                             'main_departure_lat', 'main_departure_long', 'main_destination_lat',
                             'main_destination_long',
                             'stopover_departure_lat', 'stopover_departure_lon', 'stopover_destination_lat',
                             'stopover_destination_lon']

    second_scaler_stopover = joblib.load('Develop/second_stopover_scaler.pkl')
    second_X_stopover_scaled = second_scaler_stopover.fit_transform(
        second_stopover_input_combined[feature_cols_stopover])

    model_second_stopover = xgb.Booster()
    model_second_stopover.load_model(model_file_path_second_stopover)

    second_stopover_predictions_scaled = predict_second_stopover(model_second_stopover, second_X_stopover_scaled)
    second_stopover_predictions_scaled = second_stopover_predictions_scaled.reshape(-1, 4)
    second_stopover_predictions_scaled = np.hstack(
        [second_stopover_predictions_scaled, np.zeros((second_stopover_predictions_scaled.shape[0], 8))])
    second_stopover_predictions = second_scaler_stopover.inverse_transform(second_stopover_predictions_scaled)


    results_2nd = []
    for i, pred in enumerate(second_stopover_predictions):
        second_stopover_departure_lat = pred[0]
        second_stopover_departure_lon = pred[1]
        second_stopover_destination_lat = pred[2]
        second_stopover_destination_lon = pred[3]

        # 가장 가까운 상품 찾기
        closest_product = match_closest_product(second_stopover_departure_lat, second_stopover_departure_lon,
                                                second_stopover_destination_lat, second_stopover_destination_lon,
                                                product_df)

        second_stopover_input_row = input_df.iloc[i]

        # 결과 저장
        result_2nd = {
            'user_departure_lat': second_stopover_input_row['user_departure_lat'],
            'user_departure_long': second_stopover_input_row['user_departure_long'],
            'user_destination_lat': second_stopover_input_row['user_destination_lat'],
            'user_destination_long': second_stopover_input_row['user_destination_long'],
            'main_departure_lat': second_stopover_input_row['main_departure_lat'],
            'main_departure_long': second_stopover_input_row['main_departure_long'],
            'main_destination_lat': second_stopover_input_row['main_destination_lat'],
            'main_destination_long': second_stopover_input_row['main_destination_long'],
            'stopover_departure_lat': second_stopover_input_row['stopover_departure_lat'],
            'stopover_departure_lon': second_stopover_input_row['stopover_departure_lon'],
            'stopover_destination_lat': second_stopover_input_row['stopover_destination_lat'],
            'stopover_destination_lon': second_stopover_input_row['stopover_destination_lon'],
            'second_stopover_departure_lat': closest_product['departure_lat'],
            'second_stopover_departure_lon': closest_product['departure_long'],
            'second_stopover_destination_lat': closest_product['destination_lat'],
            'second_stopover_destination_lon': closest_product['destination_long'],
        }
        results_2nd.append(result_2nd)

        print(f"2차 경유지 예측 완료 - {i + 1}:")

    df_results_2nd = pd.DataFrame(results_2nd)
    return df_results_2nd


# 전체 예측 및 매칭을 순차적으로 수행하는 함수
def predict_and_match_all(input_df):
    closest_product_df = predict_and_match_first_route(input_df)
    stopover_df = predict_stopovers_and_match(input_df, closest_product_df)
    results_df = predict_second_stopovers_and_match(stopover_df)

    print("모든 예측 및 매칭 과정 완료!")

    return results_df


def results_with_product_info(input_df, results_df):
    product_info_list = []

    for _, row in results_df.iterrows():
        user_match = input_df[
            (input_df['departure_lat'] == row['user_departure_lat']) &
            (input_df['departure_long'] == row['user_departure_long']) &
            (input_df['destination_lat'] == row['user_destination_lat']) &
            (input_df['destination_long'] == row['user_destination_long'])
        ]

        main_match = product_df[
            (product_df['departure_lat'] == row['main_departure_lat']) &
            (product_df['departure_long'] == row['main_departure_long']) &
            (product_df['destination_lat'] == row['main_destination_lat']) &
            (product_df['destination_long'] == row['main_destination_long'])
        ]

        stopover_match = product_df[
            (product_df['departure_lat'] == row['stopover_departure_lat']) &
            (product_df['departure_long'] == row['stopover_departure_lon']) &
            (product_df['destination_lat'] == row['stopover_destination_lat']) &
            (product_df['destination_long'] == row['stopover_destination_lon'])
        ]

        second_stopover_match = product_df[
            (product_df['departure_lat'] == row['second_stopover_departure_lat']) &
            (product_df['departure_long'] == row['second_stopover_departure_lon']) &
            (product_df['destination_lat'] == row['second_stopover_destination_lat']) &
            (product_df['destination_long'] == row['second_stopover_destination_lon'])
        ]

        # 상품 정보 가져오기
        user_info = user_match.iloc[0].to_dict() if not user_match.empty else {}
        main_info = main_match.iloc[0].to_dict() if not main_match.empty else {}
        stopover_info = stopover_match.iloc[0].to_dict() if not stopover_match.empty else {}
        second_stopover_info = second_stopover_match.iloc[0].to_dict() if not second_stopover_match.empty else {}

        # 중복된 product_id 제거
        product_ids_seen = set()

        def is_unique(info):
            """중복 확인 및 제거"""
            product_id = info.get('product_id')
            if product_id and product_id not in product_ids_seen:
                product_ids_seen.add(product_id)
                return True
            return False

        # 각 상품 정보에서 중복 확인
        main_info = main_info if is_unique(main_info) else {}
        stopover_info = stopover_info if is_unique(stopover_info) else {}
        second_stopover_info = second_stopover_info if is_unique(second_stopover_info) else {}

        # 결과 저장
        product_info_list.append({
            'user_product_info': user_info,
            'main_product_info': main_info,
            'stopover_product_info': stopover_info,
            'second_stopover_product_info': second_stopover_info
        })

    product_info_df = pd.DataFrame(product_info_list, columns=[
        'user_product_info',
        'main_product_info',
        'stopover_product_info',
        'second_stopover_product_info'
    ])

    print(f"조회된 상품 정보가 완료되었습니다.")
    return product_info_df
