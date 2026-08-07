create table order_reviev(
review_id varchar(50) ,
order_id varchar(50),
review_score Int,
review_comment_title text,
review_comment_message text,
review_creation_date DATETIME,
primary key(review_id,order_id)
);