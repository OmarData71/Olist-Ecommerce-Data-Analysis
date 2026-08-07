SELECT
    YEAR(o.order_purchase_timestamp) AS sales_year,
    SUM(op.payment_value) AS total_sales
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY sales_year;