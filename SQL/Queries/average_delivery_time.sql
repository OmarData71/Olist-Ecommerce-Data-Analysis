
SELECT 
AVG(DATEDIFF(DAY,
order_purchase_timestamp,
order_delivered_customer_date))
FROM orders