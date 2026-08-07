select top(10) seller_id, 
sum(price)as total_seller_sealed
from order_items
group by seller_id
order by total_seller_sealed desc ;