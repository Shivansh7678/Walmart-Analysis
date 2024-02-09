create database if not exists saleswalmart;
use saleswalmart;
create table if not exists sales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null ,
city varchar(30) not null ,
 customer_type varchar(30) not null ,
 gender varchar(30) not null,
 product_type varchar(100) not null ,
 unit_price decimal(10, 2) not null,
 quantity int not null,
 VAT float(6, 4) not null,
 total decimal(12,4) not null,
 date datetime not null,
 time time not null,
 payment_method varchar(30) not null ,
cogs decimal(10, 2) not null,
gross_margin_pct float(11, 9), 
gross_income decimal(12, 4) not null,
ratings float(2, 1) not null
);
select * from sales;   
 
 -- -------------------Feature Engineering-----------------------------------------------------
 -- time_of_day-----
 select
 time,
 (case 
 when 'time' between '00:00:00' and "12:00:00" then "Morning"
 when 'time' between '12:01:00' and "04:00:00" then "Afternoon"
 else "Evening"
 end
 )as time_of_date
 from sales;
Alter table sales add column time_of_day varchar(50);
update sales
set time_of_day=(
	case 
 when 'time' between '00:00:00' and "12:00:00" then "Morning"
 when 'time' between '12:01:00' and "04:00:00" then "Afternoon"
 else "Evening"
	end
 );
 ---------------------------------------------------------------------------------
 -- Day name ----------------------
 select date,dayname(date) from sales;
 Alter table sales add column day_name varchar(15);
 update sales
 set day_name=dayname(date);
 

 -- Month name----------------------
select monthname(date) from sales;
Alter table sales add column month_name varchar(30);
update sales 
set month_name=monthname(date);
select * from sales;  

-- ------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- -------------------------Generic ------------------------------------------
-- How many unique cities does the data have?-------------
select distinct city from sales;

-- In which city is each branch?
select distinct city ,branch from sales;
-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------- Product --------------------------------------------------------------------------------------------------
-- How many unique product lines does the data have?------------------
select count(distinct product_type) from sales;

-- What is the most common payment method?------------------
select * from sales;

select payment_method,count(payment_method) from sales group by payment_method order by count(payment_method)desc;

-- What is the most selling product line?---------------------------------- 
select product_type,count(product_type) from sales group by product_type order by count(product_type)desc;

-- What is the total revenue by month?-------------------------------------

select month_name as month,sum(total) as total_revenue from sales group by month order by total_revenue asc ;

-- What month had the largest COGS?-------------------------------
select month_name as month,sum(cogs) as cogs from sales group by month order by cogs desc;

-- What product line had the largest revenue?--------------------------
 select* from sales;
 select product_type,sum(total) as revenue from sales group by product_type order by revenue desc;
 
 -- What is the city with the largest revenue?-------------------------------------
 select city,sum(total) as revenue from sales group by city order by revenue desc;

-- What product line had the largest VAT?-------------------------------------------
select product_type,sum(VAT) as VAT from sales group by product_type order by VAT desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales--------------------


-- Which branch sold more products than average product sold?----------------------------
select branch,sum(quantity) as sum from sales group by branch having sum(quantity)> (select  avg(quantity) from sales);
select * from sales;


--  What is the most common product line by gender?-----------------------
select gender ,product_type,count(product_type) as product from sales group by gender,product_type order by product desc;

-- What is the average rating of each product line?-------------------------------------------
select product_type,avg(ratings)as avg from sales group by product_type;

-- ---------------------------------------------------------------------------------------------------------------------------------------------
