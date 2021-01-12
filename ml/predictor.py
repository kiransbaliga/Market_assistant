import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
import pickle
from sklearn.model_selection import train_test_split
import os

model = pickle.load(open(os.path.join(os.path.abspath(os.path.dirname(__file__)), "model.pkl"),'rb'))
"""Quality - Brand - Price - Offers (on scale from 1-3, both inclusive)
    the values of quality,brand price and offers must be changed accordingly from the survey!!!

"""
quality=1 #less quality prefferd
brand=3   #local brand
price=1     #lower price
offers=1    #no or little offers
res=model.predict([[quality,brand,price,offers]])
print(res)
shopping=[]
if res == 'ClassA':
    #add items to class a: high quality and brand products price not matter
    shopping=["add item"]
if res == 'ClassB':
    #add items for class b:Must be brand nothing else matters
    shopping=["add item"]
if res == 'ClassC':
    #add items for class c: product with offer only and cheop
    shopping=["add item"]
if res == 'ClassD':
    #add items for class d: everything in balance small offers + medium quality + know brand + medium price 
    shopping=["add item"]
if res == 'ClassE':
    #add items for class e: Quality mukhyam best rated product only
    shopping=["add item"]
print("done")