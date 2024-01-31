**Project Report: Walmart Sales Data Analysis**

**About:**
This project explores Walmart Sales data to gain insights into top-performing branches and products, sales trends, and customer behavior. The dataset was sourced from the Kaggle Walmart Sales Forecasting Competition, providing historical sales data for 45 Walmart stores across different regions.

**Purpose:**
The primary objective is to understand various factors influencing sales across different Walmart branches to optimize sales strategies effectively.

**Data Description:**
The dataset comprises sales transactions from three Walmart branches located in Mandalay, Yangon, and Naypyitaw. It contains 17 columns and 1000 rows, detailing information such as invoice ID, branch location, customer type, product details, sales figures, and ratings.

**Analysis List:**
1. **Product Analysis:** Explore product lines, identify top-performing and underperforming products.
2. **Sales Analysis:** Analyze sales trends to evaluate the effectiveness of sales strategies.
3. **Customer Analysis:** Uncover customer segments, purchase trends, and segment profitability.

**Approach Used:**
1. **Data Wrangling:** Inspection for NULL values, data replacement methods used.
2. **Build a Database:** Creation of tables and data insertion.
3. **Feature Engineering:** Addition of new columns for insights on sales patterns.
4. **Exploratory Data Analysis (EDA):** Investigation of data to answer project objectives and questions.

**Business Questions To Answer:**
Generic Questions:
How many unique cities does the data have?
In which city is each branch?
Product:
How many unique product lines does the data have?
What is the most common payment method?
What is the most selling product line?
What is the total revenue by month?
What month had the largest COGS?
What product line had the largest revenue?
What is the city with the largest revenue?
What product line had the largest VAT?
Fetch each product line and add a column to those product line showing "Good", "Bad". Good if it's greater than average sales
Which branch sold more products than average product sold?
What is the most common product line by gender?
What is the average rating of each product line?
Sales:
Number of sales made in each time of the day per weekday
Which of the customer types brings the most revenue?
Which city has the largest tax percent/ VAT (Value Added Tax)?
Which customer type pays the most in VAT?
Customer:
How many unique customer types does the data have?
How many unique payment methods does the data have?
What is the most common customer type?
Which customer type buys the most?
What is the gender of most of the customers?
What is the gender distribution per branch?
Which time of the day do customers give most ratings?
Which time of the day do customers give most ratings per branch?
Which day of the week has the best avg ratings?
Which day of the week has the best average ratings per branch?

**Revenue And Profit Calculations**
$ COGS = unitsPrice * quantity $

$ VAT = 5% * COGS $

 is added to the 
 and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

Example with the first row in our DB:

**Data given:**

$ \text{Unite Price} = 45.79 $
$ \text{Quantity} = 7 $
$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5% * COGS\= 5% 320.53 = 16.0265 $

$ total = VAT + COGS\= 16.0265 + 320.53 = 336.5565 $

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\=\frac{16.0265}{336.5565} = 0.047619\\approx 4.7619% $

**Conclusion:**

In summary, the Walmart Sales Data Analysis project has yielded actionable insights into product performance, sales trends, and customer behaviour. Through thorough analysis and feature engineering, the project provides a foundation for informed decision-making and optimization of sales strategies, supporting Walmart's ongoing efforts for success in its various branches.
