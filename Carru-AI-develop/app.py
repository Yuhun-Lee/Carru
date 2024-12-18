from flask import Flask, request, jsonify
from functions import predict_and_match_all, results_with_product_info
import os, json
import pandas as pd
from collections import OrderedDict

app = Flask(__name__)
OUTPUT_FOLDER = 'output'

@app.route('/predict', methods=['POST'])
def predict_from_json():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"status": "error", "message": "No JSON data provided"}), 400

        input_df = pd.DataFrame(data)
        if input_df.empty:
            return jsonify({"status": "error", "message": "JSON data is empty or invalid"}), 400

        results_df = predict_and_match_all(input_df)
        final_results_df = results_with_product_info(input_df, results_df)

        final_results_json = [
            OrderedDict([
                ('user_product_info', row['user_product_info']),
                ('main_product_info', row['main_product_info']),
                ('stopover_product_info', row['stopover_product_info']),
                ('second_stopover_product_info', row['second_stopover_product_info'])
            ])
            for _, row in final_results_df.iterrows()
        ]

        response_json = {
            "status": "success",
            "message": "Prediction and matching completed",
            "results": final_results_json
        }

        return app.response_class(
            response=json.dumps(response_json, ensure_ascii=False, default=str),  # JSON 순서 유지
            status=200,
            mimetype='application/json'
        )

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500


if __name__ == '__main__':
    app.run('0.0.0.0', port=5000, debug=True)
