-- sql project 01 data base
 CREATE DATABASE sql_project_01;

USE sql_project_01;

ALTER TABLE retail_sales
CHANGE ï»¿transactions_id transactions_id INT;

-- Basic EDA
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
    or
	sale_date IS NULL
    or
    sale_time IS NULL
    or
    gender IS NULL
    or
    category IS NULL
    or
    quantiy IS NULL
    or
    cogs IS NULL
    or
    total_sale IS NULL;
    
SELECT count(*) FROM retail_sales;
SELECT count(DISTINCT customer_id) FROM retail_sales;
  
    
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = "2022-11-05";

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4;


    -- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
    SELECT category, sum(total_sale) FROM retail_sales
    group by 1;    
    
    -- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
    SELECT category, avg(age) FROM retail_sales
    WHERE category = 'Beauty'
    group by 1;
    
    -- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
    SELECT * FROM retail_sales
    WHERE total_sale > 1000;
    
    -- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
    SELECT category, gender, count(*) FROM retail_sales
    group by 
    category, gender;
    
    -- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * FROM
(SELECT EXTRACT(YEAR from sale_date) as year,
		EXTRACT(Month from sale_date) as month,
        Avg(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY AVG(total_sale) DESC) as rank_
	FROM retail_sales
	group by 1, 2
) AS t1
WHERE rank_ = 1;
;
-- order by 1, 2;
    
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, sum(total_sale) as sale FROM retail_sales
GROUP BY customer_id
order by sale DESC
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id) AS unique_cust
FROM retail_sales
group by 1;


-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 SELECT *,
	CASE
		WHEN Extract(HOUR from sale_time) < 12 THEN 'Morning shift'
        WHEN Extract(HOUR from sale_time) between 12 and 17 THEN 'Afternoon shift' 
        ELSE 'Evening Shift'
        END AS shift
	FROM retail_sales;
    
    

