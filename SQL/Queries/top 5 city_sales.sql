select top(5)
c.customer_city,
 SUM(op.payment_value) AS Total_Sales
from customers c
join orders  o
    on  c.customer_id=o.customer_id
join order_payments op
    on o.order_id =op.order_id
group by customer_city
order by Total_Sales desc;