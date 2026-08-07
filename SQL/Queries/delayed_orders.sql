SELECT
    order_id,
    CAST(order_delivered_customer_date AS DATE) AS delivered_date,
    CAST(order_estimated_delivery_date AS DATE) AS estimated_date,
    CASE
        WHEN CAST(order_delivered_customer_date AS DATE)
             = CAST(order_estimated_delivery_date AS DATE)
             THEN 'In Time'

        WHEN CAST(order_delivered_customer_date AS DATE)
             > CAST(order_estimated_delivery_date AS DATE)
             THEN 'Late'

        ELSE 'Early'
    END AS order_status
FROM orders
WHERE CAST(order_delivered_customer_date AS DATE)
      > CAST(order_estimated_delivery_date AS DATE);
