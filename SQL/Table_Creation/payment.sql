create table payment(
order_id varchar(50) ,
payment_sequential int,
payment_type varchar(50),
payment_installments int,	
payment_value decimal(10,2),
PRIMARY KEY (order_id, payment_sequential)
);
