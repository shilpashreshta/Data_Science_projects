# Employee Attrition Prediction
## Overview
This project aims to predict employee attrition using machine learning models, helping organizations to proactively address the factors contributing to employee turnover. The project includes data preprocessing, exploratory data analysis, model building, and evaluation. The best-performing models are used to provide actionable insights that can assist HR teams in making data-driven decisions.

## Objective
- Predict employee attrition based on features such as job satisfaction, overtime, monthly income, and more.
- Identify the key factors influencing employee attrition and provide insights that could help reduce turnover.

## Dataset
The dataset contains employee details such as:
- Demographics: Age, Gender, Marital Status
- Job-related information: Job Role, Department, Job Satisfaction, Work-life balance
- Compensation: Monthly Income, Salary Hike, Stock Option Level
- Performance: Total Working Years, Years at Company, Training Times

## Project Steps
### 1. Data Cleaning & Preprocessing
- Dropped columns with single unique values (e.g., EmployeeCount, StandardHours).
- Handled categorical variables using Label Encoding for machine learning model compatibility.
- Balanced the dataset using RandomOverSampler to address the class imbalance between employees who left (Yes) and those who didn’t (No).
### 2. Exploratory Data Analysis (EDA)
- Analyzed the relationships between various features and employee attrition using Seaborn plots.
- Key visualizations included the relationships of OverTime, JobSatisfaction, DistanceFromHome, JobLevel, and more with attrition.
- Heatmap analysis showed correlations among the numerical features.
### 3. Feature Engineering
- Selected important features influencing attrition, such as OverTime, JobInvolvement, and MaritalStatus.
- Applied Logistic Regression to find significant predictors of employee attrition.
### 4. Model Building
Several machine learning models were tested:
- Logistic Regression
- Decision Tree
- Random Forest
- Support Vector Classifier (SVC)
- K-Nearest Neighbors (KNN)
- XGBoost
- LightGBM
### 5. Model Evaluation
- Evaluation metrics included Accuracy, Precision, Recall, and F1-Score.
- The model with the best performance was XGBoost with:
- Accuracy: 87%
- Precision: 0.92 for non-attrition, 0.66 for attrition
- Recall: 0.67 for attrition
- F1-score: 0.67
- The LightGBM model also performed competitively with similar results but slightly lower precision and recall.

### 6. Hyperparameter Tuning
- Conducted RandomizedSearchCV for XGBoost and LightGBM to find the optimal parameters.
- Fine-tuned the LightGBM and XGBoost models, improving accuracy and recall.

### Tools & Libraries
- Python for scripting and analysis.
- Pandas, NumPy for data manipulation.
- Seaborn, Matplotlib for data visualization.
- Scikit-learn for machine learning algorithms.
- XGBoost, LightGBM for advanced models.
- Statsmodels for statistical analysis in logistic regression.

### Results
- The best model, XGBoost, provided an accuracy of 87% on the test set, with key insights into the features that contribute to employee attrition.
- Features such as OverTime, JobInvolvement, and Marital Status were identified as significant predictors of attrition.
- This analysis provides HR departments with insights to retain employees by addressing these factors.

### Conclusion
The XGBoost and LightGBM models successfully predicted employee attrition with high accuracy and provided key insights into the factors that influence an employee’s decision to leave. These models can be integrated into HR systems to monitor employee satisfaction and prevent turnover.
