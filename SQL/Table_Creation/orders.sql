create table orders(
order_id varchar(50) primary key,
customer_id varchar(50),
order_status VARCHAR(20),	
order_purchase_timestamp DATETIME ,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME
);
