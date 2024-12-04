from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report, ConfusionMatrixDisplay, confusion_matrix
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
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

    # Train Decision Tree model
    clf = DecisionTreeClassifier(random_state=42)
    clf.fit(X_train, y_train)

    # Evaluate the model
    y_pred = clf.predict(X_test)
    return classification_report(y_test, y_pred, zero_division=0)

    # # Plot confusion matrix
    # cm = confusion_matrix(y_test, y_pred, labels=clf.classes_)
    # plt.figure(figsize=(8, 6))
    # sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=clf.classes_, yticklabels=clf.classes_)
    # plt.title('Confusion Matrix')
    # plt.xlabel('Predicted Label')
    # plt.ylabel('True Label')
    # plt.show()

    # # Check feature importance
    # feature_importances = pd.Series(clf.feature_importances_, index=features)
    # print(feature_importances)

    # # Prediction for new data
    # new_data = pd.DataFrame({
    #     'Open': [150.0],
    #     'High': [155.0],
    #     'Low': [50],
    #     'Close': [0.0],  # Close is 0
    #     'Volume': [500000]
    # })

    # new_data_scaled = scaler.transform(new_data)
    # new_prediction = clf.predict(new_data_scaled)
    # print(f"Prediction for new data: {new_prediction[0]}")