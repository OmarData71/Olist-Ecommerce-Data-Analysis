WITH TotalSellerTy AS
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
        WHEN total_sales >= 10000 THEN 'High Seller'
        WHEN total_sales >= 5000 THEN 'Medium Seller'
        WHEN total_sales >= 1000 THEN 'Low Seller'
        ELSE 'Rejected'
    END AS seller_category
FROM TotalSellerTy
ORDER BY total_sales DESC;