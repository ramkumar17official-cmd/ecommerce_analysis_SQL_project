-- To create database ecommerce analysis
CREATE DATABASE ecommerce_analysis;
/* USE used to select the database so that all sql queries run inside that database*/
USE ecommerce_analysis;
-- To create the table
CREATE TABLE sales_data(
order_id int,
order_date date,
customer_name varchar(100),
city varchar(100),
region varchar(100),
product_name varchar(100),
category varchar(100),
quantity int,
price decimal(10,2),
payment_method varchar(50)
);
-- To insert the data in the table
INSERT INTO sales_data values
(1,'2026-03-10','ram','sambavarvadakarai','south','laptop','electronics',1,45000,'UPI'),
(2,'2026-03-11','karthi','nagercoil','north','mobile','electronis',4,100000,'card'),
(3,'2026-03-12','selvam','sambavarvadakarai','south','watch','accessories',2,30000,'UPI'),
(4,'2026-03-13','raja','madurai','east','airbuds','accessories',4,8000,'card'),
(5,'2026-03-14','kingsly','mariyathaipuram','west','shoes','fashion',2,4000,'UPI'),
(6,'2026-03-15','rock','kanniyakumari','north','bag','fashion',3,3000,'UPI'),
(7,'2026-03-16','aravinth','sambavarvadakarai','south','shirt','fashion',5,5000,'UPI'),
(8,'2026-03-17','venkat','sambavarvadakarai','south','mobile','electronis',4,100000,'UPI'),
(9,'2026-03-18','muppudathi','tenkasi','south','laptop','electronis',2,80000,'UPI'),
(10,'2026-03-19','hari','sambavarvadakarai','south','pant','fashion',5,2000,'UPI');
describe sales_data;
alter table sales_data change price price decimal(10,2);
select * from sales_data;
select count(*) from sales_data;
select order_id,customer_name, count(*) 
from sales_data
group by order_id,customer_name
having count(*) > 1;
-- create temperory table to keep only unique records
create table temp_table as 
select distinct * from sales_data;
drop table sales_data;
alter table temp_table rename to sales_data;
select count(*) from sales_data;
-- another method remove duplicate data with help of using delete row_number and partition by
-- 
-- basic queries
-- 1.view data
select * from sales_data;
-- 2.total orders
select count(*) from sales_data;
-- 3.unique product
select distinct(product_name) from sales_data;
-- 4.unique customer
select distinct customer_name from sales_data;
-- 5.total sales amount
select sum(quantity*price) as total_sales from sales_data;
-- 6.average product price
select avg(price) from sales_data;
-- 7.min product price
select min(price) from sales_data;
-- 8.max product price
select max(price) from sales_data;
-- category analysis
-- 9.sales by category
select category,sum(quantity*price) as sales from sales_data
group by category;
-- you should update data you are using safe update mode
set sql_safe_updates=0;
update sales_data set category="electronics" where category ="electronis"; 
-- 10.highest category sales
select category, sum(quantity*price) as sales from sales_data
group by category
order by sales desc;
-- product analysis
-- 11.top selling products
select product_name, sum(quantity*price) as total_quantity
from sales_data
group by product_name
order by total_quantity desc;
-- 12,highest revenue product
select product_name,sum(quantity*price) as revenue 
from sales_data
group by product_name
order by revenue desc
limit 1;
-- regional analysis
-- 13.sales by region
select region,sum(quantity*price) as sales
from sales_data
group by region;
-- 14.highest sales region
select region,sum(quantity*price) as revenue
from sales_data
group by region
order by revenue desc
limit 1;
-- customer analysis
-- 15.orders per customer
select customer_name,count(order_id)
from sales_data
group by customer_name;
-- 16.top customer by spending
select customer_name,sum(quantity*price) as spending
from sales_data
group by customer_name
order by spending desc
limit 1;
-- payment analysis
-- 17.payment method usage
select payment_method ,count(*) 
from sales_data
group by payment_method;
-- 18.revenue by payment method
select payment_method,sum(quantity*price) as revenue
from sales_data
group by payment_method;
-- Data analysis
-- 19.orders by date
select order_date,count(*) 
from sales_data
group by order_date;
-- 20.monthly revenue
select month(order_date),sum(quantity*price) as revenue
from sales_data
group by month(order_date);
-- advanced queries
-- 21.highest price product
select product_name,sum(quantity*price) as revenue
from sales_data
group by product_name
order by revenue desc
limit 1;
-- 22.lowest price product
select product_name,sum(quantity*price) as price
from sales_data
group by product_name
order by price asc
limit 1;
-- 23.product sold more than 2 quantity
select * from sales_data
where quantity > 2;
-- 24.Electronics sales
select * from sales_data
where category='electronics';
-- 25.fashion category revenue
select category ,sum(quantity*price) as revenue
from sales_data
where category='fashion';
-- 26.orders paid by UPI
select payment_method,count(order_id)
from sales_data
where payment_method='UPI';
-- 27.customer from south region
select customer_name,region from sales_data
where region="south";
-- 28.orders above 20000
select * from sales_data
where price > 20000;
-- 29.total quantity sold
select sum(quantity) from sales_data;
-- 30.category with highest orders
select category,count(*)
from sales_data
group by category
order by count(*) desc;
-- 31.region with most customer
select region,count(distinct customer_name) 
from sales_data
group by region
order by count(distinct customer_name) desc;
-- 32.average quantity per order
select avg(quantity) from sales_data;
-- 33.total revenue per order
select order_id,sum(quantity*price) as revenue
from sales_data
group by order_id
order by revenue desc;




















