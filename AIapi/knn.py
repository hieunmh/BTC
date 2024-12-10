import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn as sns
import joblib
import os

def train_and_save_model(filename="stock_data.csv"):
    # Load dataset
    data = pd.read_csv(filename)

    # Feature Engineering: Calculate percentage change for the target
    data['Pct_Change'] = data['Close'].pct_change(periods=1) * 100
    threshold_buy = 2  # Buy if price expected to increase > 2%
    threshold_sell = -2  # Sell if price expected to decrease < -2%
    data['Target'] = data['Pct_Change'].apply(lambda x: 'Buy' if x > threshold_buy else ('Sell' if x < threshold_sell else 'Hold'))

    # Drop rows with NaN (due to pct_change calculation)
    data.dropna(inplace=True)

    # Check class distribution
    print(data['Target'].value_counts())

    # Features and target
    features = ['Open', 'High', 'Low', 'Close', 'Volume']
    X = data[features]
    y = data['Target']

    # Split data into training and test sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Normalize the data (scaling the features)
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

    # Train KNN model
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(X_train, y_train)

    # Create models directory if it doesn't exist
    if not os.path.exists('models'):
        os.makedirs('models')

    # Save the model and scaler
    joblib.dump(knn, 'models/knn_model.pkl')
    joblib.dump(scaler, 'models/scaler.pkl')

    # Evaluate the model
    y_pred = knn.predict(X_test)

    # Print classification report
    print(classification_report(y_test, y_pred, zero_division=0))
    
    # # Plot confusion matrix
    # cm = confusion_matrix(y_test, y_pred)
    # plt.figure(figsize=(8, 6))
    # sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=knn.classes_, yticklabels=knn.classes_)
    # plt.title('Confusion Matrix')
    # plt.xlabel('Predicted Label')
    # plt.ylabel('True Label')
    # plt.show()
    
    return knn, scaler, classification_report(y_test, y_pred, zero_division=0)

def load_or_train_model(filename="stock_data.csv"):
    if os.path.exists('models/knn_model.pkl') and os.path.exists('models/scaler.pkl'):
        # Load the model and scaler
        knn = joblib.load('models/knn_model.pkl')
        scaler = joblib.load('models/scaler.pkl')
        print("Model and scaler loaded from file.")
    else:
        # Train the model and save it
        knn, scaler, rp = train_and_save_model(filename)
        print("Model and scaler trained and saved.")
    return knn, scaler

def predict_new_data(open, high, low, close, volume):
    # Load or train the model and scaler
    knn, scaler = load_or_train_model()

    # Normalize the new data
    new_data = pd.DataFrame({
        'Open': [float(open)],
        'High': [float(high)],
        'Low': [float(low)],
        'Close': [float(close)],
        'Volume': [float(volume)]
    })
    new_data_scaled = scaler.transform(new_data)
    
    # Make prediction
    prediction = knn.predict(new_data_scaled)
    return prediction[0]

if __name__ == "__main__":
    train_and_save_model(filename="stock_data.csv")
    print(predict_new_data(12.5, 12.8, 12.3, 28.8, 15))
    print(predict_new_data(12.5, 12.8, 12.3, 9.93, 15))