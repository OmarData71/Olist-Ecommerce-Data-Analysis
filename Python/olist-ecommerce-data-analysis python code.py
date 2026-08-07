# -*- coding: utf-8 -*-
"""
Created on Tue Jun 30 15:21:55 2026

@author: s
"""

import pandas as pd
import numpy as np
from sqlalchemy import create_engine
customers =pd.read_csv(r"F:\download  data base\archive\olist_customers_dataset.csv")
geo = pd.read_csv(r"F:\download  data base\archive\olist_geolocation_dataset.csv")
order_items =pd.read_csv(r"F:\download  data base\archive\olist_order_items_dataset.csv")
order_payments=pd. read_csv(r"F:\download  data base\archive\olist_order_payments_dataset.csv")
order_reviews=pd.read_csv(r"F:\download  data base\archive\olist_order_reviews_dataset.csv")
orders =pd .read_csv(r"F:\download  data base\archive\olist_orders_dataset.csv")
products = pd.read_csv(r"F:\download  data base\archive\olist_products_dataset.csv")
sellers=pd.read_csv(r"F:\download  data base\archive\olist_sellers_dataset.csv")
products_category_name=pd.read_csv(r"F:\\download  data base\archive\product_category_name_translation.csv")

datasets={
    "customers":customers,
    "geo":geo,
    "order_items":order_items,
    "order_payments":order_payments,
    "order_reviews":order_reviews,
     "orders":orders,
     "sellers":sellers,
     "products":products,
     "products_category_name":products_category_name
    
    }                             
for name, df in datasets.items():
    print("="*30)
    print(name)
    print(df.info())
    print(df.isnull().sum())
    print(df.duplicated().sum())

print(geo[geo.duplicated()].head())
geo.drop_duplicates(inplace=True)
print(geo.isnull().sum())
geo.reset_index(drop=True,inplace=True)
print("duplicated rows",geo.duplicated().sum())
order_items["shipping_limit_date"]=pd.to_datetime(order_items["shipping_limit_date"])

order_reviews["review_comment_title"]=(order_reviews["review_comment_title"].fillna("no title"))
order_reviews["review_comment_message"]=(order_reviews["review_comment_message"].fillna("no comment"))
order_reviews["review_creation_date"]=pd.to_datetime(order_reviews["review_creation_date"])
order_reviews["review_answer_timestamp"]=pd.to_datetime(order_reviews["review_answer_timestamp"])
print(orders["order_status"].value_counts())
order_payments.rename(
    columns={"payment_sequential": "order_sequential"},
    inplace=True
)
dates_cols=[
    "order_purchase_timestamp",
    "order_approved_at",
    "order_delivered_carrier_date",
    "order_delivered_customer_date",
    "order_estimated_delivery_date",]
    
for col in dates_cols:
    orders[col]=pd.to_datetime(orders[col])
print(orders.dtypes)
products.dropna(inplace=True)
products.reset_index(drop=True, inplace=True)
print(products.isnull().sum())
print(products.duplicated().sum())
print(geo["geolocation_code"].dtype)
engine = create_engine(
    "mssql+pyodbc://@DESKTOP-20ANCJQ/Olist_Project 1?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)
print(order_items.shape)
print(order_items.head())
print(products.shape)
tables = [
    ("customers", customers),
    ("products_category_name", products_category_name),
    ("products", products),
    ("sellers", sellers),
    ("orders", orders),
    ("order_items", order_items),
    ("order_payments", order_payments),
    ("order_reviews", order_reviews),
    ("geo", geo)
]


for table_name, df in tables:
    try:
        df.to_sql(table_name, engine, if_exists="append", index=False)
        print(f"{table_name} imported successfully")
    except Exception as e:
        print(f"Error importing {table_name}")
        print(e)

from sqlalchemy import create_engine

engine = create_engine(
    "mssql+pyodbc://@DESKTOP-20ANCJQ/Olist_Project 1?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)

try:
    order_items.to_sql(
        "order_items",
        engine,
        if_exists="append",
        index=False
    )
    print("Imported Successfully")
except Exception as e:
    print(e)


