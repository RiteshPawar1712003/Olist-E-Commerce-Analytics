# Olist E-Commerce Analytics

## Project Overview
This project analyzes Brazilian e-commerce data to understand sales performance, customer reviews, order trends, payment methods, and delivery performance. The goal is to extract meaningful business insights using data analysis and visualization tools.

## Tools & Technologies
- **Python:** Pandas, NumPy, Matplotlib, Seaborn
- **SQL:** PostgreSQL
- **Visualization:** Microsoft Power BI
- **Environment:** Jupyter Notebook, VS Code

## Project Workflow
1. **Data Collection:** Worked with the Brazilian Olist e-commerce dataset.
2. **Data Cleaning:** Inspected missing values, duplicates, data types, and delivery-time outliers using Python.
3. **Exploratory Data Analysis:** Explored orders, customers, products, payments, reviews, and delivery performance.
4. **SQL Analysis:** Used PostgreSQL queries to analyze business metrics, customer spending, order statuses, and delivery performance.
5. **Dashboard Development:** Built an interactive Power BI dashboard with KPI cards, charts, and slicers.

## Key Analysis Areas
- Monthly order trends
- Sales by customer state
- Customer review score distribution
- Payment method analysis
- Product category performance
- Order status and delivery performance





## Business Questions, Answers & Insights

### 1. How do order volumes change month over month?
**Answer:** Analyzed monthly order trends using Power BI.

**Business Insight:** Monthly trends help identify changes in demand and seasonal patterns.

### 2. Which customer states generate the highest sales?
**Answer:** Analyzed sales by customer state using Power BI.

**Business Insight:** Geographic sales analysis helps identify important regional markets.

### 3. What is the distribution of customer review scores?
**Answer:**
- 5 stars: 57,328
- 4 stars: 19,142
- 3 stars: 8,179
- 2 stars: 3,151
- 1 star: 11,424

**Business Insight:** Five-star reviews are the most common, followed by four-star reviews. Lower ratings can help identify opportunities to improve customer satisfaction.

### 4. Which payment methods are most commonly used?
**Answer:**
- Credit card: 76,795 payment records
- Boleto: 19,784
- Voucher: 5,775
- Debit card: 1,529
- Not defined: 3

**Business Insight:** Credit cards are the most frequently recorded payment method in the dataset.

### 5. Which product categories generate the highest revenue?
**Answer:** Investigated product category revenue using SQL and Power BI.

**Business Insight:** Category-level revenue analysis helps identify product segments that contribute to sales.

### 6. How are orders distributed across different statuses?
**Answer:**
- Delivered: 96,478
- Shipped: 1,107
- Canceled: 625
- Unavailable: 609
- Invoiced: 314
- Processing: 301
- Created: 5
- Approved: 2

**Business Insight:** Most orders have a delivered status. Canceled and unavailable orders are worth monitoring.

### 7. What is the average delivery time?
**Answer:** Approximately 27.54 days for valid records with delivery times under the selected 200-day threshold.

**Business Insight:** Delivery-time analysis helps evaluate fulfilment performance and identify opportunities to improve delivery speed.

### 8. Who are the highest-spending customers?
**Answer:** Analyzed customer spending and rankings using SQL.

**Business Insight:** Customer spending analysis can help identify high-value customers.

### 9. How does delivery time vary by order status?
**Answer:**
- Delivered orders: approximately 27.54 days on average.
- Canceled orders with valid delivery-time data: approximately 40.04 days on average.

**Business Insight:** Delivery-time comparisons require careful interpretation because canceled orders may not represent completed deliveries.

10. What percentage of orders were delivered?

Answer: Out of 99,441 orders, 96,478 were delivered, giving a delivered-order rate of approximately 97.02%.

Business Insight: The delivered-order rate provides a useful measure of order fulfilment performance. The remaining orders should be reviewed by status to understand cancellations, delays, and orders that were not completed.


## Business Insights

The analysis identified several useful patterns in the Olist e-commerce dataset:

- **Customer Reviews:** Five-star reviews were the most common, followed by four-star reviews.
- **Delivery Performance:** The average cleaned delivery time was approximately 27.54 days for records meeting the selected 200-day threshold.
- **Order Trends:** Monthly order trends help identify changes in order volume over time.
- **Geographic Sales:** Sales by customer state help identify important regional markets.
- **Payment Preferences:** Payment method analysis helps understand how customers pay for their orders.
- **Product Performance:** Product category analysis helps identify categories contributing to revenue.
- **Order Fulfilment:** Order status analysis helps evaluate delivery completion and identify canceled or unavailable orders.

These insights can support further investigation into customer satisfaction, regional sales performance, and delivery efficiency.


## Key Findings
- Five-star reviews were the most common review score in the dataset.
- Four-star reviews were the second most common.
- Delivery-time analysis showed an average cleaned delivery time of approximately 27.54 days for valid records under the selected 200-day threshold.

## Dashboard

### Page 1 — Sales & Order Analysis

![Olist Dashboard Page 1](screenshots/olist_dashboard_page1.png)

### Page 2 — Delivery & Payment Analysis

![Olist Dashboard Page 2](screenshots/olist_dashboard_page2.png)

## Project Structure
- `data/` — Dataset files
- `python/` — Data cleaning and exploratory analysis notebooks
- `sql/` — Database setup and SQL analysis scripts
- `powerbi/` — Power BI dashboard files
- `README.md` — Project documentation

## Conclusion
This project demonstrates practical skills in data cleaning, exploratory data analysis, SQL querying, KPI analysis, and interactive dashboard development to support data-driven business decisions.



## Dataset

This project uses the Brazilian E-Commerce Public Dataset by Olist.

**Source:** [Kaggle — Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Download the dataset from Kaggle and place the CSV files in the project's `data/` directory before running the Python notebooks or importing the data into PostgreSQL.

The original dataset files are not included in this repository.
