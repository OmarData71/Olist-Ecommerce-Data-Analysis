CREATE VIEW vw_best_customer AS
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
GO

CREATE VIEW vw_category_sales AS
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name;
GO

CREATE VIEW vw_city_sales AS
SELECT
    c.customer_city,
    SUM(op.payment_value) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY c.customer_city;
GO

CREATE VIEW vw_seller_sales AS
SELECT
    seller_id,
    SUM(price) AS total_sales
FROM order_items
GROUP BY seller_id;
GO

CREATE VIEW vw_customer_spending AS
SELECT
    o.customer_id,
    SUM(op.payment_value) AS total_spent
FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY o.customer_id;
GO

CREATE VIEW vw_total_sales_by_year AS
SELECT
    YEAR(o.order_purchase_timestamp) AS sales_year,
    SUM(op.payment_value) AS total_sales
FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY YEAR(o.order_purchase_timestamp);
GO

CREATE VIEW vw_total_sales_by_month AS
SELECT
    MONTH(o.order_purchase_timestamp) AS sales_month,
    SUM(op.payment_value) AS total_sales
FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY MONTH(o.order_purchase_timestamp);
GO

CREATE VIEW vw_delayed_orders AS
SELECT
    order_id,
    CAST(order_delivered_customer_date AS DATE) AS delivered_date,
    CAST(order_estimated_delivery_date AS DATE) AS estimated_date,
    CASE
        WHEN CAST(order_delivered_customer_date AS DATE) >
             CAST(order_estimated_delivery_date AS DATE)
        THEN 'Late'
        ELSE 'On Time'
    END AS order_status
FROM orders;
GO

CREATE VIEW vw_repeat_customers AS
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>1;
GO

CREATE VIEW vw_seller_sales_classification AS
WITH TotalSeller AS
(
    SELECT
        seller_id,
        SUM(price) AS total_sales
    FROM order_items
    GROUP BY seller_id
)
SELECT
    seller_id,
    total_sales,
    CASE
        WHEN total_sales>=10000 THEN 'High Seller'
        WHEN total_sales>=5000 THEN 'Medium Seller'
        WHEN total_sales>=1000 THEN 'Low Seller'
        ELSE 'Rejected'
    END AS seller_category
FROM TotalSeller;
GO

CREATE VIEW vw_month_over_month_comparison AS
WITH TotalSalesByMonth AS
(
    SELECT
        MONTH(shipping_limit_date) AS sales_month,
        SUM(price) AS total_sales
    FROM order_items
    GROUP BY MONTH(shipping_limit_date)
)
SELECT
    sales_month,
    total_sales,
    LAG(total_sales) OVER(ORDER BY sales_month) AS previous_month_sales,
    total_sales -
    LAG(total_sales) OVER(ORDER BY sales_month) AS difference
FROM TotalSalesByMonth;
GO

CREATE VIEW vw_average_customer_lifetime_spending AS
SELECT
    c.customer_id,
    SUM(op.payment_value)*1.0/COUNT(DISTINCT o.order_id) AS average_customer_spending
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY c.customer_id;
GO

CREATE VIEW vw_average_delivery_time AS
SELECT
AVG(DATEDIFF(DAY,
order_purchase_timestamp,
order_delivered_customer_date))
AS average_delivery_days
FROM orders;
GO