WITH TotalSalesByMonth AS
(
    SELECT
        MONTH(shipping_limit_date) AS month_sales,
        SUM(price) AS total_month_sales
    FROM order_items
    GROUP BY MONTH(shipping_limit_date)
)

SELECT
    month_sales,
    total_month_sales,
    LAG(total_month_sales) OVER (ORDER BY month_sales) AS previous_month_sales,
    total_month_sales -
    LAG(total_month_sales) OVER (ORDER BY month_sales) AS difference
FROM TotalSalesByMonth;