import pandas as pd
import os




import os
data_path = "data"

# files = os.listdir(data_path)

# print("Files in data folder:")

# for file in files:
#     if file.endswith(".csv"):
#         print(file)

orders=pd.read_csv("data/olist_orders_dataset.csv")
print(orders.head()) #checking first 5 rows
print(orders.shape) # chcks number of rows and cloums
print(orders.columns)#check columns
print(orders.dtypes)#chck data types
print(orders.isnull().sum()) #chcking null values

print(orders["order_status"].value_counts())

print("Duplicate:",orders.duplicated().sum())

print('Unique order id:',orders['order_id'].nunique())


customers=pd.read_csv("data/olist_customers_dataset.csv")
print(customers.head())
print(customers.tail())
print(customers.shape)
print(customers.columns)
print(customers.dtypes)
print(customers.isnull().sum())
print("Duplicated rows:",customers.duplicated().sum())

print(customers["customer_id"].nunique())   
print(customers["customer_unique_id"].nunique())   


order_item=pd.read_csv("data/olist_order_items_dataset.csv")
print(order_item.head())
print(order_item.tail())
order_item.info()
print("Duplicated:",order_item.duplicated().sum())
print(order_item["order_item_id"].value_counts().sort_index())


product=pd.read_csv("data/olist_products_dataset.csv")
print(product.head())
print(product.tail())
product.info()
print("Duplicated:",product.duplicated().sum())
print("unique",product["product_id"].nunique())



payments = pd.read_csv("data/olist_order_payments_dataset.csv")

print(payments.head())
print(payments.tail())
payments.info()

print("Duplicates",payments.duplicated().sum())

print("Unique",payments["payment_type"].value_counts())
print("Unique orders in payments:", payments["order_id"].nunique())


reviews = pd.read_csv("data/olist_order_reviews_dataset.csv")

print(reviews.head())
print(reviews.tail())
reviews.info()
print("review",reviews["review_score"].value_counts())
print("Duplicates" ,reviews.duplicated().sum())


sellers = pd.read_csv("data/olist_sellers_dataset.csv")

print(sellers.head())
sellers.info()
print(sellers.isnull().sum())
print("Duplicate:",sellers.duplicated().sum())
print("unique:" ,sellers["seller_id"].nunique())
print(sellers.shape)
print(sellers.columns)



geolocation = pd.read_csv("data/olist_geolocation_dataset.csv")

print(geolocation.head())
geolocation.info()


print("Duplicate rows:", geolocation.duplicated().sum())
print(
    "Unique ZIP code prefixes:",
    geolocation["geolocation_zip_code_prefix"].nunique()
)


category_translation = pd.read_csv(
    "data/product_category_name_translation.csv"
)

print(category_translation.head())
print(category_translation.shape)
print("Duplicate rows:", category_translation.duplicated().sum())

print(
    "Unique Portuguese categories:",
    category_translation["product_category_name"].nunique()
)

print(
    "Unique English categories:",
    category_translation["product_category_name_english"].nunique()
)