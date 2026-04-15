Create database olist_db;
Use olist_db;

/* Using Load Data INFILE Command */
Show variables like 'secure_file_priv';
USE olist_db;

-- 1. Customers Raw
CREATE TABLE customers_raw (
    customer_id TEXT, customer_unique_id TEXT,
    customer_zip_code_prefix TEXT, customer_city TEXT, customer_state TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 2. Sellers Raw
CREATE TABLE sellers_raw (
    seller_id TEXT, seller_zip_code_prefix TEXT,
    seller_city TEXT, seller_state TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE sellers_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 3. Products Raw
CREATE TABLE products_raw (
    product_id TEXT, product_category_name TEXT,
    product_name_length TEXT, product_description_length TEXT,
    product_photos_qty TEXT, product_weight_g TEXT,
    product_length_cm TEXT, product_height_cm TEXT, product_width_cm TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 4. Category Translation Raw
CREATE TABLE category_translation_raw (
    product_category_name TEXT,
    product_category_name_english TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE category_translation_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 5. Orders Raw
CREATE TABLE orders_raw (
    order_id TEXT, customer_id TEXT, order_status TEXT,
    order_purchase_timestamp TEXT, order_approved_at TEXT,
    order_delivered_carrier_date TEXT, order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 6. Order Items Raw
CREATE TABLE order_items_raw (
    order_id TEXT, order_item_id TEXT, product_id TEXT,
    seller_id TEXT, shipping_limit_date TEXT,
    price TEXT, freight_value TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 7. Payments Raw
CREATE TABLE order_payments_raw (
    order_id TEXT, payment_sequential TEXT,
    payment_type TEXT, payment_installments TEXT,
    payment_value TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE order_payments_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 8. Reviews Raw
CREATE TABLE order_reviews_raw (
    review_id TEXT, order_id TEXT, review_score TEXT,
    review_comment_title TEXT, review_comment_message TEXT,
    review_creation_date TEXT, review_answer_timestamp TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 9. Geolocation Raw
CREATE TABLE geolocation_raw (
    geolocation_zip_code_prefix TEXT, geolocation_lat TEXT,
    geolocation_lng TEXT, geolocation_city TEXT, geolocation_state TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
INTO TABLE geolocation_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

DROP TABLE order_reviews_raw;

CREATE TABLE order_reviews_raw (
    review_id TEXT, order_id TEXT, review_score TEXT,
    review_comment_title TEXT, review_comment_message TEXT,
    review_creation_date TEXT, review_answer_timestamp TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews_raw 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

DROP TABLE order_reviews_raw;

CREATE TABLE order_reviews_raw (
    review_id TEXT, order_id TEXT, review_score TEXT,
    review_comment_title TEXT, review_comment_message TEXT,
    review_creation_date TEXT, review_answer_timestamp TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews_raw 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM order_reviews_raw;

SELECT table_name, table_rows 
FROM information_schema.tables 
WHERE table_schema = 'olist_db';

Rename table customers_raw to customers;
Rename table geolocation_raw to geolocation;
Rename table order_items_raw to order_items;
Rename table order_payments_raw to orders_payments;
Rename table order_reviews_raw to order_review;
Rename table orders_raw to orders;
Rename table products_raw to products;
Rename table sellers_raw to sellers;

Drop table customers;
Drop table olist_customers_dataset;

Rename table category_translation_raw to category;


/* DATA CLEANING*/-- Checking for null values

Desc customers;

Select count(*) as total_rows, 
sum( case when customer_id is null then 1 else 0 end ) as null_customer_id,
sum( case when customer_unique_id is null then 1 else 0 end ) as null_customer_unique_id,
sum( case when customer_zip_code_prefix is null then 1 else 0 end ) as null_customer_zipcode,
sum( case when customer_city is null then 1 else 0 end ) as null_customer_city,
sum( case when customer_state is null then 1 else 0 end ) as null_customer_state
from customers;

Select count(*) as total_rows, 
sum( case when customer_id ='' then 1 else 0 end ) as null_customer_id,
sum( case when customer_unique_id ='' then 1 else 0 end ) as null_customer_unique_id,
sum( case when customer_zip_code_prefix ='' then 1 else 0 end ) as null_customer_zipcode,
sum( case when customer_city ='' then 1 else 0 end ) as null_customer_city,
sum( case when customer_state ='' then 1 else 0 end ) as null_customer_state
from customers;

Select customer_id, count(*) from customers
group by customer_id
having count(*) > 1;


Desc orders;

Select count(*) as total_rows,
sum( case when order_id is null then 1 else 0 end ) as null_orderID,
sum( case when customer_id is null then 1 else 0 end ) as null_customerID,
sum( case when order_status is null then 1 else 0 end ) as null_orderStatus,
sum( case when order_purchase_timestamp is null then 1 else 0 end ) as null_orderTimestamp,
sum( case when order_approved_at is null then 1 else 0 end ) as null_orderApprovad_at,
sum( case when order_delivered_carrier_date is null then 1 else 0 end ) as null_orderCarrier_date,
sum( case when order_delivered_customer_date is null then 1 else 0 end ) as null_order_delivered_customer_date,
sum( case when order_estimated_delivery_date is null then 1 else 0 end ) as null_order_estimated_delivery_date
from orders;

Select count(*) as total_rows,
sum( case when order_id ='' then 1 else 0 end ) as null_orderID,
sum( case when customer_id = '' then 1 else 0 end ) as null_customerID,
sum( case when order_status = '' then 1 else 0 end ) as null_orderStatus,
sum( case when order_purchase_timestamp = '' then 1 else 0 end ) as null_orderTimestamp,
sum( case when order_approved_at = '' then 1 else 0 end ) as null_orderApprovad_at,
sum( case when order_delivered_carrier_date = '' then 1 else 0 end ) as null_orderCarrier_date,
sum( case when order_delivered_customer_date = '' then 1 else 0 end ) as null_order_delivered_customer_date,
sum( case when order_estimated_delivery_date = '' then 1 else 0 end ) as null_order_estimated_delivery_date
from orders;

Select order_id, count(*) from orders
group by order_id
having count(*) > 1;

Select count(*),
sum( case when order_purchase_timestamp = '0000-00-00 00:00:00' then 1 else 0 end) as invalid_purchase_timestamp,
sum( case when order_approved_at = '0000-00-00 00:00:00' then 1 else 0 end) as invalid_approve,
sum( case when order_delivered_carrier_date = '0000-00-00 00:00:00' then 1 else 0 end) as invalid_carrierDate,
sum( case when order_delivered_customer_date = '0000-00-00 00:00:00' then 1 else 0 end) as invalid_Customer_date,
sum( case when order_estimated_delivery_date = '0000-00-00 00:00:00' then 1 else 0 end) as invalid_estimated_delivery_date
from orders;

Desc order_items;

select count(*) as total_rows,
sum(case when order_id is null then 1 else 0 end) as null_orderID,
sum(case when order_item_id is null then 1 else 0 end) as null_orderItemID,
sum(case when product_id is null then 1 else 0 end) as null_productID,
sum(case when seller_id is null then 1 else 0 end) as null_sellerID,
sum(case when shipping_limit_date is null then 1 else 0 end) as null_shippingLimitDate,
sum(case when price is null then 1 else 0 end) as null_price,
sum(case when freight_value is null then 1 else 0 end) as null_freightValue
from order_items;

select count(*) as total_rows,
sum(case when order_id ='' then 1 else 0 end) as null_orderID,
sum(case when order_item_id ='' then 1 else 0 end) as null_orderItemID,
sum(case when product_id ='' then 1 else 0 end) as null_productID,
sum(case when seller_id ='' then 1 else 0 end) as null_sellerID,
sum(case when shipping_limit_date ='' then 1 else 0 end) as null_shippingLimitDate,
sum(case when price='' then 1 else 0 end) as null_price,
sum(case when freight_value ='' then 1 else 0 end) as null_freightValue
from order_items;

Select order_id, order_item_id, count(*) from order_items
group by order_id,order_item_id
having count(*) > 1;

Select shipping_limit_date, count(*) from order_items
where shipping_limit_date = '0000-00-00 00:00:00';

Desc products;

Select count(*) as total_rows,
sum(case when product_id is null then 1 else 0 end) as null_productID,
sum(case when product_category_name is null then 1 else 0 end) as null_category_name,
sum(case when product_description_length is null then 1 else 0 end) as null_Description,
sum(case when product_height_cm is null then 1 else 0 end) as null_productHeight,
sum(case when product_length_cm is null then 1 else 0 end) as null_productLength,
sum(case when product_name_length is null then 1 else 0 end) as null_productName,
sum(case when product_photos_qty is null then 1 else 0 end) as null_productPhotos,
sum(case when product_weight_g is null then 1 else 0 end) as null_productWeight,
sum(case when product_width_cm is null then 1 else 0 end) as null_productwidth
from products;

Select count(*) as total_rows,
sum(case when product_id ='' then 1 else 0 end) as null_productID,
sum(case when product_category_name ='' then 1 else 0 end) as null_category_name,
sum(case when product_description_length ='' then 1 else 0 end) as null_Description,
sum(case when product_height_cm ='' then 1 else 0 end) as null_productHeight,
sum(case when product_length_cm ='' then 1 else 0 end) as null_productLength,
sum(case when product_name_length ='' then 1 else 0 end) as null_productName,
sum(case when product_photos_qty ='' then 1 else 0 end) as null_productPhotos,
sum(case when product_weight_g ='' then 1 else 0 end) as null_productWeight,
sum(case when product_width_cm ='' then 1 else 0 end) as null_productwidth
from products;

select product_id, count(*) from products
group by product_id
having count(*) > 1;


Desc sellers;

select count(*) as total_rows,
sum(case when seller_id is null then 1 else 0 end ) as null_sellerID,
sum(case when seller_zip_code_prefix is null then 1 else 0 end ) as null_Zip,
sum(case when seller_city is null then 1 else 0 end ) as null_city,
sum(case when seller_state is null then 1 else 0 end ) as null_state
from sellers;

select count(*) as total_rows,
sum(case when seller_id ='' then 1 else 0 end ) as null_sellerID,
sum(case when seller_zip_code_prefix ='' then 1 else 0 end ) as null_Zip,
sum(case when seller_city ='' then 1 else 0 end ) as null_city,
sum(case when seller_state ='' then 1 else 0 end ) as null_state
from sellers;

select seller_id, count(*) from sellers
group by seller_id
having count(*) > 1;

Desc orders_payments;

select count(*) as total_rows,
sum(case when order_id is null then 1 else 0 end) as null_orderID,
sum(case when payment_sequential is null then 1 else 0 end) as null_sequebtial,
sum(case when payment_type is null then 1 else 0 end) as null_type,
sum(case when payment_installments is null then 1 else 0 end) as null_installments,
sum(case when payment_value is null then 1 else 0 end) as null_value
from orders_payments;

select count(*) as total_rows,
sum(case when order_id ='' then 1 else 0 end) as null_orderID,
sum(case when payment_sequential ='' then 1 else 0 end) as null_sequebtial,
sum(case when payment_type ='' then 1 else 0 end) as null_type,
sum(case when payment_installments ='' then 1 else 0 end) as null_installments,
sum(case when payment_value ='' then 1 else 0 end) as null_value
from orders_payments;

select order_id,count(*) from orders_payments
group by order_id
having count(*) > 1;

Desc order_review;

select count(*) as total_rows,
sum(case when review_id is null then 1 else 0 end) as null_id,
sum(case when order_id is null then 1 else 0 end) as order_id,
sum(case when review_score is null then 1 else 0 end) as null_score,
sum(case when review_comment_title is null then 1 else 0 end) as null_title,
sum(case when review_comment_message is null then 1 else 0 end) as null_message,
sum(case when review_creation_date is null then 1 else 0 end) as null_creation_date,
sum(case when review_answer_timestamp is null then 1 else 0 end) as null_answerStamp
from order_review;

select count(*) as total_rows,
sum(case when review_id ='' then 1 else 0 end) as null_id,
sum(case when order_id ='' then 1 else 0 end) as order_id,
sum(case when review_score ='' then 1 else 0 end) as null_score,
sum(case when review_comment_title ='' then 1 else 0 end) as null_title,
sum(case when review_comment_message ='' then 1 else 0 end) as null_message,
sum(case when review_creation_date ='' then 1 else 0 end) as null_creation_date,
sum(case when review_answer_timestamp ='' then 1 else 0 end) as null_answerStamp
from order_review;

select count(*) as total_rows,
sum(case when review_creation_date = '0000-00-00 00:00:00'then 1 else 0 end) as null_creationdate,
sum(case when review_answer_timestamp = '0000-00-00 00:00:00' then 1 else 0 end) as null_timestamp
from order_review;

select review_id, count(*) from order_review
group by review_id
having count(*) > 1;

select count(*) from (select review_id, count(*) from order_review
group by review_id
having count(*) > 1) t;

Desc category;

select count(*) as total_rows,
sum(case when product_category_name is null then 1 else 0 end) as null_name,
sum(case when product_category_name_english then 1 else 0 end) as null_name_english
from category;

select count(*) as total_rows,
sum(case when product_category_name =''then 1 else 0 end) as null_name,
sum(case when product_category_name_english ='' then 1 else 0 end) as null_name_english
from category;

Desc geolocation;

select count(*) as total_rows,
sum(case when geolocation_lat is null then 1 else 0 end ) as null_lat,
sum(case when geolocation_zip_code_prefix is null then 1 else 0 end ) as null_code,
sum(case when geolocation_lng is null then 1 else 0 end ) as null_lng,
sum(case when geolocation_city is null then 1 else 0 end ) as null_city,
sum(case when geolocation_state is null then 1 else 0 end ) as null_state
from geolocation;

select count(*) as total_rows,
sum(case when geolocation_lat ='' then 1 else 0 end ) as null_lat,
sum(case when geolocation_zip_code_prefix ='' then 1 else 0 end ) as null_code,
sum(case when geolocation_lng ='' then 1 else 0 end ) as null_lng,
sum(case when geolocation_city ='' then 1 else 0 end ) as null_city,
sum(case when geolocation_state ='' then 1 else 0 end ) as null_state
from geolocation;



Desc customers;

Create table customer_clean as 
select customer_id, customer_unique_id, customer_city, customer_state,
cast(customer_zip_code_prefix as unsigned) as customer_zip_code_prefix
from customers;

select * from customer_clean;

Desc orders;

create table orders_clean as 
select order_id, customer_id, order_status,
str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s') as order_purchase_timestamp ,
str_to_date(nullif(order_approved_at, ''), '%Y-%m-%d %H:%i:%s') as order_approved_at,
str_to_date(nullif(order_delivered_carrier_date,''), '%Y-%m-%d %H:%i:%s') as order_delivered_carrier_date,
str_to_date(nullif( order_delivered_customer_date,''), '%Y-%m-%d %H:%i:%s') as order_delivered_customer_date,
str_to_date(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s') as order_estimated_delivery_date
from orders;

select * from orders_clean;

Desc order_items;
select * from order_items;

Create table orderItems_clean as 
select order_id, product_id, seller_id,
cast(order_item_id  as unsigned) as order_item_id,
str_to_date (shipping_limit_date , '%Y-%m-%d %H:%i:%s') as shipping_limit_date,
cast(price as decimal (10,2) ) as price,
cast(freight_value as decimal (10,2) ) as freight_value
from order_items;

select * from orderItems_clean;

Desc products;
Select * from products;

Create table products_clean as 
select p.product_id, c.product_category_name_english,
nullif(p.product_category_name, '') as product_category_name,
cast(nullif(p.product_name_length,'') as unsigned) as product_name_length,
cast(nullif(p.product_description_length,'') as unsigned ) as product_description_length,
cast(nullif(p.product_photos_qty,'') as unsigned) as product_photos_qty,
cast(nullif(p.product_weight_g,'') as unsigned) as product_weight_g,
cast(nullif(p.product_length_cm,'') as unsigned) as product_length_cm,
cast(nullif(p.product_height_cm,'') as unsigned) as product_height_cm,
cast(nullif(p.product_width_cm,'') as unsigned) as product_width_cm
from products p
left join category c on p.product_category_name = c.product_category_name;

select * from products_clean;

select * from sellers;

create table sellers_clean as 
select seller_id,
cast(nullif(seller_zip_code_prefix,'') as unsigned) as seller_zip_code_prefix,
nullif(seller_city,'') as seller_city,
nullif(seller_state,'') as seller_state
from sellers;

select * from sellers_clean;

select * from orders_payments;

create table orderPayments_clean as
select order_id,
cast(nullif(payment_sequential,'') as unsigned) as payment_sequential,
nullif(payment_type,'') as payment_type,
cast(nullif(payment_installments,'') as unsigned) as payment_installments,
cast(nullif(payment_value,'') as decimal(10,2) ) as payment_value
from orders_payments;

select * from orderPayments_clean;



Create table orderReview_clean as
select * from 
( 
select 
nullif(review_id, '') as review_id,
nullif(order_id,'') as order_id,
cast(nullif(review_score,'') as unsigned) as review_score,
str_to_date(nullif(review_creation_date,''), '%Y-%m-%d %H:%i:%s') as review_creation_date,
str_to_date(nullif(review_answer_timestamp,''), '%Y-%m-%d %H:%i:%s') as review_answer_timestamp,
row_number() over (partition by review_id order by review_creation_date) as rnk
from order_review
) t
where rnk <=1;

Select * from orderReview_clean;

Drop table orderReview_clean;

Create table orderReview_clean as
select review_id, order_id, review_score, review_creation_date, review_answer_timestamp
from 
( 
select 
nullif(review_id, '') as review_id,
nullif(order_id,'') as order_id,
cast(nullif(review_score,'') as unsigned) as review_score,
str_to_date(nullif(review_creation_date,''), '%Y-%m-%d %H:%i:%s') as review_creation_date,
str_to_date(nullif(review_answer_timestamp,''), '%Y-%m-%d %H:%i:%s') as review_answer_timestamp,
row_number() over (partition by review_id order by review_creation_date) as rnk
from order_review
) t
where rnk <=1;



create table geo_clean as
select 
cast(nullif(geolocation_zip_code_prefix,'') as unsigned) as geolocation_zip_code_prefix,
nullif(geolocation_lat,'')  as geolocation_lat,
nullif(geolocation_lng,'')  as geolocation_lng,
nullif(geolocation_city,'') as geolocation_city,
nullif(geolocation_state,'') as geolocation_state
from geolocation;


select * from geo_clean;

show tables;
select * from orders_clean;
select * from orderitems_clean;


-- General data

create view general_overview as 
Select 
o.order_status,
Count(distinct o.order_id) as total_orders,
Count(distinct o.customer_id) as total_customers,
Count(distinct oi.product_id) as total_products,
Count(distinct oi.seller_id) as total_sellers,
round(sum(oi.price),2) as total_revenue,
round(avg(oi.price),2) as avg_order_value
from orders_clean o 
inner join orderitems_clean oi on o.order_id = oi.order_id 
group by o.order_status
order by total_orders desc;


-- Monthly Data

create view monthly_overview as 
select
date_format(o.order_purchase_timestamp, '%Y-%m') as month,
round(sum(oi.price),2) as monthly_revenue,
round(avg(oi.price),2) as avg_monthly_order_value,
count(distinct o.order_id) as monthly_orders
from orders_clean o 
inner join orderitems_clean oi on o.order_id = oi.order_id
group by date_format(o.order_purchase_timestamp, '%Y-%m') order by month;


create view monthly_status as 
Select 
o.order_status,
date_format(o.order_purchase_timestamp, '%Y-%m') as month,
Count(distinct o.order_id) as monthly_orders,
Count(distinct o.customer_id) as monthly_customers,
Count(distinct oi.product_id) as monthly_products,
Count(distinct oi.seller_id) as monthly_sellers,
round(sum(oi.price),2) as monthly_revenue,
round(avg(oi.price),2) as avg_monthly_order_value
from orders_clean o 
inner join orderitems_clean oi on o.order_id = oi.order_id 
group by o.order_status,month
order by o.order_status,month;


select * from geo_clean;
select * from orderitems_clean;

-- Top Performances

Select * from customer_clean;
select * from orders_clean;
select * from orderitems_clean;


-- Top 10 states by revenue.


create view state_analysis as
with cte as  
(Select
o.customer_id,
count(distinct o.order_id) as state_orders,
round(sum(oi.price),2) as state_revenue,
round(avg(oi.price),2) as state_revenue_avg
from orders_clean o 
inner join orderitems_clean oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by o.customer_id) 
select SUM(c.state_orders),SUM(c.state_revenue),
round(avg(c.state_revenue_avg),2),COUNT(dISTINCT c.customer_id),
cu.customer_state
from cte c 
inner join customer_clean cu
on c.customer_id = cu.customer_id
group by cu.customer_state
order by sum(c.state_revenue) desc;


-- Top 10 product categories by revenue

select * from orderitems_clean;
select * from products_clean;
select * from orders_clean;

create view product_revnue_analysis as 
Select 
p.product_category_name_english,
round(sum(o.price),2) as product_revenue,
round(avg(o.price),2) as avg_product_revenue
from orderitems_clean o
inner join orders_clean oc on o.order_id=oc.order_id
inner join products_clean p on o.product_id = p.product_id
where oc.order_status = 'delivered'
group by p.product_category_name_english order by product_revenue desc;

-- Payment type analysis

Select * from orderpayments_clean;
select * from customer_clean;
select * from orders_clean;

create view payment_type_analysis as 
select 
o.order_status,
p.payment_type ,
count(distinct p.order_id) as total_orders,
round(sum(p.payment_value),2) as total_revenue,
round(avg(p.payment_installments),2) as avg_installments,
round(sum(p.payment_value),2)*100/ sum(round(sum(p.payment_value),2)) over (partition by order_status)  as distribution_percentage_category,
round(sum(p.payment_value),2)*100/ sum(round(sum(p.payment_value),2)) over () as distribution_percentage_overall
from orderpayments_clean p 
inner join orders_clean o on o.order_id = p.order_id
group by o.order_status, p.payment_type
order by o.order_status, total_revenue desc;


-- Review score distribution

select * from orderreview_clean;
select * from orders_clean;

create view review_score_distribution as
Select 
o.order_status,
r.review_score,
count(distinct r.order_id) as Total,
count(distinct r.order_id)*100/ sum(count(distinct r.order_id)) over () as "%distribution"
from orderreview_clean r
inner join orders_clean o
on o.order_id = r.order_id
where o.order_status = 'delivered'
group by r.review_score
order by r.review_score ;

-- Delivery performance analysis

select * from orders_clean;

create view delivery_performance_analysis as 
select 
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),1) as avg_delivery_days,
sum(case when order_delivered_customer_date > order_estimated_delivery_date then 1 else 0 end) as late_delivery,
sum(case when order_delivered_customer_date <= order_estimated_delivery_date then 1 else 0 end) as ontime_delivery,
count(*) as total_orders,
round( sum(case when order_delivered_customer_date > order_estimated_delivery_date then 1 else 0 end)*100/ count(*) , 1) as "Late %",
round( sum(case when order_delivered_customer_date <= order_estimated_delivery_date then 1 else 0 end)*100/count(*),1) as "Ontime %"
from orders_clean
where order_status = "delivered";


-- Top sellers

select * from sellers_clean;
select * from orderitems_clean;
select * from orderreview_clean;
select * from orders_clean;


create view seller_revenue_analysis as
Select s.seller_id,  
round(avg(r.review_score),2) as avg_review,
s.seller_city, 
s.seller_state,
round(sum(o.price),2) as total_revenue,
count(distinct o.order_id) as total_orders
from sellers_clean s 
inner join orderitems_clean o on o.seller_id = s.seller_id
inner join orderreview_clean r on r.order_id = o.order_id
inner join orders_clean os on o.order_id = os.order_id
where os.order_status = 'delivered'
group by  s.seller_id,s.seller_city, s.seller_state
order by total_revenue desc;

-- Making Indexes as above code is taking too long to execute,(DATA OPTIMISATION)
ALTER TABLE orderitems_clean ADD INDEX idx_seller_id (seller_id(50));
ALTER TABLE orderitems_clean ADD INDEX idx_order_id (order_id(50));
ALTER TABLE orders_clean ADD INDEX idx_order_id (order_id(50));
ALTER TABLE orders_clean ADD INDEX idx_status (order_status(20));
ALTER TABLE orderreview_clean ADD INDEX idx_order_id (order_id(50));

ALTER TABLE customer_clean ADD INDEX idx_customer_id (customer_id(50));
ALTER TABLE orderpayments_clean ADD INDEX idx_order_id (order_id(50));
ALTER TABLE products_clean ADD INDEX idx_product_id (product_id(50));

-- Late delivery impact on review score

select * from orderreview_clean;
select * from orders_clean;
select * from orderitems_clean;

create view late_delivery_impact as 
Select r.review_score,
sum(case when o.order_delivered_customer_date > o.order_estimated_delivery_date then 1 else 0 end) as late_delivery,
sum(case when o.order_delivered_customer_date <= o.order_estimated_delivery_date then 1 else 0 end) as early_delivery,
count(*) as total_orders,
round(sum(case when o.order_delivered_customer_date > o.order_estimated_delivery_date then 1 else 0 end)*100/ count(*),2) as late_pct,
round(sum(case when o.order_delivered_customer_date <= o.order_estimated_delivery_date then 1 else 0 end)*100/ count(*),2) as early_pct
from orderreview_clean r 
inner join orders_clean o on o.order_id=r.order_id
where order_status = 'delivered'
group by r.review_score order by r.review_score;


-- Revenue Leakege analysis

select * from orders_clean;
select * from orderitems_clean;
select * from orderpayments_clean;


select o.order_status,
round(sum(oi.price),2) as total_revenue
from orders_clean o 
inner join orderitems_clean oi on o.order_id = oi.order_id
group by o.order_status;

create view revenue_leakege as with cte as (
select 
o.order_id, o.order_status,
round(sum(oi.price),2) as total_revenue
from orders_clean o 
inner join orderitems_clean oi on o.order_id = oi.order_id
group by o.order_id, o.order_status)
Select
sum(case when order_status in ('canceled') then total_revenue else 0 end) as canceled_leakege,
sum(case when order_status in ( 'invoiced','processing','approved') then total_revenue else 0 end) as stuck_leakege,
sum(case when order_status in ('unavailable') then total_revenue else 0 end) as unavailable_leakege,
sum(case when order_status in ( 'canceled','unavailable','invoiced','processing','approved') then total_revenue else 0 end) as total_leakege,
sum(case when order_status in ('canceled') then total_revenue else 0 end)*100/sum(case when order_status in ( 'canceled','unavailable','invoiced','processing','approved') then total_revenue else 0 end) as canceled_pct,
sum(case when order_status in ( 'invoiced','processing','approved') then total_revenue else 0 end)*100/sum(case when order_status in ( 'canceled','unavailable','invoiced','processing','approved') then total_revenue else 0 end) as stuck_pct,
sum(case when order_status in ('unavailable') then total_revenue else 0 end)/sum(case when order_status in ( 'canceled','unavailable','invoiced','processing','approved') then total_revenue else 0 end) as unavailable_pct
from cte;


-- RFM Analysis

select * from orders_clean;
select * from orderitems_clean;
select max(order_purchase_timestamp) from orders_clean;
select * from customer_clean;

create view rfm_analysis as
With rfm_base as (
select c.customer_unique_id,
datediff('2018-10-17', max(o.order_purchase_timestamp)) as recency_days,
count(distinct o.order_id) as frequency,
round(sum(oi.price),2) as revenue
from orders_clean o 
inner join customer_clean c on o.customer_id=c.customer_id
inner join orderitems_clean oi on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by c.customer_unique_id ),
rfm_tile as (
select customer_unique_id, recency_days, frequency, revenue,
ntile(4) over (order by recency_days desc) as recency_score,
ntile(4) over (order by frequency ) as frequency_score,
ntile(4) over (order by revenue ) as revenue_score
from rfm_base ),
rfm_segment as (
select customer_unique_id, recency_days, frequency, revenue,
case
when recency_score = 4 and frequency_score = 4 and revenue_score = 4 then 'Champion'
when recency_score >= 3 and frequency_score >= 3 and revenue_score >= 3 then 'Loyal'
when recency_score >= 2 and frequency_score >= 2 and revenue_score >= 2 then 'Potentiol'
when recency_score <=2 and frequency_score >=3 then 'At Risk'
when recency_score =1 and frequency_score = 1 then 'Lost'
else 'need attention' end as segment
from rfm_tile )
Select
segment,
count(*) as total_customers,
round(avg(recency_days),2) as avg_recency_days,
round(avg(frequency),2) as avg_frequency,
round(avg(revenue),2) as avg_revenue
from rfm_segment
group by segment
order by total_customers desc ;





-- Customer Cohort Analysis

select * from orders_clean;
select * from customer_clean;

create view customer_cohort_analysis as
with first_order as (
select c.customer_unique_id,
date_format(min(o.order_purchase_timestamp), '%Y-%m') as cohort_month 
from orders_clean o
inner join customer_clean c on c.customer_id=o.customer_id
where o.order_status = 'delivered'
group by c.customer_unique_id order by cohort_month
),
month_number as (
select f.customer_unique_id, f.cohort_month,
date_format(o.order_purchase_timestamp, '%Y-%m-%d') as order_month,
timestampdiff(month, str_to_date(concat(f.cohort_month,'-01'), '%Y-%m-%d'), o.order_purchase_timestamp) as month_number
from orders_clean o
inner join customer_clean c on c.customer_id=o.customer_id
inner join first_order f on f.customer_unique_id = c.customer_unique_id
where o.order_status = 'delivered' ),
cohort_size as (
select cohort_month,
count(distinct customer_unique_id ) as cohort_customers
from first_order
group by cohort_month )
select om.cohort_month, cs.cohort_customers, om.month_number,
count(distinct om.customer_unique_id ) as retained_customers,
Round(Count(distinct om.customer_unique_id)*100/ cs.cohort_customers, 1) as retention_rate
from month_number om
inner join cohort_size cs on om.cohort_month = cs.cohort_month
group by om.cohort_month, om.month_number, cs.cohort_customers
order by om.cohort_month, om.month_number;


-- Seller Analysis
select * from orderreview_clean;
select * from orders_clean;
select * from sellers_clean;
Select * from orderitems_clean;


Create view vw_top_seller_analysis as
with seller_order as (
Select seller_id, 
count(distinct order_id) as order_volume,
round(sum(late_flag)*100/count(distinct order_id),2) as late_pct
from(
select distinct 
oi.seller_id,
o.order_id,
case when o.order_delivered_customer_date > o.order_estimated_delivery_date then 1 else 0 end as late_flag
from orders_clean o
inner join orderitems_clean oi on o.order_id = oi.order_id
where o.order_status = 'delivered' ) distinct_orders
group by seller_id ),

seller_reviews as (
select oi.seller_id,
round(avg(r.review_score),2) as avg_review
from orderreview_clean r
inner join orderitems_clean oi on oi.order_id = r.order_id
inner join orders_clean o on o.order_id = r.order_id
where o.order_status = 'delivered'
group by oi.seller_id ),

seller_cancellation as (
select oi.seller_id,
count(distinct oi.order_id) as cancelled_order
from orderitems_clean oi
inner join orders_clean o on o.order_id = oi.order_id
where o.order_status = 'canceled'
group by oi.seller_id ),

seller_volume as (
select seller_id, order_volume, late_pct,
case ntile(4) over (order by order_volume desc )
when 1 then 100
when 2 then 75
when 3 then 50
when 4 then 25
end as volume_score from seller_order ),

seller_scores as (
Select sv.seller_id,
s.seller_city, s.seller_state,
sv.order_volume, sv.late_pct, sv.volume_score,
coalesce(sr.avg_review, 3) as avg_review,
coalesce(sc.cancelled_order, 0) as cancelled_order,
Round((coalesce(sr.avg_review, 3)/5*100*0.25)+
(Greatest(0, 100-sv.late_pct)*0.25) + sv.volume_score*0.25 +
greatest(0, 100-(coalesce(sc.cancelled_order, 0)*100/sv.order_volume))*0.25) as health_score
from seller_volume sv
left join seller_reviews sr on sv.seller_id = sr.seller_id
left join seller_cancellation sc on sv.seller_id = sc.seller_id
inner join sellers_clean s on sv.seller_id = s.seller_id
)

select *,
case ntile(4) over (order by health_score desc)
when 1 then 'elite'
when 2 then 'Healthy'
when 3 then 'At risk'
when 4 then 'Critical'
End as health_tier
from seller_scores
order by health_score desc;












































