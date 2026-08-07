select  top (10) o.customer_id ,
sum(op.payment_value) as best10_customers_sales
from orders o
join order_payments op 
  on o .order_id= op.order_id
group by customer_id
order by  best10_customers_sales desc;