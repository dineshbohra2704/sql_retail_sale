---create table---
create table retail_sales (
    transactions_id Int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
)


select count(*) from retail_sales

select category, count(category) from retail_sales
group by category

---Data cleaning---

select * from retail_sales
where transactions_id is null

---finding null values---
select * from retail_sales
where sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null


---deleting null values---
delete from retail_sales
where sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null

---data exploration---

---how many sales we have---
select count(*) as total_sales from retail_sales

---how many unique customers we have---
select count(distinct customer_id) as total_customers from retail_sales


---data analysis and business key problems & answers---

---Q1. Write a query to retrieve all columns for sales made on "2022-11-05"---
select * from retail_sales 
where sale_date = '2022-11-05'

---Q2. Write a sql query to retrieve all the transaction where the category is clothing and the quantity sold is more than
    ---3 in the month of N0V-2022---
select *
from retail_sales
where category = 'Clothing'
and to_char(sale_date,'yyyy-mm')='2022-11'
and quantiy > 3

---Q3. Write a sql query to calculate the total sales(total_sale) for each category---
select category,sum(total_sale)
from retail_sales
group by 1

---Q4. Write a sql query to find the average age of the customers who purchased  item from the 'beauty' category---
select round(avg(age),2)
from retail_sales
where category='Beauty'

---Q5. Write a sql query to find all the transactions where the total_sale is greater than 1000---
select *
from retail_sales
where total_sale > 1000

---Q6. Write a sql query to find the total number of transaction (transaction_id) made by each gender in each category---
select gender,category,count(transactions_id)
from retail_sales
group by gender, category

---Q7. Write a sql query to calculate the avg sale of each month . find out the best selling month in  each year---
select * from
(select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sales,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2
) as t1
where rank=1

---Q8. write a sql query to find the top 5 customers based on the highest total sales---
select customer_id,
sum(total_sale) as total_Sales
from retail_sales
group by 1
order by 2 desc
limit 5

---Q9. Write a sql query to find the number of unique customers who purchased items from each category---
select category,
count(distinct(customer_id))
from retail_sales
group by 1


---Q10. Write a sql query in each shift and number of orders (example Morning<=12, afternoon between 12 & 17, evening>17)---
with hourly_Sale as
(select *,
case 
when extract(hour from sale_time)<=12 then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift
from retail_sales)
select shift,
count(*) as total_orders
from hourly_Sale
group by shift

---END OF PROJECT---






