SELECT TOP 10
    p.product_category_name,
    SUM(oi.price) AS Total_Sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Total_Sales DESC;