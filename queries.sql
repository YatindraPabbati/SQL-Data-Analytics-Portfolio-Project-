CREATE DATABASE SalesDataWalmart;
USE SalesDataWalmart;
CREATE TABLE Sales(
invoice_id varchar(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12,4),
rating FLOAT(2,1)
);



-- --------------------------------------------------------------
-- ------------------ Feature Engineering ----------------

-- time_of_day

SELECT time,
( CASE
      WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning" 
	  WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon" 
      ELSE "Evening"
END ) AS time_of_date
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = ( 
CASE
      WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning" 
	  WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon" 
      ELSE "Evening"
END 
);

-- day_name
SELECT 
    date,
    DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- month_name

SELECT 
    date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- -----------------------------------------------------------------



-- -----------------------------------------------------------------
-- ------------------------------- Generic -------------------------

-- How many unique cities does the data have?
SELECT
    DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT
    DISTINCT branch
FROM sales;

SELECT
DISTINCT city,
branch
FROM sales;



-- -----------------------------------------------------------------
-- ------------------------------- Product -------------------------

-- How many unique product lines does the data have?
SELECT
DISTINCT product_line
FROM sales;

-- What is the most common payment method? 
SELECT
COUNT(DISTINCT product_line)
FROM sales;

SELECT
    payment,
	COUNT(payment) AS cnt
FROM sales
GROUP BY payment
ORDER BY cnt DESC;

-- What is the most selling product line?
SELECT
    product_line,
	COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?
SELECT
     month_name AS month,
     SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?

SELECT
    month_name AS month,
    SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT
    DISTINCT product_line,
    SUM(total) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;

-- What is the city with the largest revenue?
SELECT
	  branch,
	  city,
      SUM(total) AS revenue
FROM sales
GROUP BY branch,city
ORDER BY revenue DESC;

-- What product line had the largest VAT?
SELECT
      product_line,
      SUM(VAT) AS VAT
FROM sales
GROUP BY product_line
ORDER BY VAT DESC;

-- Which branch sold more products than average product sold?
SELECT
      branch,
      SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT
      gender,
      product_line,
      COUNT(gender) AS tot
FROM sales
GROUP BY gender,product_line
ORDER BY tot DESC;

-- What is the average rating of each product line?
SELECT
      product_line,
      ROUND(AVG(rating), 2) AS avg
FROM sales
GROUP BY product_line
ORDER BY avg;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if it's greater than average sales
SELECT
    product_line,
    AVG(total) AS average_sales,
    CASE
        WHEN total > AVG(total) THEN 'Good'
        ELSE 'Bad'
    END AS sales_status
FROM
    sales
GROUP BY
    product_line;

-- -----------------------------------------------------------------
-- ------------------------------- Sales ---------------------------
-- Number of sales made in each time of the day per weekday
SELECT
time_of_day,
day_name,
SUM(total) AS sales
FROM sales
WHERE day_name IN ("Monday","Tuesday","Wednesday","Thursday","Friday")
GROUP BY time_of_day, day_name
ORDER BY sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
customer_type,
SUM(total) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT
city,
SUM(VAT) as largest_tax_pct
FROM sales
GROUP BY city
ORDER BY largest_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
customer_type,
SUM(VAT) as largest_tax_pct
FROM sales
GROUP BY customer_type
ORDER BY largest_tax_pct DESC;

-- -----------------------------------------------------------------
-- ------------------------------- Customer ---------------------------
-- How many unique customer types does the data have?
SELECT
DISTINCT customer_type,
-- to get the count of the unique customer types we can simply use the following condition without the above statement 
COUNT(DISTINCT(customer_type)) AS unq_customer_types
FROM sales
GROUP BY customer_type
ORDER BY unq_customer_types;

-- How many unique payment methods does the data have?
SELECT
DISTINCT payment,
-- to get the count of the unique payment methods we can simply use the following condition without the above statement
COUNT(DISTINCT(payment)) AS unq_paymeth_types
FROM sales
GROUP BY payment
ORDER BY unq_paymeth_types;

-- Which customer type buys the most?
SELECT
DISTINCT customer_type,
SUM(quantity) AS buys_most
FROM sales
GROUP BY customer_type
ORDER BY buys_most DESC;

-- What is the gender of most of the customers?
SELECT
gender,
COUNT(gender) AS gndr_cnt
FROM sales
GROUP BY gender
ORDER BY gndr_cnt DESC;

-- What is the gender distribution per branch?
SELECT
branch,
gender,
COUNT(gender) AS gndr_cnt
FROM sales
GROUP BY branch,gender
ORDER BY gndr_cnt;

-- Which time of the day do customers give most ratings?
SELECT
time_of_day,
AVG(rating) AS rating_cnt
FROM sales
GROUP BY time_of_day
ORDER BY rating_cnt DESC;

-- Which day of the week has the best avg ratings?
SELECT 
day_name,
AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
day_name,
branch,
AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name,branch
ORDER BY avg_rating DESC;
