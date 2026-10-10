-- ============================================================
-- OLIST E-COMMERCE ANALYTICS
-- TABLE CREATION & CONSTRAINTS
-- ============================================================


-- ============================================================
-- 1. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- Primary Key
ALTER TABLE customers
ADD PRIMARY KEY (customer_id);


-- ============================================================
-- 2. SELLERS
-- ============================================================

CREATE TABLE sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(100)
);

-- Primary Key
ALTER TABLE sellers
ADD PRIMARY KEY (seller_id);


-- ============================================================
-- 3. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght NUMERIC,
    product_description_lenght NUMERIC,
    product_photos_qty NUMERIC,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC,
    product_weight_valid BOOLEAN
);


-- ============================================================
-- 4. ORDERS
-- ============================================================

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    orders_sequence_valid BOOLEAN,
    delivery_time_valid BOOLEAN,
    total_delivery_time NUMERIC,
    delivery_time_clean NUMERIC
);

-- Primary Key
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- Foreign Key
ALTER TABLE orders
ADD FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);


-- ============================================================
-- 5. ORDER ITEMS
-- ============================================================

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,

    -- Composite Primary Key
    PRIMARY KEY (order_id, order_item_id),

    -- Foreign Keys
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
);


-- ============================================================
-- 6. ORDER PAYMENTS
-- ============================================================

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value NUMERIC,

    -- Composite Primary Key
    PRIMARY KEY (order_id, payment_sequential),

    -- Foreign Key
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


-- ============================================================
-- 7. ORDER REVIEWS
-- ============================================================

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,

    -- Foreign Key
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


-- ============================================================
-- 8. GEOLOCATION
-- ============================================================

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);


-- ============================================================
-- 9. PRODUCT CATEGORY TRANSLATION
-- ============================================================

CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);


-- ============================================================
-- END OF TABLE CREATION
-- ============================================================