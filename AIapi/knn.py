import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
def run(filename="stock_data.csv"):
    data = pd.read_csv(filename)

    # Feature Engineering: Calculate percentage change for the target
    data['Pct_Change'] = data['Close'].pct_change(periods=1) * 100
    threshold_buy = 2  # Buy if price expected to increase > 2%
    threshold_sell = -2  # Sell if price expected to decrease < -2%
    data['Target'] = data['Pct_Change'].apply(lambda x: 'Buy' if x > threshold_buy else ('Sell' if x < threshold_sell else 'Hold'))

    # Drop rows with NaN
    data.dropna(inplace=True)

    # Check class distribution
    print(data['Target'].value_counts())

    # Features and target
    features = ['Open', 'High', 'Low', 'Close', 'Volume']
    X = data[features]
    y = data['Target']

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Normalize data
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

    # Train KNN model
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(X_train, y_train)

    # Evaluate the model
    y_pred = knn.predict(X_test)
    return classification_report(y_test, y_pred, zero_division=0)

    # cm = confusion_matrix(y_test, y_pred)
    # plt.figure(figsize=(8, 6))
    # sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=knn.classes_, yticklabels=knn.classes_)
    # plt.title('Confusion Matrix')
    # plt.xlabel('Predicted Label')
    # plt.ylabel('True Label')
    # plt.show()

    # # New data for prediction (expect return buy)
    # new_data = pd.DataFrame({
    #     'Open': [150.0],
    #     'High': [155.0],
    #     'Low': [149.0],
    #     'Close': [154.0],
    #     'Volume': [500000]
    # })

    # # Normalize the new data
    # new_data_scaled = scaler.transform(new_data)

    # # Predict the target for the new data
    # new_prediction = knn.predict(new_data_scaled)
    # print(f"Prediction for new data: {new_prediction[0]}")


    # # New data for prediction with likely "Sell" condition
    # new_data_sell = pd.DataFrame({
    #     'Open': [200.0],
    #     'High': [210.0],
    #     'Low': [80.0],
    #     'Close': [85.0],  # Very low to ensure Sell
    #     'Volume': [1000000]
    # })
    # new_data_sell_scaled = scaler.transform(new_data_sell)
    # new_prediction_sell = knn.predict(new_data_sell_scaled)
    # print(f"Prediction for extreme Sell data: {new_prediction_sell[0]}")