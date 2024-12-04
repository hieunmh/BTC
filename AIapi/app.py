from flask import Flask, jsonify, request
import pandas as pd
import requests
import os
from decision_tree import run as run_decision_tree
from bayes import run as run_bayes
from knn import run as run_knn

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
def save_stock_data(df, filename='stock_data.csv'):
    if os.path.exists(filename):
        existing_df = pd.read_csv(filename, index_col='timestamp', parse_dates=True)
        df = pd.concat([existing_df, df])
        df = df[~df.index.duplicated(keep='last')]
    df.to_csv(filename)

@app.route('/fetch_and_save', methods=['GET'])
def fetch_and_save():
    symbol = request.args.get('symbol', 'BTCUSDT')
    interval = request.args.get('interval', '1d')
    limit = int(request.args.get('limit', 100))
    df = fetch_stock_data(symbol, interval, limit)
    save_stock_data(df, 'stock_data_test.csv')
    return jsonify({"message": "Stock data fetched and saved successfully."})

@app.route('/train_models', methods=['GET'])
def train_models():
    algo = request.args.get('algo', 'all')
    filename = "stock_data_test.csv"
    
    results = {}
    
    if algo == 'decision_tree' or algo == 'all':
        results['decision_tree_report'] = run_decision_tree(filename)
    if algo == 'bayes' or algo == 'all':
        results['bayes_report'] = run_bayes(filename)
    if algo == 'knn' or algo == 'all':
        results['knn_report'] = run_knn(filename)
    
    return jsonify(results)

if __name__ == '__main__':
    app.run(port=8000, debug=True)