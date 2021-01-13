import pandas as pd
import numpy as np
import os

def get_recommendations(id):
    # orders = pd.read_csv("Data/productinfo.csv")
    orders = pd.read_csv(os.path.join(os.path.abspath(os.path.dirname(__file__)), "Data/productinfo.csv"))
    
    
    Orderproduct = orders[orders.product_id == id].order_id.unique()
    orderstoberecommended = orders[orders.order_id.isin(Orderproduct)]
    productsthataccompany = orderstoberecommended[orderstoberecommended.product_id != id]
    instanceofproductsthataccompany = productsthataccompany.groupby("product_id")["product_id"].count().reset_index(name="instances")
    numordersforproduct = Orderproduct.size
    instancesofproduct = pd.DataFrame(instanceofproductsthataccompany)
    instancesofproduct["frequency"] = instancesofproduct["instances"]/numordersforproduct    
    recommended_products = pd.DataFrame(instancesofproduct.sort_values("frequency", ascending=False).head(3))
    products = pd.read_csv(os.path.join(os.path.abspath(os.path.dirname(__file__)), "Data/productinfo.csv"))
    recommended_products = pd.merge(recommended_products, products, on="product_id")
    return recommended_products.to_json(orient="table")

""" import this file and use get_recommendations(id) function to get customers who bought this also bought --- products are random actually in test data set so result may not make sense """