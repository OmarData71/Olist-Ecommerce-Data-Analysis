select top(1)
o.customer_id,
sum(op.payment_value)as Total_Spent
from orders o
join order_payments op
   on o.order_id=op.order_id
group by customer_id
order by Total_Spent desc