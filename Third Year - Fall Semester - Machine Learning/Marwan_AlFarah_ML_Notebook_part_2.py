# -*- coding: utf-8 -*-
"""Marwan_AlFarah_ML_Notebook_part_2.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/19pF1vqrXNVXcmR-Y8oCXGu9ZReXt6L-R

<br>

<center><img src="https://www.htu.edu.jo/images/ThumbnailsCoverPhotos/HTU%20Logo-250px.png" alt="HTU"  width="180px" align="center">


<br>

<p>

**Machine Learning**

10204350

H/618/7438

Section (1)

**Assignment 2 ML Project**

**Submitted to**

Dr. Rami Al Ouran

**Submitted on**

January 30th, 2024

**Submitted by**

Marwan Tarek Shafiq Al Farah

**Student ID**

21110011

Fall 2023 – 2024
</p></center>

# **Importing Libraries**
"""

import pandas as pd
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix

"""# **Loading the Dataset**"""

df = pd.read_csv('Occupancy_Estimation.csv')
df

"""# **EDA**"""

df.describe()

df.info()

"""With the use of df.info() and df.describe(), statistical summaries for each sensor's readings, including mean, standard deviation, minimum and maximum values, and various percentiles, provide a foundational understanding of the data's distribution and variability. Also, they also helped us identify the data types of each feature, along with checking for any null values."""

sns.countplot(data = df, x = 'Room_Occupancy_Count')
plt.show()

"""We used a bar chart to visualize out target variable “Room Occupancy Count”, and found out that the dataset is imbalanced, and that most data points are when the count was 0."""

sns.pairplot(df.drop(['Date', 'Time'], axis = 1), hue = "Room_Occupancy_Count")
plt.show()

"""As can be seen from this pairplot, most of the points are scattered randomly, but S1_temp, S2_temp, and S4_temp seem to have a near linear relationship. Additionally, in a chart that has any combination of 2 of these three sensors, we can see that a lower reading on both of the sensors, usually indicated a less occupied room."""

DateTime_Before = pd.to_datetime(df[df['Date'] <= '2017/12/26']['Date'] + ' ' + df[df['Date'] <= '2017/12/26']['Time'])
DateTime_After = pd.to_datetime(df[df['Date'] > '2017/12/26']['Date'] + ' ' + df[df['Date'] > '2017/12/26']['Time'])

plt.figure(figsize=(10, 6))
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S1_Temp'], label = 'S1_Temp')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S2_Temp'], label = 'S2_Temp')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S3_Temp'], label = 'S3_Temp')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S4_Temp'], label = 'S4_Temp')
plt.xlabel('Date and Time')
plt.ylabel('°C')
plt.title('Temperature over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S1_Temp'], label = 'S1_Temp')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S2_Temp'], label = 'S2_Temp')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S3_Temp'], label = 'S3_Temp')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S4_Temp'], label = 'S4_Temp')
plt.xlabel('Date and Time')
plt.ylabel('°C')
plt.title('Temperature over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

"""These charts confirm our conclusion from the pairplot, as we can see S1_temp, S3_temp and S4_temp being very close to each other, while S2_temp having very different results from the other 3 of them."""

plt.figure(figsize=(10, 6))
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S1_Light'], label = 'S1_Light')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S2_Light'], label = 'S2_Light')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S3_Light'], label = 'S3_Light')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S4_Light'], label = 'S4_Light')
plt.xlabel('Date and Time')
plt.ylabel('Light')
plt.title('Light over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S1_Light'], label = 'S1_Light')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S2_Light'], label = 'S2_Light')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S3_Light'], label = 'S3_Light')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S4_Light'], label = 'S4_Light')
plt.xlabel('Date and Time')
plt.ylabel('Light')
plt.title('Light over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S1_Sound'], label = 'S1_Sound')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S2_Sound'], label = 'S2_Sound')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S3_Sound'], label = 'S3_Sound')
plt.plot(DateTime_Before, df[df['Date'] <= '2017/12/26']['S4_Sound'], label = 'S4_Sound')
plt.xlabel('Date and Time')
plt.ylabel('Sound')
plt.title('Sound over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S1_Sound'], label = 'S1_Sound')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S2_Sound'], label = 'S2_Sound')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S3_Sound'], label = 'S3_Sound')
plt.plot(DateTime_After, df[df['Date'] > '2017/12/26']['S4_Sound'], label = 'S4_Sound')
plt.xlabel('Date and Time')
plt.ylabel('Sound')
plt.title('Sound over Time')
plt.xticks(rotation=45)
plt.grid(True)
plt.legend()
plt.show()

"""As can be seen from both the light and sound sensors, they do not have a strong correlation between each other, and we cannot draw any conclusions based on their behaviors."""

sns.heatmap(df.drop(['Date', 'Time'], axis = 1).corr())
plt.show()

"""The correlation heatmap further confirms that the strongest correlation in the features can be observed between S1_temp and S3_temp, followed by S1_temp and S4_temp along with S3_temp and S4_temp.

# **Data Preprocessing**
"""

X = df.drop('Room_Occupancy_Count', axis = 1)
y = df['Room_Occupancy_Count']

X['Time'] = X['Time'].apply(lambda x: np.dot(np.array(list(map(int, x.split(':')))), np.array([3600, 60, 1])))

label_encoder = LabelEncoder()
X['Date'] = label_encoder.fit_transform(X['Date'])

scaler = StandardScaler()
X = scaler.fit_transform(X)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42)

"""# **Function for Model Evaluation**"""

def evaluate_predictions(y_true, y_pred, average = 'macro'):
    return accuracy_score(y_true, y_pred), precision_score(y_true, y_pred, average = average), recall_score(y_true, y_pred, average = average), f1_score(y_true, y_pred, average = average)

"""# **Machine Learning Models**

## **Random Forest**
"""

rf_params = {
    'n_estimators': [20, 50, 100],
    'max_features': ['sqrt', 'log2', None],
    'max_depth': [4, 6, 8],
    'criterion': ['gini', 'entropy']
}

rf_model = RandomForestClassifier()
rf_grid = GridSearchCV(estimator=rf_model, param_grid=rf_params, cv=5, verbose=3)
rf_grid.fit(X_train, y_train)
rf_predictions_test = rf_grid.best_estimator_.predict(X_test)
rf_metrics_test = evaluate_predictions(y_test, rf_predictions_test)
rf_predictions_train = rf_grid.best_estimator_.predict(X_train)
rf_metrics_train = evaluate_predictions(y_train, rf_predictions_train)

print("Best parameters for Random Forest:", rf_grid.best_params_)
print()
print("Random Forest Metrics (Accuracy, Precision, Recall, F1):", rf_metrics_test)
print("Random Forest Train Metrics (Accuracy, Precision, Recall, F1):", rf_metrics_train)
print()
print("Confusion Martix:\n")
print(confusion_matrix(y_test, rf_predictions_test))

"""## **XGBoost**"""

xgb_params = {
    'learning_rate': [0.01, 0.1, 0.2],
    'max_depth': [4, 6, 8],
    'min_child_weight': [1, 2, 3],
    'n_estimators': [20, 50, 100]
}

xgb_model = XGBClassifier(use_label_encoder=False, eval_metric='logloss')
xgb_grid = GridSearchCV(estimator=xgb_model, param_grid=xgb_params, cv=5, verbose=3)
xgb_grid.fit(X_train, y_train)
xgb_predictions_test = xgb_grid.best_estimator_.predict(X_test)
xgb_metrics_test = evaluate_predictions(y_test, xgb_predictions_test)
xgb_predictions_train = xgb_grid.best_estimator_.predict(X_train)
xgb_metrics_train = evaluate_predictions(y_train, xgb_predictions_train)

print("Best parameters for XGBoost:", xgb_grid.best_params_)
print()
print("XGBoost Metrics (Accuracy, Precision, Recall, F1):", xgb_metrics_test)
print("XGBoost Train Metrics (Accuracy, Precision, Recall, F1):", xgb_metrics_train)
print()
print("Confusion Martix:\n")
print(confusion_matrix(y_test, xgb_predictions_test))

"""## **Gradient Boosting**"""

gb_params = {
    'n_estimators': [20, 50, 100],
    'learning_rate': [0.01, 0.1, 0.2],
    'max_depth': [3, 5, 7]
}

gb_model = GradientBoostingClassifier()
gb_grid = GridSearchCV(estimator=gb_model, param_grid=gb_params, cv=5, verbose=3)
gb_grid.fit(X_train, y_train)
gb_predictions_test = gb_grid.best_estimator_.predict(X_test)
gb_metrics_test = evaluate_predictions(y_test, gb_predictions_test)
gb_predictions_train = gb_grid.best_estimator_.predict(X_train)
gb_metrics_train = evaluate_predictions(y_train, gb_predictions_train)

print("Best parameters for Gradient Boosting:", gb_grid.best_params_)
print()
print("Gradient Boosting Metrics (Accuracy, Precision, Recall, F1):", gb_metrics_test)
print("Gradient Boosting Train Metrics (Accuracy, Precision, Recall, F1):", gb_metrics_train)
print()
print("Confusion Martix:\n")
print(confusion_matrix(y_test, gb_predictions_test))

"""## **SVM**"""

svm_params = {
    'C': [0.1, 1, 10],
    'gamma': [10, 1, 0.1, 0.01],
    'kernel': ['rbf', 'poly', 'linear']
}

svm_model = SVC()
svm_grid = GridSearchCV(estimator=svm_model, param_grid=svm_params, cv=5, verbose=3)
svm_grid.fit(X_train, y_train)
svm_predictions_test = svm_grid.best_estimator_.predict(X_test)
svm_metrics_test = evaluate_predictions(y_test, svm_predictions_test)
svm_predictions_train = svm_grid.best_estimator_.predict(X_train)
svm_metrics_train = evaluate_predictions(y_train, svm_predictions_train)

print("Best parameters for SVM:", svm_grid.best_params_)
print()
print("SVM Metrics (Accuracy, Precision, Recall, F1):", svm_metrics_test)
print("SVM Train Metrics (Accuracy, Precision, Recall, F1):", svm_metrics_train)
print()
print("Confusion Martix:\n")
print(confusion_matrix(y_test, svm_predictions_test))

"""# **Final Values**"""

final_values_test = pd.DataFrame({'Random Forest': rf_metrics_test,
                             'XGBoost':xgb_metrics_test,
                             'Gradient Boosting':gb_metrics_test,
                             'SVM Metrics':svm_metrics_test},
                            index = ['Accuracy', 'Precision', 'Recall', 'F1 Score'])
final_values_test

final_values_train = pd.DataFrame({'Random Forest': rf_metrics_train,
                             'XGBoost':xgb_metrics_train,
                             'Gradient Boosting':gb_metrics_train,
                             'SVM Metrics':svm_metrics_train},
                            index = ['Accuracy', 'Precision', 'Recall', 'F1 Score'])
final_values_train

for j, i in enumerate([rf_grid.best_params_, xgb_grid.best_params_, gb_grid.best_params_, svm_grid.best_params_]):
  print(final_values_train.columns[j])
  print(pd.Series(i.values(), index = i.keys()))
  print()