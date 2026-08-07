select c.customer_id,
(sum(op.payment_value)/count(DISTINCT o.order_id))as average_customer_salead
from customers c
join orders o
on c.customer_id=o.customer_id
join order_payments op
on o.order_id=op.order_id
group by c.customer_id
order by average_customer_salead desc;