import pandas as pd
import pickle
import numpy as np

train_df = pd.read_csv('datax.csv')
train_df.info()
# =============================================================================
# train_df= train_df.dropna()
# =============================================================================
train_df = train_df.drop(columns=['Loan_ID', 'Education']) ## Dropping Loan ID
pickle.dump(train_df, open('feature.pickle', 'wb'))

column_names=list(train_df.columns)

categorical_columns = ['Gender', 'Married', 'Dependents', 'Self_Employed', 'Property_Area','Credit_History','Loan_Amount_Term']
#categorical_columns = ['Gender', 'Married', 'Dependents', 'Education', 'Self_Employed', 'Property_Area','Loan_Amount_Term']
numerical_columns = ['ApplicantIncome', 'CoapplicantIncome', 'LoanAmount']
bina=['Gender', 'Married', 'Self_Employed', 'Credit_History']
multi=['Dependents', 'Property_Area', 'Loan_Amount_Term']

from sklearn.impute import SimpleImputer
imputer = SimpleImputer(missing_values=np.NaN, strategy= 'most_frequent')
imputer = imputer.fit(pd.DataFrame(train_df))
train_df = pd.DataFrame(imputer.transform(train_df))

train_df.columns=column_names

from sklearn.preprocessing import LabelEncoder, OneHotEncoder

enc = OneHotEncoder(sparse=False).fit(train_df.loc[:, multi])
pickle.dump(enc, open('one_hot_encoder.pickle', 'wb'))

column_names = enc.get_feature_names(multi)
encoded_variables = pd.DataFrame(enc.transform(train_df.loc[:, multi]), columns=column_names)
train_df = train_df.drop(multi, 1)
train_df = pd.concat([train_df, encoded_variables], axis=1)

z = train_df['Loan_Status']

train_df = train_df.drop('Loan_Status', 1)

train_df = pd.concat([train_df, z], axis = 1)

train_df = train_df.dropna()

labelencoder_X = LabelEncoder()
train_df['Gender'] = labelencoder_X = labelencoder_X.fit(train_df['Gender'])

pickle.dump(labelencoder_X, open('gender_encoder.pickle', 'wb'))

labelencoder_X1 = LabelEncoder()
train_df['Married'] = labelencoder_X1 = labelencoder_X1.fit(train_df['Married'])

pickle.dump(labelencoder_X1, open('married_encoder.pickle', 'wb'))

labelencoder_X2 = LabelEncoder()
train_df['Self_Employed'] = labelencoder_X2 = labelencoder_X2.fit(train_df['Self_Employed'])

pickle.dump(labelencoder_X2, open('employed_encoder.pickle', 'wb'))

labelencoder_X3 = LabelEncoder()
train_df['Credit_History'] = labelencoder_X3 = labelencoder_X3.fit(train_df['Credit_History'])

pickle.dump(labelencoder_X3, open('credit_encoder.pickle', 'wb'))

labelencoder_X4 = LabelEncoder()
train_df['Loan_Status'] = labelencoder_X4 = labelencoder_X4.fit(train_df['Loan_Status'])

pickle.dump(labelencoder_X4, open('status_encoder.pickle', 'wb'))

#### Encoding categrical Features: ##########
X = train_df.iloc[:, :-1].values
y = train_df.iloc[:, 24:25].values

#### splitting ####
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0 )

#### scaling ####
# =============================================================================
# from sklearn.preprocessing import StandardScaler
# sc_X = StandardScaler()
# X_train = sc_X.fit_transform(X_train)
# X_test = sc_X.transform(X_test)
# sc_y = StandardScaler()
# y_train = sc_y.fit_transform(y_train)
# =============================================================================

####  Model  ####
from xgboost import XGBClassifier
classifier = XGBClassifier()
classifier.fit(X_train, y_train)

pickle.dump(classifier, open('model.pickle', 'wb'))

y_pred = classifier.predict(X_test)

from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)

# Applying k-Fold Cross Validation
from sklearn.model_selection import cross_val_score
accuracies = cross_val_score(estimator = classifier, X = X_train, y = y_train, cv = 10)
accuracies.mean()
accuracies.std()











