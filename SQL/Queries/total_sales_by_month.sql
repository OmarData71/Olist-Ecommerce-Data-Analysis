select 
MONTH(o.order_purchase_timestamp) as sales_by_month,
sum(op.payment_value) as total_sales
from orders o
join order_payments op
on o.order_id =op.order_id
group by MONTH(o.order_purchase_timestamp) 
order by  sales_by_month ;