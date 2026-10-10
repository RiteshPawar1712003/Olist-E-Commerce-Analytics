```sql
-- ============================================================
-- OLIST E-COMMERCE ANALYTICS
-- DATA IMPORT
-- ============================================================
-- NOTE:
-- These commands document the CSV import process.
-- Do NOT execute them again if the data is already imported.
-- ============================================================


-- ============================================================
-- 1. CUSTOMERS
-- ============================================================

\copy customers
FROM 'C:/path/to/data/olist_customers_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 2. SELLERS
-- ============================================================

\copy sellers
FROM 'C:/path/to/data/olist_sellers_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 3. PRODUCTS
-- ============================================================

\copy products
FROM 'C:/path/to/data/olist_products_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 4. ORDERS
-- ============================================================

\copy orders
FROM 'C:/path/to/data/olist_orders_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 5. ORDER ITEMS
-- ============================================================

\copy order_items
FROM 'C:/path/to/data/olist_order_items_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 6. ORDER PAYMENTS
-- ============================================================

\copy order_payments
FROM 'C:/path/to/data/olist_order_payments_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 7. ORDER REVIEWS
-- ============================================================

\copy order_reviews
FROM 'C:/path/to/data/olist_order_reviews_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 8. GEOLOCATION
-- ============================================================

\copy geolocation
FROM 'C:/path/to/data/olist_geolocation_dataset.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- 9. PRODUCT CATEGORY TRANSLATION
-- ============================================================

\copy product_category_translation
FROM 'C:/path/to/data/product_category_name_translation.csv'
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- END OF DATA IMPORT
-- ============================================================
```
