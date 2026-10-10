--========================================================================================================================== =-- =
----------------------------------- Olist E-Commerce Business Analysis -----------------------------------------------
-- ==============================================================================================================================
-- Q1.How many total orders were placed on the Olist platform?
   select count(distinct(order_id)) from orders;



-- Q2. What is the total revenue generated from all orders?
   select sum(price) from order_items;


-- Q3. How many orders were successfully delivered?
   Select count(*) from orders 
   where order_status = 'delivered'


-- Q4. What percentage of total orders were successfully delivered?
    select count(case when order_status='delivered' then 1 end ) * 100 / count(order_status)
	from orders;


-- Q5. Which customers have placed more than 5 orders on the Olist platform?
    Select customer_id, count(*) as order_counts from orders
	group by customer_id
	having count(*)>5;


-- Q6. Which customers have spent more than ₹10,000 on products?
    Select cu.customer_id as "Customer with spending more then 10000",sum(op.payment_value)as Total_spending from customers cu Inner join orders o  
	on cu.customer_id = o.customer_id
	inner join order_payments op
	on o.order_id = op.order_id
	group by cu.customer_id
	having sum(op.payment_value)>10000
	order by Total_spending;




-- Q7.What is the average payment value per order?
   select avg(Total_payment) as average_value from
   (Select sum(payment_value)as Total_payment from order_payments
   Group by order_id) order_total; 



-- Q8. Which customers have an average payment value greater than ₹2,000 per order?
   Select customer_id  from 
   (Select o.customer_id, avg(op.payment_value) as average_payment
   from order_payments op  
   inner join orders o on 
    op.order_id=o.order_id
   Group by o.customer_id) orders
   where average_payment >2000; 

	

-- Q9.Which product categories have generated more than ₹100,000 in total product sales?
     Select pc.Product_category_name_english from product_category_translation pc 
	 inner join products p on
	 pc.Product_category_name=p.Product_category_name
	 inner join
	 order_items o on
	 p.product_id=o.product_id
	 group by pc.product_category_name
	 having sum(o.price)>100000;




-- Q10. Which payment types have an average payment value greater than ₹100?
       Select payment_type from order_payments
	   group by payment_type
	   having avg(payment_value)>100;



-- Q11.Find the top 5 customers by total payment value.
-- 1 Method
        Select c.customer_id,sum(op.payment_value) as total_payment From customers c join    
	   orders o 
	   on c.customer_id=o.customer_id
	   join order_payments op on
	   o.order_id=op.order_id
	   Group by c.customer_id
	   order by total_payment desc
	   limit 5;
	   
	   
-- 2 Method
	   select customer_id , Total_payment, payment_rank
	   from( select o.customer_id ,sum(op.payment_value) as Total_payment, 
	   dense_rank()over( order by sum(op.payment_value) desc ) 
       as payment_rank from orders o join order_payments op on
	   o.order_id=op.order_id
	   group by o.customer_id)
	   where payment_rank<=5
	      


-- Q12.customers whose total payment is greater than the average total payment spent by all customers.
       Select customer_id,Total_payment from
	   (select o.customer_id, sum(op.payment_value) as Total_payment from
	   orders o join order_payments op
	   on o.order_id=op.order_id
	   group by o.customer_id) customer_total
	   where Total_payment>(select  Avg(Total_payment) from(select o.customer_id,sum(op.payment_value) 
	   as Total_payment
	   from orders o join order_payments op
	   on o.order_id=op.order_id 
	   group by o.customer_id)customer_Totals);



-- Q13.Find customers who have placed more than 3 orders and whose total payment amount is greater than ₹5,000.

    SELECT o.customer_id,
       COUNT(o.order_id) AS total_orders,
       SUM(op.payment_value) AS total_payment
        FROM orders o
        JOIN order_payments op
        ON o.order_id = op.order_id
        GROUP BY o.customer_id
        HAVING COUNT(o.order_id) > 3
       AND SUM(op.payment_value) > 5000;


-- Q14.Find the top 10 customers based on their total payment amount.

with customer_payment AS(
           select o.customer_id ,sum(op.payment_value)Total_payment from
		   order_payments op join orders o
		   on op.order_id=o.order_id
		   group by o.customer_id
)

  select customer_id,Total_payment from
  (select customer_id,Total_payment,dense_rank() 
  over(order by Total_payment desc)payment_rank from 
  customer_payment)
  where payment_rank <=10;



  

  --Q15. Find the top 5 product categories by total sales revenue.

	With product_categories As(
      select pe.product_category_name_english,sum(oi.price) As Total_sales from
   product_category_translation pe join products p
   on  pe.product_category_name=p.product_category_name
   join order_items oi on
   p.product_id=oi.product_id
   group by pe.product_category_name_english
   
  )

select product_category_name_english ,Total_sales from
(select product_category_name_english ,Total_sales ,
dense_rank()over(order by Total_sales desc) As Top_rank 
from product_categories )
where Top_rank<=5;












--Q16. Which order statuses have the highest average delivery time?
   SELECT order_status,
       AVG(delivery_time_clean) AS average_delivery_time
FROM orders
WHERE delivery_time_clean IS NOT NULL
GROUP BY order_status
ORDER BY average_delivery_time DESC
LIMIT 1;





-- Q17.Which customers experienced the longest average delivery time,
--      considering only customers with at least 2 delivered orders?

   SELECT 
    customer_id,
    COUNT(order_id) AS delivered_orders,
    AVG(delivery_time_clean) AS average_delivery_time
    FROM orders
    WHERE order_status = 'delivered'
    AND delivery_time_clean IS NOT NULL
    GROUP BY customer_id
    HAVING COUNT(order_id) >= 2
    ORDER BY average_delivery_time DESC;





-- Q18.Which sellers have the highest average product price, 
-- considering only sellers who have sold at least 20 products?

   select seller_id, avg(price) from
   order_items
   group by seller_id
   having count(product_id)>=20
   order by avg(price) desc
   limit 1;




-- Q19.Which payment type contributes the highest percentage of total payment value?
       select payment_type, Sum(payment_value) as Total_payment_value ,sum(payment_value)*100.0
	   /(select sum(payment_value) from order_payments) as Total_payment_value_percentage
	   from order_payments
	   Group by payment_type
	   order by sum(payment_value) desc
	   limit 1;





-- Q20. What percentage of total revenue comes from the top 10 customers by total payment value?

WITH top_10 AS (
    SELECT 
        o.customer_id,
        SUM(op.payment_value) AS total_payment_value
    FROM orders o
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY o.customer_id
    ORDER BY SUM(op.payment_value) DESC
    LIMIT 10
)

SELECT
    SUM(total_payment_value) AS top_10_customer_revenue,
    (SELECT SUM(payment_value)
     FROM order_payments) AS total_revenue,
    SUM(total_payment_value) * 100.0 /
    (SELECT SUM(payment_value)
     FROM order_payments) AS percentage_of_total_revenue
FROM top_10;



--Q21. What was the total revenue generated in each month of 2018?

      SELECT  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
       SUM(oi.price) AS total_revenue
       FROM orders o
       JOIN order_items oi
        ON o.order_id = oi.order_id
       WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
      GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
       ORDER BY month;


-- Q22. What is the average order value for each month in 2018?
    SELECT
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    SUM(oi.price) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY month;



-- Q23. Which product categories have the highest average product price?
     SELECT
    pct.product_category_name_english AS category,
    AVG(oi.price) AS average_product_price,
    COUNT(oi.product_id) AS products_sold
     FROM product_category_translation pct
     JOIN products p
      ON pct.product_category_name = p.product_category_name
     JOIN order_items oi
     ON p.product_id = oi.product_id
     GROUP BY pct.product_category_name_english
     ORDER BY average_product_price DESC;



-- Q24. What is the cancellation rate for each month?
SELECT
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS canceled_orders,
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) * 100.0
        / COUNT(*) AS cancellation_rate
FROM orders
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY month;






-- Q25. Which states have the highest number of sellers?
    SELECT
    seller_state,
    COUNT(DISTINCT seller_id) AS total_sellers
    FROM sellers
    GROUP BY seller_state
     ORDER BY total_sellers DESC;





-- Q26. What is the average review score for each product category?
     SELECT
    pct.product_category_name_english AS category,
    AVG(orv.review_score) AS average_review_score,
    COUNT(orv.review_id) AS total_reviews
    FROM order_reviews orv
    JOIN orders o
    ON orv.order_id = o.order_id
    JOIN order_items oi
    ON o.order_id = oi.order_id
   JOIN products p
    ON oi.product_id = p.product_id
    JOIN product_category_translation pct
    ON p.product_category_name = pct.product_category_name
    GROUP BY pct.product_category_name_english
     ORDER BY average_review_score DESC;



-- Q27. Does longer delivery time correspond to lower review scores?
    SELECT
    orv.review_score,
    COUNT(*) AS total_orders,
    AVG(o.delivery_time_clean) AS average_delivery_time
    FROM orders o
    JOIN order_reviews orv
    ON o.order_id = orv.order_id
    WHERE o.delivery_time_clean IS NOT NULL
   GROUP BY orv.review_score
    ORDER BY orv.review_score;




-- Q28. Which sellers generated more than ₹50,000 in product sales?
    SELECT
    seller_id,
    SUM(price) AS total_sales,
    COUNT(product_id) AS products_sold
    FROM order_items
    GROUP BY seller_id
    HAVING SUM(price) > 50000
    ORDER BY total_sales DESC;





-- Q29. What percentage of orders were delivered within 30 days?
    SELECT
    COUNT(CASE
        WHEN delivery_time_clean <= 30 THEN 1
    END) * 100.0
    / COUNT(delivery_time_clean) AS delivered_within_30_days_percentage
     FROM orders
    WHERE delivery_time_clean IS NOT NULL;




-- Q30. For each year, what was the total revenue and number of orders?
SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue
   FROM orders o
   JOIN order_items oi
    ON o.order_id = oi.order_id
     GROUP BY EXTRACT(YEAR FROM o.order_purchase_timestamp)
     ORDER BY year;


--Q31. What percentage of actual customers placed more than one order?
      WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
     )
SELECT
    COUNT(CASE WHEN total_orders > 1 THEN 1 END) * 100.0
    / COUNT(*) AS repeat_customer_percentage
FROM customer_orders;




----------------------------------Month-over-Month Revenue Growth-----------------------------------------
--Q31. What was the monthly revenue in 2018, and how did revenue change compared with the previous month?
       WITH monthly_revenue AS (
    SELECT
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
        SUM(oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
    GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
)
SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    (total_revenue - LAG(total_revenue) OVER (ORDER BY month))
        * 100.0
        / LAG(total_revenue) OVER (ORDER BY month) AS revenue_growth_percentage
FROM monthly_revenue
ORDER BY month;

        




----------------------------------Top Category by Revenue in Each State-----------------------------------
-- Q33.For each customer state, which product category generated the highest revenue?
     WITH category_state_sales AS (
    SELECT
        c.customer_state,
        pct.product_category_name_english AS category,
        SUM(oi.price) AS total_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN product_category_translation pct
        ON p.product_category_name = pct.product_category_name
    GROUP BY
        c.customer_state,
        pct.product_category_name_english
     ),
     ranked_categories AS (
         SELECT
        customer_state,
        category,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY customer_state
            ORDER BY total_revenue DESC
        ) AS category_rank
    FROM category_state_sales
      )
    SELECT
    customer_state,
    category,
    total_revenue
    FROM ranked_categories
    WHERE category_rank = 1
    ORDER BY customer_state;





------------------------------Payment Installment Analysis-----------------------------------------------------

-- Q34. For each payment type, what are the average installments and average payment value?
        SELECT
    payment_type,
    AVG(payment_installments) AS average_installments,
    AVG(payment_value) AS average_payment_value
    FROM order_payments
    GROUP BY payment_type
    ORDER BY average_payment_value DESC;





-----------------------------Late Delivery Rate by Month-----------------------------------------------------
--Q35.For each month, what percentage of delivered orders took more than 30 days to deliver?
       SELECT
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(*) AS delivered_orders,
    COUNT(
        CASE
            WHEN delivery_time_clean > 30 THEN 1
        END
    ) AS late_orders,
    COUNT(
        CASE
            WHEN delivery_time_clean > 30 THEN 1
        END
    ) * 100.0 / COUNT(*) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered'
  AND delivery_time_clean IS NOT NULL
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY month;




---------------------------- First-Time Customer Revenue-----------------------------------------------------
--Q36. For each month, how many customers placed their first-ever order, and 
-- how much revenue came from those first orders?


WITH first_orders AS (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_order_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT fo.customer_unique_id) AS new_customers,
    SUM(oi.price) AS first_order_revenue
FROM first_orders fo
JOIN customers c
    ON fo.customer_unique_id = c.customer_unique_id
JOIN orders o
    ON c.customer_id = o.customer_id
    AND o.order_purchase_timestamp = fo.first_order_date
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY month;





------------------------------ High-Sales, High-Rated Sellers--------------------------------------------
--Q37.Which sellers generated more than 50,000 in product sales and had an average review score above 4?
   SELECT
    oi.seller_id,
    SUM(oi.price) AS total_sales,
    AVG(r.review_score) AS average_review_score
FROM order_items oi
JOIN order_reviews r
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING SUM(oi.price) > 50000
   AND AVG(r.review_score) > 4
ORDER BY total_sales DESC;



---------------------------- Category Cancellation Analysis ---------------------------------------------
-- Q38.For each product category, what percentage of its orders were canceled?
     SELECT
    pct.product_category_name_english AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(
        DISTINCT CASE
            WHEN o.order_status = 'canceled'
            THEN o.order_id
        END
    ) AS canceled_orders,
    COUNT(
        DISTINCT CASE
            WHEN o.order_status = 'canceled'
            THEN o.order_id
        END
    ) * 100.0 / COUNT(DISTINCT o.order_id) AS cancellation_rate
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY cancellation_rate DESC;


---------------------------------------Freight Cost Analysis----------------------------------------------
-- Q39.For each product category, 
-- what is the average freight cost and what percentage of product price does freight represent?
SELECT
    pct.product_category_name_english AS category,
    AVG(oi.freight_value) AS average_freight,
    SUM(oi.freight_value) * 100.0
        / SUM(oi.price) AS freight_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY freight_percentage DESC;


--------------------------------- Top 3 Customers in Each State------------------------------------
--Q40. For each customer state, who are the top 3 customers based on total payment?
       WITH customer_sales AS (
    SELECT
        c.customer_state,
        c.customer_unique_id,
        SUM(op.payment_value) AS total_payment
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        c.customer_state,
        c.customer_unique_id
),
ranked_customers AS (
    SELECT
        customer_state,
        customer_unique_id,
        total_payment,
        DENSE_RANK() OVER (
            PARTITION BY customer_state
            ORDER BY total_payment DESC
        ) AS customer_rank
    FROM customer_sales
)
SELECT
    customer_state,
    customer_unique_id,
    total_payment,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY customer_state, customer_rank;

