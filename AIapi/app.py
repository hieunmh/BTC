from flask import Flask, request, jsonify
import pandas as pd
import requests
import os
from decision_tree import train_and_save_model as train_decision_tree, predict_new_data as predict_decision_tree
from bayes import train_and_save_model as train_bayes, predict_new_data as predict_bayes
from knn import train_and_save_model as train_knn, predict_new_data as predict_knn

app = Flask(__name__)

# Function to fetch stock data from Binance API
def fetch_stock_data(symbol, interval, limit):
    url = f"https://api.binance.com/api/v3/klines?symbol={symbol}&interval={interval}&limit={limit}"
    response = requests.get(url)
    data = response.json()
    df = pd.DataFrame(data, columns=['timestamp', 'Open', 'High', 'Low', 'Close', 'Volume', 'close_time', 'quote_asset_volume', 'number_of_trades', 'taker_buy_base_asset_volume', 'taker_buy_quote_asset_volume', 'ignore'])
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
    df.set_index('timestamp', inplace=True)
    df = df[['Open', 'High', 'Low', 'Close', 'Volume']].astype(float)
    return df

# Function to save or update stock data to CSV
def save_stock_data(df, filename='stock_data_test.csv'):
    if os.path.exists(filename):
        existing_df = pd.read_csv(filename, index_col='timestamp', parse_dates=True)
        df = pd.concat([existing_df, df])
        df = df[~df.index.duplicated(keep='last')]
    df.to_csv(filename)

@app.route('/fetch_and_save', methods=['GET'])
def fetch_and_save():
    symbol = request.args.get('symbol', 'BTCUSDT')
    interval = request.args.get('interval', '1d')
    limit = request.args.get('limit', 1000)
    df = fetch_stock_data(symbol, interval, limit)
    save_stock_data(df)
    return jsonify({"message": "Stock data fetched and saved successfully in file stock_data_test.csv."})

@app.route('/train_models', methods=['GET'])
def train_models():
    algo = request.args.get('algo', 'all')
    filename = request.args.get('filename', 'stock_data.csv')
    
    results = {}
    
    if algo == 'decision_tree' or algo == 'all':
        results['decision_tree_report'] = train_decision_tree(filename)[2]
    if algo == 'bayes' or algo == 'all':
        results['bayes_report'] = train_bayes(filename)[2]
    if algo == 'knn' or algo == 'all':
        results['knn_report'] = train_knn(filename)[2]
    
    return jsonify(results)

@app.route('/predict', methods=['GET'])
def predict():
    model_type = request.args.get('model', 'decision_tree')
    open_price = float(request.args.get('open'))
    high_price = float(request.args.get('high'))
    low_price = float(request.args.get('low'))
    close_price = float(request.args.get('close'))
    volume = float(request.args.get('volume', 1000000.0))

    if model_type == 'decision_tree':
        prediction = predict_decision_tree(open_price, high_price, low_price, close_price, volume)
    elif model_type == 'bayes':
        prediction = predict_bayes(open_price, high_price, low_price, close_price, volume)
    elif model_type == 'knn':
        prediction = predict_knn(open_price, high_price, low_price, close_price, volume)
    else:
        return jsonify({"error": "Invalid model type specified."}), 400

    return jsonify({"model": model_type, "prediction": prediction})

if __name__ == "__main__":
    app.run(port=8000, debug=True)
