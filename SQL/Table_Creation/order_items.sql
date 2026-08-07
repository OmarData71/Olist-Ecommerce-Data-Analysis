create table order_items(
order_id varchar(50) primary key,
order_item_id int,
product_id varchar(50),
seller_id varchar(50),
shipping_limit_date DATETIME,
price decimal(10,2),
freight_value decimal (10,2)
);