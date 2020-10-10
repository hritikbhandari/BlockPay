import pickle
import numpy as np
from pydantic import BaseModel
import pandas as pd
# Server
import uvicorn
from fastapi import FastAPI

from xgboost import XGBClassifier

app = FastAPI()

clf = pickle.load(open('model.pickle', 'rb'))
features = pickle.load(open('feature.pickle', 'rb'))
lgender = pickle.load(open('gender_encoder.pickle', 'rb'))
lmarried = pickle.load(open('married_encoder.pickle', 'rb'))
lemployed = pickle.load(open('employed_encoder.pickle', 'rb'))
lcredit = pickle.load(open('credit_encoder.pickle', 'rb'))
lstatus = pickle.load(open('status_encoder.pickle', 'rb'))
hotenc = pickle.load(open('one_hot_encoder.pickle', 'rb'))

class Data(BaseModel):
    Gender: int
    Married: int
    Self_Employed: int
    ApplicantIncome:  int
    CoapplicantIncome: float
    LoanAmount: float
    Credit_history: float
    Dependents: int
    Property_Area: int 
    Loan_Amount_Term: str
    
    
@app.route('/predict', methods=['POST'])
def predict(data :Data):
    data_dict = data.dict()
    to_predict = [data_dict[feature] for feature in features]
    encoded_features = list(enc.transform(np.array(to_predict[-3:]).reshape(1, -1))[0])
    to_predict = np.array(to_predict[:-3] + encoded_features)
# =============================================================================
#     to_predict['Gender'] = lgender.transform(to_predict['Gender'])
#     to_predict['Married'] = lmarried.transform(to_predict['Married'])
#     to_predict['Self_Employed'] = lemployed.transform(to_predict['Self_employed'])
#     to_predict['Credit_history'] = lcredit.transform(to_predict['Credit_history'])
# =============================================================================
    prediction = clf.predict(to_predict.reshape(1, -1))
    
    return {"prediction": int(prediction[0])}
    
# =============================================================================
# import requests
# to_predict_dict = {
#     'Gender': 1,
#     'Married': 0,
#     'Self_Employed': 1,
#     'ApplicantIncome':  110,
#     'CoapplicantIncome': 200,
#     'LoanAmount': 200,
#     'Credit_history': 0,
#     'Dependents':2 ,
#     'Property_Area': 'Urban',
#     'Loan_Amount_Term': 120
#     }
# 
# url = 'http://127.0.0.1:8000/predict'
# r = requests.post(url,json=to_predict_dict); r.json()
# =============================================================================
    
    

    
    
    
    
    
    
    
    
    
    