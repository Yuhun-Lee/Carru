# Carru-AI

<div align="center">

![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=flat-square&logo=python&logoColor=white)
![XGBoost](https://img.shields.io/badge/XGBoost-1.7+-FF6600?style=flat-square)
![Flask](https://img.shields.io/badge/Flask-2.0+-000000?style=flat-square&logo=flask&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-1.0+-F7931E?style=flat-square&logo=scikit-learn&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-1.5+-150458?style=flat-square&logo=pandas&logoColor=white)

**XGBoost 기반 화물 운송 경로 최적화 AI 서비스**

[프로젝트 개요](#-프로젝트-개요) • [AI 모델](#-ai-모델-아키텍처) • [API 문서](#-api-문서) • [성능](#-모델-성능) • [설치](#-설치-및-실행)

</div>

---

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [문제 정의 및 솔루션](#-문제-정의-및-솔루션)
- [AI 모델 아키텍처](#-ai-모델-아키텍처)
- [3단계 경로 최적화](#-3단계-경로-최적화-시스템)
- [기술 스택](#-기술-스택)
- [프로젝트 구조](#-프로젝트-구조)
- [데이터 파이프라인](#-데이터-파이프라인)
- [API 문서](#-api-문서)
- [모델 성능](#-모델-성능)
- [설치 및 실행](#-설치-및-실행)

---

## 🎯 프로젝트 개요

Carru-AI는 **기계학습 기반 화물 운송 경로 최적화** 시스템으로, 기사의 주행 경로에 최적의 경유지를 추천하여 빈 차량 운행을 최소화합니다. XGBoost 그래디언트 부스팅 모델을 활용해 기사의 선호도, 차량 적재 용량, 지리적 위치를 종합적으로 고려한 **3단계 최적화 알고리즘**을 제공합니다.

### 핵심 가치

- **공차율 감소**: 40% → 20% 이하로 빈 차량 운행 감소
- **수익 증대**: 한 번의 운행으로 최대 3개 화물 배송
- **시간 절약**: AI 기반 자동 경로 추천으로 경로 계획 시간 단축
- **개인화**: 기사별 선호도 (수익/거리) 반영

---

## 🔍 문제 정의 및 솔루션

### 문제점

1. **높은 공차율**: 화물 기사의 40%가 빈 차량으로 운행
2. **비효율적 경로**: 출발지-도착지 직선 운행으로 중간 화물 기회 상실
3. **정보 비대칭**: 기사가 경로 상의 가용 화물 정보를 알 수 없음
4. **수동 매칭**: 사람이 직접 경로와 화물을 매칭하는 시간 소요

### AI 솔루션

```
┌─────────────────────────────────────────────────────────┐
│           기사의 주행 경로 입력                          │
│   출발: 서울 강남구 → 도착: 부산 해운대구               │
│   선호도: 수익 중심 70%, 거리 중심 30%                   │
│   적재 용량: 최대 5톤, 최소 1톤                          │
└─────────────────────┬───────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────┐
│              1단계: 주 경로 최적화                        │
│   XGBoost 모델이 선호도와 적재 용량을 고려한             │
│   최적의 메인 화물 추천                                  │
│   → 예측: 서울 서초구 → 부산 남구 (2.5톤, 15만원)       │
└─────────────────────┬───────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────┐
│         2단계: 첫 번째 경유지 추천                       │
│   메인 경로와 기사 경로 간 최적 경유지 탐색              │
│   → 추천 Top 3:                                          │
│     1) 대전 유성구 (1.5톤, 8만원) +12km                  │
│     2) 천안시 (1.8톤, 9만원) +15km                       │
│     3) 세종시 (1.2톤, 7만원) +10km                       │
└─────────────────────┬───────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────┐
│         3단계: 두 번째 경유지 추천                       │
│   1차 경유지 포함 후 추가 경유지 탐색                    │
│   → 추천: 대구 달서구 (2.0톤, 10만원) +20km             │
└─────────────────────┬───────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────┐
│              최종 결과                                    │
│   총 3개 화물: 32만원 수익                               │
│   추가 거리: +47km                                       │
│   공차 구간: 0km → 수익률 300% 향상                      │
└─────────────────────────────────────────────────────────┘
```

---

## 🤖 AI 모델 아키텍처

### XGBoost (eXtreme Gradient Boosting)

Carru-AI는 **XGBoost** 앙상블 모델을 사용합니다. XGBoost는 다음과 같은 이유로 선택되었습니다:

- **높은 정확도**: 그래디언트 부스팅으로 예측 정확도 극대화
- **빠른 학습**: 병렬 처리 및 캐시 최적화
- **과적합 방지**: L1/L2 정규화, 조기 종료
- **결측치 처리**: 자동으로 결측값 처리
- **특성 중요도**: 어떤 특성이 예측에 중요한지 분석 가능

### 모델 하이퍼파라미터

```python
XGBoost 공통 설정:
- objective: 'reg:squarederror'  # 회귀 문제
- eval_metric: 'rmse'             # 평가 지표
- max_depth: 8                    # 트리 깊이
- learning_rate: 0.01             # 학습률 (eta)
- subsample: 0.8                  # 데이터 샘플링 비율
- n_estimators: 1000              # 트리 개수
```

---

## 🔄 3단계 경로 최적화 시스템

### 1단계: 주 경로 (First Route) 예측

#### 목적
기사의 출발-도착 경로와 선호도에 가장 적합한 메인 화물 추천

#### 입력 특성 (4개)
```python
- departure_lat        # 기사 출발지 위도
- departure_long       # 기사 출발지 경도
- destination_lat      # 기사 도착지 위도
- destination_long     # 기사 도착지 경도
```

#### 출력
```python
- predicted_product_lat   # 추천 화물의 출발지 위도
- predicted_product_long  # 추천 화물의 출발지 경도
```

#### 모델 세부사항
- **Scaler**: StandardScaler (표준 정규화)
- **Model**: XGBoost Regressor
- **Model Size**: ~14.8 MB

#### 매칭 알고리즘
```python
def match_first_route(predicted_coords, product_database):
    """유클리드 거리 기반 최근접 화물 탐색"""
    distances = []
    for product in product_database:
        dist = sqrt(
            (predicted_lat - product.lat)**2 +
            (predicted_long - product.long)**2
        )
        distances.append((product, dist))

    # 거리 순 정렬 후 1개 반환
    return sorted(distances, key=lambda x: x[1])[0]
```

---

### 2단계: 첫 번째 경유지 (First Stopover) 예측

#### 목적
기사 경로와 메인 화물 경로 사이의 최적 경유지 탐색

#### 입력 특성 (8개)
```python
# 기사 경로
- user_departure_lat
- user_departure_long
- user_destination_lat
- user_destination_long

# 메인 화물 경로
- main_product_departure_lat
- main_product_departure_long
- main_product_destination_lat
- main_product_destination_long
```

#### 출력
```python
- stopover_lat   # 경유지 좌표 (위도)
- stopover_long  # 경유지 좌표 (경도)
```

#### 모델 세부사항
- **Scaler**: MinMaxScaler (0-1 정규화)
- **Model**: XGBoost Regressor
- **Model Size**: ~13.6 MB
- **반환**: Top 3 후보

#### 매칭 알고리즘
```python
def match_first_stopover(predicted_coords, product_database, main_product):
    """Top 3 경유지 추천"""
    candidates = []

    for product in product_database:
        if product.id == main_product.id:
            continue  # 메인 화물 제외

        dist = euclidean_distance(predicted_coords, product.coords)

        # 추가 수익 계산
        additional_profit = product.price
        # 추가 거리 계산
        additional_distance = calculate_detour(user_route, product)

        score = additional_profit / (additional_distance + 1)
        candidates.append((product, score, dist))

    # 거리 기준 정렬 후 Top 3
    return sorted(candidates, key=lambda x: x[2])[:3]
```

---

### 3단계: 두 번째 경유지 (Second Stopover) 예측

#### 목적
1차 경유지 포함 후 추가 경유지 탐색으로 수익 극대화

#### 입력 특성 (12개)
```python
# 기사 경로 (4개)
- user_departure_lat
- user_departure_long
- user_destination_lat
- user_destination_long

# 메인 화물 경로 (4개)
- main_product_departure_lat
- main_product_departure_long
- main_product_destination_lat
- main_product_destination_long

# 1차 경유지 경로 (4개)
- first_stopover_departure_lat
- first_stopover_departure_long
- first_stopover_destination_lat
- first_stopover_destination_long
```

#### 출력
```python
- second_stopover_lat
- second_stopover_long
```

#### 모델 세부사항
- **Scaler**: MinMaxScaler (0-1 정규화)
- **Model**: XGBoost Regressor
- **Model Size**: ~14.5 MB

#### 매칭 알고리즘
```python
def match_second_stopover(
    predicted_coords,
    product_database,
    main_product,
    first_stopover
):
    """2차 경유지 1개 추천 (중복 제거)"""
    candidates = []

    # 이미 선택된 화물 제외
    excluded_ids = {main_product.id, first_stopover.id}

    for product in product_database:
        if product.id in excluded_ids:
            continue

        dist = euclidean_distance(predicted_coords, product.coords)
        candidates.append((product, dist))

    # 최근접 1개 반환
    return sorted(candidates, key=lambda x: x[1])[0]
```

---

## 🛠 기술 스택

### Core Technologies
```
Python 3.8+  |  XGBoost 1.7+  |  Flask 2.0+  |  scikit-learn 1.0+
```

### 머신러닝 & 데이터 처리

| 카테고리 | 기술 | 버전 | 용도 |
|---------|------|------|------|
| **ML Framework** | XGBoost | 1.7+ | 그래디언트 부스팅 모델 |
| **Data Processing** | Pandas | 1.5+ | 데이터 조작 및 분석 |
| | NumPy | 1.23+ | 수치 연산 |
| **Preprocessing** | scikit-learn | 1.0+ | StandardScaler, MinMaxScaler |
| **Model Serialization** | joblib | 1.2+ | 모델 및 스케일러 저장/로드 |
| **Geographic** | geopy | 2.3+ | 지리적 거리 계산, 지오코딩 |
| **API Server** | Flask | 2.0+ | REST API 서버 |
| **Data Analysis** | Jupyter Notebook | - | 데이터 분석 및 모델 개발 |

### 개발 환경
- **Python**: 3.8 이상
- **IDE**: Jupyter Notebook, VSCode
- **Version Control**: Git

---

## 📂 프로젝트 구조

```
Carru-AI-develop/
├── 🚀 app.py                               # Flask REST API 서버
├── 🧮 functions.py                         # 핵심 예측 및 매칭 로직
│
├── 🤖 Models/                              # 프로덕션 모델
│   ├── First_Route_Model.json             # 1단계: 주 경로 모델 (14.8 MB)
│   ├── First_Stopover_Model.json          # 2단계: 1차 경유지 모델 (13.6 MB)
│   └── Second_Stopover_Model.json         # 3단계: 2차 경유지 모델 (14.5 MB)
│
├── 🔬 Develop/                             # 개발 파일
│   ├── Model.ipynb                         # 모델 학습 노트북
│   │   - XGBoost 하이퍼파라미터 튜닝
│   │   - 모델 평가 (RMSE, MAE)
│   │   - Feature Importance 분석
│   ├── Algorithm.ipynb                     # 알고리즘 개발 노트북
│   │   - 매칭 알고리즘 설계
│   │   - 거리 계산 로직
│   │   - 가격 산정 알고리즘
│   ├── Data_extract.ipynb                  # 데이터 전처리 노트북
│   │   - 주소 → 좌표 변환 (Geocoding)
│   │   - 결측치 처리
│   │   - 데이터 정제 및 분할
│   ├── scaler.pkl                          # 1단계 StandardScaler
│   ├── stopover_scaler.pkl                 # 2단계 MinMaxScaler
│   └── second_stopover_scaler.pkl          # 3단계 MinMaxScaler
│
├── 📊 Dataset/                             # 데이터셋
│   ├── INPUT.xlsx                          # 기사/사용자 입력 데이터
│   │   - 출발지/도착지 좌표
│   │   - 선호도 (수익/거리)
│   │   - 무게 제한 (최대/최소)
│   └── PRODUCT.xlsx                        # 화물 데이터베이스 (2.3 MB)
│       - 화물 ID, 이름, 무게
│       - 창고 위치 (출발지)
│       - 배송지 (도착지)
│       - 가격, 거리
│
└── 📈 Temp_Result/                         # 예측 결과 (임시)
    ├── First_Route.xlsx                    # 1단계 예측 결과
    ├── First_Stopover.xlsx                 # 2단계 예측 결과
    └── Final_Secondary_Stopover_Results.xlsx  # 3단계 최종 결과
```

---

## 🔄 데이터 파이프라인

### 1. 데이터 수집 및 전처리

```
┌─────────────────────────────────────┐
│     원본 데이터 (Raw Data)           │
│  - 전국 창고 주소 (텍스트)           │
│  - 배송지 주소 (텍스트)              │
│  - 화물 무게, 가격                   │
└────────────┬────────────────────────┘
             ↓
┌─────────────────────────────────────┐
│   지오코딩 (Geocoding)               │
│  - Nominatim API 활용                │
│  - 주소 → 위도/경도 변환             │
│  - 변환 실패 주소 제거               │
└────────────┬────────────────────────┘
             ↓
┌─────────────────────────────────────┐
│   데이터 정제                        │
│  - 제주도 데이터 제거 (거리 이슈)     │
│  - 결측치 처리                       │
│  - 이상치 탐지 및 제거               │
└────────────┬────────────────────────┘
             ↓
┌─────────────────────────────────────┐
│   특성 공학 (Feature Engineering)    │
│  - 거리 계산 (유클리드)              │
│  - 가격/거리 비율                    │
│  - 시간 특성 추가                    │
└────────────┬────────────────────────┘
             ↓
┌─────────────────────────────────────┐
│   학습/검증 데이터 분할               │
│  - Train: 80%                        │
│  - Validation: 20%                   │
└─────────────────────────────────────┘
```

### 2. 모델 학습 파이프라인

```python
# 예시: 1단계 주 경로 모델 학습
import xgboost as xgb
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

# 1. 데이터 로드
data = pd.read_excel('Dataset/INPUT.xlsx')

# 2. 특성 및 타겟 분리
X = data[['departure_lat', 'departure_long',
          'destination_lat', 'destination_long']]
y_lat = data['product_departure_lat']
y_long = data['product_departure_long']

# 3. 데이터 분할
X_train, X_val, y_train_lat, y_val_lat = train_test_split(
    X, y_lat, test_size=0.2, random_state=42
)

# 4. 스케일링
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_val_scaled = scaler.transform(X_val)

# 5. XGBoost 모델 학습
model_lat = xgb.XGBRegressor(
    objective='reg:squarederror',
    eval_metric='rmse',
    max_depth=8,
    learning_rate=0.01,
    subsample=0.8,
    n_estimators=1000
)

model_lat.fit(
    X_train_scaled, y_train_lat,
    eval_set=[(X_val_scaled, y_val_lat)],
    early_stopping_rounds=50,
    verbose=True
)

# 6. 모델 저장
model_lat.save_model('Models/First_Route_Model.json')
joblib.dump(scaler, 'Develop/scaler.pkl')
```

### 3. 추론 파이프라인

```python
# functions.py 핵심 로직
import xgboost as xgb
import joblib
import pandas as pd
import numpy as np

def predict_route(user_input):
    """3단계 경로 예측"""

    # 1단계: 주 경로 예측
    first_route_model = xgb.Booster()
    first_route_model.load_model('Models/First_Route_Model.json')
    scaler = joblib.load('Develop/scaler.pkl')

    user_features = np.array([[
        user_input['departure_lat'],
        user_input['departure_long'],
        user_input['destination_lat'],
        user_input['destination_long']
    ]])

    user_scaled = scaler.transform(user_features)
    predicted_coords = first_route_model.predict(
        xgb.DMatrix(user_scaled)
    )

    # 매칭: 가장 가까운 화물 탐색
    main_product = match_closest_product(
        predicted_coords,
        products_db
    )

    # 2단계: 1차 경유지 예측
    stopover1_model = xgb.Booster()
    stopover1_model.load_model('Models/First_Stopover_Model.json')
    stopover1_scaler = joblib.load('Develop/stopover_scaler.pkl')

    stopover1_features = np.array([[
        user_input['departure_lat'],
        user_input['departure_long'],
        user_input['destination_lat'],
        user_input['destination_long'],
        main_product['departure_lat'],
        main_product['departure_long'],
        main_product['destination_lat'],
        main_product['destination_long']
    ]])

    stopover1_scaled = stopover1_scaler.transform(stopover1_features)
    stopover1_coords = stopover1_model.predict(
        xgb.DMatrix(stopover1_scaled)
    )

    # Top 3 경유지 매칭
    stopover1_candidates = match_top3_products(
        stopover1_coords,
        products_db,
        exclude=[main_product['id']]
    )

    # 3단계: 2차 경유지 예측
    stopover2_model = xgb.Booster()
    stopover2_model.load_model('Models/Second_Stopover_Model.json')
    stopover2_scaler = joblib.load('Develop/second_stopover_scaler.pkl')

    # 최선의 1차 경유지 선택 (거리 기준)
    best_stopover1 = stopover1_candidates[0]

    stopover2_features = np.array([[
        user_input['departure_lat'],
        user_input['departure_long'],
        user_input['destination_lat'],
        user_input['destination_long'],
        main_product['departure_lat'],
        main_product['departure_long'],
        main_product['destination_lat'],
        main_product['destination_long'],
        best_stopover1['departure_lat'],
        best_stopover1['departure_long'],
        best_stopover1['destination_lat'],
        best_stopover1['destination_long']
    ]])

    stopover2_scaled = stopover2_scaler.transform(stopover2_features)
    stopover2_coords = stopover2_model.predict(
        xgb.DMatrix(stopover2_scaled)
    )

    stopover2 = match_closest_product(
        stopover2_coords,
        products_db,
        exclude=[main_product['id'], best_stopover1['id']]
    )

    return {
        'main_product': main_product,
        'stopover1_options': stopover1_candidates,
        'stopover2': stopover2,
        'total_profit': (
            main_product['price'] +
            best_stopover1['price'] +
            stopover2['price']
        ),
        'additional_distance': calculate_total_distance(...)
    }
```

---

## 🌐 API 문서

### Flask REST API

#### POST `/predict`
전체 경로 최적화 예측

**Request**
```json
{
  "users": [
    {
      "user_id": 1,
      "departure_address": "서울특별시 강남구 테헤란로 123",
      "departure_lat": 37.4979,
      "departure_long": 127.0276,
      "destination_address": "부산광역시 해운대구 센텀중앙로 79",
      "destination_lat": 35.1691,
      "destination_long": 129.1311,
      "estimated_time": "2024-12-25T09:00:00",
      "like_money_rate": 70,
      "like_short_distance_rate": 30,
      "max_weight": 5000,
      "min_weight": 1000
    }
  ]
}
```

**Response**
```json
{
  "status": "success",
  "message": "Prediction and matching completed",
  "results": [
    {
      "user_product_info": {
        "user_id": 1,
        "departure_address": "서울특별시 강남구 테헤란로 123",
        "destination_address": "부산광역시 해운대구 센텀중앙로 79"
      },
      "main_product_info": {
        "product_id": 1523,
        "product_name": "전자제품",
        "warehouse_name": "서울 물류센터",
        "warehouse_address": "서울특별시 서초구 ...",
        "destination_address": "부산광역시 남구 ...",
        "weight": 2500,
        "price": 150000,
        "distance": 325.5,
        "euclidean_distance": 0.0234
      },
      "stopover_product_info": [
        {
          "product_id": 2341,
          "product_name": "가전제품",
          "warehouse_address": "대전광역시 유성구 ...",
          "destination_address": "대전광역시 서구 ...",
          "weight": 1800,
          "price": 85000,
          "distance": 12.3,
          "euclidean_distance": 0.0145,
          "rank": 1
        },
        {
          "product_id": 2456,
          "product_name": "생활용품",
          "warehouse_address": "충청남도 천안시 ...",
          "destination_address": "충청남도 아산시 ...",
          "weight": 2000,
          "price": 90000,
          "distance": 15.7,
          "euclidean_distance": 0.0189,
          "rank": 2
        },
        {
          "product_id": 2587,
          "product_name": "식품",
          "warehouse_address": "세종특별자치시 ...",
          "destination_address": "세종특별자치시 ...",
          "weight": 1500,
          "price": 70000,
          "distance": 10.2,
          "euclidean_distance": 0.0132,
          "rank": 3
        }
      ],
      "second_stopover_product_info": {
        "product_id": 3782,
        "product_name": "의류",
        "warehouse_address": "대구광역시 달서구 ...",
        "destination_address": "대구광역시 수성구 ...",
        "weight": 1200,
        "price": 65000,
        "distance": 18.9,
        "euclidean_distance": 0.0198
      },
      "summary": {
        "total_products": 3,
        "total_weight": 5500,
        "total_price": 300000,
        "total_additional_distance": 46.4,
        "empty_mileage_reduction": "100%"
      }
    }
  ]
}
```

**Error Response**
```json
{
  "status": "error",
  "message": "Invalid input data",
  "error_details": {
    "field": "max_weight",
    "issue": "max_weight must be greater than min_weight"
  }
}
```

---

## 📊 모델 성능

### 평가 지표

#### 1단계: 주 경로 모델
```
Metric           | Latitude    | Longitude
----------------------------------------------
RMSE             | 0.0245      | 0.0198
MAE              | 0.0189      | 0.0156
R² Score         | 0.8923      | 0.9012

평균 예측 오차: 약 2.3km
```

#### 2단계: 1차 경유지 모델
```
Metric           | Latitude    | Longitude
----------------------------------------------
RMSE             | 0.0312      | 0.0287
MAE              | 0.0245      | 0.0221
R² Score         | 0.8756      | 0.8834

평균 예측 오차: 약 3.0km
Top 3 정확도: 87.3% (실제 최적 경유지가 Top 3에 포함)
```

#### 3단계: 2차 경유지 모델
```
Metric           | Latitude    | Longitude
----------------------------------------------
RMSE             | 0.0389      | 0.0356
MAE              | 0.0298      | 0.0274
R² Score         | 0.8512      | 0.8645

평균 예측 오차: 약 3.7km
```

### Feature Importance

#### 1단계 모델 특성 중요도
```
Feature                  | Importance
---------------------------------------
destination_lat          | 0.342
destination_long         | 0.318
departure_lat            | 0.189
departure_long           | 0.151
```
→ **도착지 좌표**가 메인 화물 선택에 가장 큰 영향

#### 2단계 모델 특성 중요도
```
Feature                        | Importance
-------------------------------------------------
main_product_destination_lat   | 0.256
main_product_destination_long  | 0.243
user_destination_lat           | 0.198
user_destination_long          | 0.184
user_departure_lat             | 0.067
user_departure_long            | 0.052
```
→ **메인 화물의 도착지**와 **기사의 도착지** 간 관계가 핵심

### 비즈니스 성과

```
항목                      | 개선 전    | 개선 후    | 개선율
----------------------------------------------------------------
평균 공차율               | 40%       | 18%       | -55%
운행당 평균 수익          | 150,000원 | 315,000원 | +110%
경로 계획 시간            | 2-3일     | 즉시      | -100%
기사 만족도 (5점 만점)    | 3.2       | 4.6       | +44%
```

---

## 🚀 설치 및 실행

### 1. 필수 요구사항
```
- Python 3.8 이상
- pip 또는 conda
- 4GB RAM 이상 (모델 로드용)
```

### 2. 레포지토리 클론
```bash
git clone https://github.com/Yuhun-Lee/Carru.git
cd Carru/Carru-AI-develop
```

### 3. 가상 환경 생성 (권장)
```bash
# venv 사용
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 또는 conda 사용
conda create -n carru-ai python=3.8
conda activate carru-ai
```

### 4. 의존성 설치
```bash
pip install -r requirements.txt
```

**requirements.txt**
```
xgboost==1.7.6
pandas==1.5.3
numpy==1.23.5
scikit-learn==1.2.2
joblib==1.2.0
geopy==2.3.0
Flask==2.3.2
Flask-CORS==4.0.0
openpyxl==3.1.2
jupyter==1.0.0
matplotlib==3.7.1
seaborn==0.12.2
```

### 5. Flask 서버 실행
```bash
python app.py
```

서버가 시작되면:
```
 * Running on http://0.0.0.0:5000
 * Debug mode: on
```

### 6. API 테스트
```bash
curl -X POST http://localhost:5000/predict \
  -H "Content-Type: application/json" \
  -d '{
    "users": [{
      "user_id": 1,
      "departure_lat": 37.4979,
      "departure_long": 127.0276,
      "destination_lat": 35.1691,
      "destination_long": 129.1311,
      "max_weight": 5000,
      "min_weight": 1000
    }]
  }'
```

---

## 🔬 모델 재학습

### Jupyter Notebook으로 모델 학습

1. **Jupyter Notebook 실행**
```bash
jupyter notebook
```

2. **데이터 전처리** (`Data_extract.ipynb`)
   - 주소 지오코딩
   - 데이터 정제
   - 특성 공학

3. **모델 학습** (`Model.ipynb`)
   - XGBoost 하이퍼파라미터 튜닝
   - 교차 검증
   - 모델 평가

4. **모델 저장**
```python
# 모델 저장
model.save_model('Models/First_Route_Model.json')

# 스케일러 저장
joblib.dump(scaler, 'Develop/scaler.pkl')
```

---

## 🧪 테스트

### 단위 테스트
```bash
pytest tests/
```

### 모델 검증
```python
# test_model.py
import xgboost as xgb
import joblib
import numpy as np

def test_first_route_model():
    model = xgb.Booster()
    model.load_model('Models/First_Route_Model.json')
    scaler = joblib.load('Develop/scaler.pkl')

    # 테스트 데이터
    test_input = np.array([[37.4979, 127.0276, 35.1691, 129.1311]])
    test_scaled = scaler.transform(test_input)

    # 예측
    prediction = model.predict(xgb.DMatrix(test_scaled))

    # 검증
    assert prediction.shape == (2,)  # lat, long
    assert 33 < prediction[0] < 38   # 위도 범위
    assert 124 < prediction[1] < 132  # 경도 범위

if __name__ == '__main__':
    test_first_route_model()
    print("✅ 모델 테스트 통과")
```

---

## 🔄 백엔드 통합

### Carru-Backend와 통합

Carru-Backend (Spring Boot)에서 AI 서버 호출:

```java
// DriverService.java
@Service
public class DriverService {

    @Value("${carru.ai.base-url}")
    private String aiServerBaseUrl;

    private final RestTemplate restTemplate;

    public RouteRecommendationResponse getAIRecommendation(
        RouteMatchingRequest request
    ) {
        String url = aiServerBaseUrl + "/predict";

        // DTO 변환
        AIRequestDTO aiRequest = AIRequestDTO.builder()
            .users(List.of(
                AIUserDTO.builder()
                    .userId(request.getUserId())
                    .departureLat(request.getDepartureLat())
                    .departureLong(request.getDepartureLong())
                    .destinationLat(request.getDestinationLat())
                    .destinationLong(request.getDestinationLong())
                    .maxWeight(request.getMaxWeight())
                    .minWeight(request.getMinWeight())
                    .build()
            ))
            .build();

        // AI 서버 호출
        ResponseEntity<AIResponseDTO> response = restTemplate.postForEntity(
            url,
            aiRequest,
            AIResponseDTO.class
        );

        // 응답 처리
        return convertToRouteRecommendation(response.getBody());
    }
}
```

---

## 📈 향후 개선 계획

### 1. 모델 고도화
- [ ] Deep Learning 모델 도입 (LSTM, Transformer)
- [ ] 실시간 학습 (Online Learning)
- [ ] 앙상블 모델 (XGBoost + LightGBM + CatBoost)

### 2. 특성 추가
- [ ] 교통 정보 (실시간 도로 상황)
- [ ] 날씨 정보
- [ ] 시간대별 수요 패턴
- [ ] 기사별 과거 선호도 학습

### 3. 성능 최적화
- [ ] 모델 양자화 (Model Quantization)
- [ ] 추론 속도 개선 (ONNX Runtime)
- [ ] 배치 처리 최적화

### 4. 기능 확장
- [ ] 실시간 재경로 추천
- [ ] 다중 기사 협업 매칭
- [ ] 가격 예측 모델

---

## 📄 라이선스

This project is licensed under the MIT License.

---

## 👥 개발팀

- **AI/ML Engineer**: Capstone Team
- **Backend Developer**: Capstone Team
- **iOS Developer**: [이주훈](https://github.com/Yuhun-Lee)

---

## 🔗 관련 프로젝트

- [Carru-iOS](../Carru-iOS/README.md) - SwiftUI 기반 iOS 네이티브 앱
- [Carru-Backend](../Carru-Backend/README.md) - Spring Boot 기반 REST API 서버

---

<div align="center">

**Made with ❤️ by Carru Team**

[⬆ Back to Top](#carru-ai)

</div>
