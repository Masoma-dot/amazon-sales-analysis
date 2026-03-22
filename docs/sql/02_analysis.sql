-- Data transformation queries will go here
## This is where we will perform our analysis.
WE WILL ANSWER THE FOLLOWING QUESTIONS, GROUPS:
1. CORE BUSINESS HEALTH
What is the total revenue?
What is the total number of orders?
What is the total quantity sold?
What is the cancellation rate?
What is the average order value (AOV)?
_________________________________
2. TIME-BASED ANALYSIS
How does revenue trend over time (daily/monthly)?
Which days had the highest sales?
Are there sales spikes or drops?
How does cancellation trend over time?
_________________________________
3. PRODUCT ANALYSIS
Which categories generate the most revenue?
Which categories have the highest cancellations?
Which products (SKU/ASIN) perform best?
What is the average order value per category?
_________________________________
4. CUSTOMER/LOCATION ANALYSIS
Which cities generate the most revenue?
Which states perform best/worst?
Are there cities with high cancellations?
__________________________________
5. OPERATIONS & LOGISTICS
Which cities generate the most revenue?
Which states perform best/worst?
Are there cities with high cancellations?
__________________________________

_______________________________________________________________________________________________________________________
1. CORE BUSINESS HEALTH
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the total revenue?
  
**SQL Query:**
  SELECT SUM(amount)
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
...

**Output Description:**
  73348811.33
...

**Insight:**
  The total revenue made during this period is INR 73348811.38. Since there only few NULL spaces, this is actually a reliable amount to 
  deal with.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
What is the total number of orders?

**SQL Query:**
  SELECT COUNT(`order_id`)
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
...

**Output Description:**
  120378
...

**Insight:**
  120378 orders were made this period. Since we don't have access to data of other periods/months, we can't confirm whether or not this
  is an improvement compared to them.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
What is the total quantity sold?

**SQL Query:**
  SELECT SUM(quantity)
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
...

**Output Description:**
  108789 
...

**Insight:**
  108789 products were sold. This shows high cancellation of orders (of over 11000 orders in a period of more or less a month).
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
What is the cancellation rate?

**SQL Query:**
  SELECT COUNT(CASE WHEN `is_cancelled` = 1 THEN 1 END) AS cancelled_orders, 
       COUNT(`order_id`) AS total_orders, ROUND(((COUNT(`order_id`)-COUNT(CASE WHEN `is_cancelled` = 1 THEN 1 END))/(COUNT(`order_id`))), 2)
FROM   `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
...

**Output Description:**
  0.86
...

**Insight:**
  The cancellation rate is 0.86%, rounded off to the nearest two decimals. This is over a 99% success rate. This shows that almost all customers don't change their minds once
  they make a purchase. This keeps the upcoming revenue of the company more predictable.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
What is the average order value (AOV)?

**SQL Query:**
  SELECT ROUND(AVG(non_null_amounts), 2)
FROM (SELECT amount AS non_null_amounts
      FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
      WHERE amount > 0)
...

**Output Description:**
  662.97
...

**Insight:**
  INR 662.97 is the average order value (AOV), rounded off to the nearest 2 decimal places. This means the average customer spends INR 662.97 during the period.
...
_________________________________________________________________
________________________________________________________________________________________________________________________
2. TIME-BASED ANALYSIS
  ## Task X: Create Cleaned Dataset View

**Business Question:**
How does revenue trend over time (daily/monthly)?

**SQL Query:**
  SELECT ROUND(MIN(revenue_change), 2) AS minimum_revenue_change,
 ROUND(MAX(revenue_change), 2) AS maximum_revenue_change,
  ROUND(AVG(revenue_change), 2) AS average_revenue_change,
   ROUND(STDDEV(revenue_change), 2) AS revenue_change_standard_deviation
FROM (--  How does revenue trend over time (daily/monthly)?

-- Create a table that sums the revenue by date
WITH revenue_table AS (
  SELECT `order_date`, SUM(`amount`) AS  revenue_sums
  FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
  GROUP BY `order_date`),

-- Then create a LEAD() column from that table
     lead_table AS (
      SELECT `order_date`, revenue_sums, LEAD(revenue_sums) OVER (ORDER BY `order_date` ASC) AS lead_revenue
      FROM revenue_table
     )

-- Subtract the lead from the sums_table
SELECT `order_date`, lead_revenue - revenue_sums AS revenue_change
FROM   lead_table)
...

**Output Description:**
  The daily revenue change can be visualised with a line graph. 
  -- Minimum revenue change = -338376.44
-- Maximum revenue change = 704038.66
-- Average revenue change = 3165.44
-- Standard deviation of revenue change = 110009.29
...

**Insight:**
  Observing the line graph, the daily revenue changes fluctuates around zero, meaning the increase and decrease in revenue offset
  each other during the period.
  There is a big difference between the minimum and maximum revenue change. This, together with the high standard deviation, shows that 
  there is a high variation in the daily revenue changes. The average revenue change does, however, show that the company only makes
  INR 3165.44 per day on average. This is very low and not safe, considering the high fluctuations of daily revenue.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which days had the highest sales?

**SQL Query:**
  -- Which days had the highest sales?
-- We will select the top five dates that had the highest dates.
SELECT `order_date`
FROM (-- Create a table that sums the revenue by date
WITH revenue_table AS (
  SELECT `order_date`, SUM(`amount`) AS  revenue_sums
  FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
  GROUP BY `order_date`),

-- Then create a LEAD() column from that table
     lead_table AS (
      SELECT `order_date`, revenue_sums, LEAD(revenue_sums) OVER (ORDER BY `order_date` ASC) AS lead_revenue
      FROM revenue_table
     )

-- Subtract the lead from the sums_table
SELECT `order_date`, lead_revenue - revenue_sums AS revenue_change
FROM   lead_table)
ORDER BY revenue_change DESC
LIMIT 5
...

**Output Description:**
  -- The five days that had the biggest positive revenue change are (in order from bigest to smallest) are:
-- 2022-03-31
-- 2022-04-13
-- 2022-06-03
-- 2022-04-29
-- 2022-04-29
...

**Insight:**
  There is no pattern between the five days. The days are spread wide apart. This means the revenue spikes back randomly during
  period. There is no pattern that can be detected between a revenue spike and the date on which it occurs.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Are there sales spikes or drops?

**SQL Query:**
  -- Are there sales spikes or drops?
-- We will count the number of negative vs positive revenue changes.

SELECT COUNTIF(`revenue_change` > 0) AS revenue_spike,
       COUNTIF(`revenue_change` < 0) AS revenue_dip
FROM (-- Create a table that sums the revenue by date
WITH revenue_table AS (
  SELECT `order_date`, SUM(`amount`) AS  revenue_sums
  FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
  GROUP BY `order_date`),

-- Then create a LEAD() column from that table
     lead_table AS (
      SELECT `order_date`, revenue_sums, LEAD(revenue_sums) OVER (ORDER BY `order_date` ASC) AS lead_revenue
      FROM revenue_table
     )

-- Subtract the lead from the sums_table
SELECT `order_date`, lead_revenue - revenue_sums AS revenue_change
FROM   lead_table)
...

**Output Description:**
  -- revenue_spike is 45
-- revenue_dip is 45
...

**Insight:**
  There are equal amounts of spikes and dips in the daily revenue change. Therefore the data is relatively symmetrical.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
How does cancellation trend over time?
  
**SQL Query:**
  -- Get the mean, minimum, maximum, and standard deviation of the change_in_cancellations to describe. Rounded off to two decimal places
SELECT ROUND(MIN(change_in_cancellations), 2) AS minimum_cancellation,
 ROUND(MAX(change_in_cancellations), 2) AS maximum_cancellation,
  ROUND(AVG(change_in_cancellations), 2) AS average_cancellation,
   ROUND(STDDEV(change_in_cancellations), 2) AS standard_deviation_cancellation
FROM (WITH daily_cancellations AS (
  SELECT 
    order_date,
    SUM(is_cancelled) AS number_of_cancellations
  FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
  GROUP BY order_date
)

SELECT 
  order_date,
  number_of_cancellations,
  LAG(number_of_cancellations) OVER (ORDER BY order_date) AS lagged_cancellations,
  number_of_cancellations 
    - LAG(number_of_cancellations) OVER (ORDER BY order_date) AS change_in_cancellations
FROM daily_cancellations
ORDER BY order_date)
...

**Output Description:**
-- Minimum: -122
-- Maximum: 203
-- Mean: 0.14
-- Standard deviation: 36.75
...

**Insight:**
When represented by a line graph, the change in cancellations fluctuates around 0. This is further validated by the mean cancellation of 
  0. There is a high range in the change in the number of days of cancellations, facilitated by high variation. This is justified by 
  the relatively high standard deviation. This shows that, on the average day, there is little to no change in the number of cancellation 
  days during the period.
...
_________________________________________________________________
________________________________________________________________________________________________________________________
3. PRODUCT ANALYSIS
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which categories generate the most revenue?

**SQL Query:**
-- We will show the top 3 categories that make the most revenue, rounded off to two decimal places.
SELECT `category`, ROUND(SUM(`amount`), 2) AS sum_category_revenue
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `category`
ORDER BY sum_category_revenue DESC
LIMIT 3
...

**Output Description:**
-- SET: 36516334.42
-- KURTA: 19675863.86
-- WESTERN DRESS: 10673252.34
...

**Insight:**
"Set" generates the most revenue for the company, followed by "Kurta", and then "Western Dress"
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which categories have the highest cancellations?

**SQL Query:**
  -- Which categories have the highest cancellations?
-- We will pick the top three highest categories.
SELECT `category`, SUM(is_cancelled) AS number_category_cancellations
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `category`
ORDER BY number_category_cancellations DESC
LIMIT 3
...

**Output Description:**
-- SET: 6839
-- KURTA: 6758
-- WESTERN DRESS: 2044
...

**Insight:**
  "Set" has the most cancellations, followed by "Kurta", and then "Western Dress". This correlates with the amount of revenue generated
  by each category.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which products (SKU/ASIN) perform best?

QUERIES
  ASIN/REVENUE
**SQL Query:**
  -- We will check the the revenue and quantity of the ASIN
SELECT `amazon_standard_identification_number`, ROUND(SUM(amount), 2) AS total_revenue, SUM(quantity) AS total_quantity
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `amazon_standard_identification_number`
ORDER BY `total_revenue` DESC
...

**Output Description:**
  -- In terms of revenue, these are the top 5 (in descending order):
-- B08XNJG8B1: 514818.2
-- B09SDXFFQ1: 506093.48
-- B08XNJ19QH: 468445.14
-- B09SDY8DCT: 438509.16
-- B09SDYQ3WG: 399011.57
...
  ASIN/QUANTITY
  **SQL Query:**
  -- We will check the the revenue and quantity of the ASIN
SELECT `amazon_standard_identification_number`, ROUND(SUM(amount), 2) AS total_revenue, SUM(quantity) AS total_quantity
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `amazon_standard_identification_number`
ORDER BY `total_quantity` DESC
...

**Output Description:**
  -- In terms of quantity, these are the top 5 (in descending order):
-- B09SDXFFQ1: 637
-- B09SDY8DCT: 540
-- B09SDYQ3WG: 492
-- B081WSCKPQ: 471
-- B08XNJG8B1: 457
...
__________________________________
  SKU/REVENUE
  **SQL Query:**
   -- We will check the the revenue and quantity of the SKU
SELECT `stock_keeping_unit`, ROUND(SUM(amount), 2) AS total_revenue, SUM(quantity) AS total_quantity
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `stock_keeping_unit`
ORDER BY `total_revenue` DESC 
...

**Output Description:**
  -- In terms of revenue, these are the top 5 (in descending order):
-- J0230-SKD-M: 514818.2
-- JNE3797-KR-L: 506093.48
-- J0230-SKD-S: 468445.14
-- JNE3797-KR-M: 438509.16
-- JNE3797-KR-S: 399011.57
...
  SKU/QUANTITY
  **SQL Query:**
-- We will check the the revenue and quantity of the SKU
SELECT `stock_keeping_unit`, ROUND(SUM(amount), 2) AS total_revenue, SUM(quantity) AS total_quantity
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `stock_keeping_unit`
ORDER BY `total_quantity` DESC
...

**Output Description:**
  -- In terms of quantity, these are the top 5 (in descending order):
-- JNE3797-KR-L: 637
-- JNE3797-KR-M: 540
-- JNE3797-KR-S: 492
-- JNE3405-KR-L: 471
-- J0230-SKD-M: 457
...

**Insight:**
  Certain SKU with their corresponding ASIN perform better, by measure of revenue and quantity.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
What is the average order value per category?
  
**SQL Query:**
  -- What is the average order value per category?
SELECT `category`, ROUND(AVG(amount), 2)
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `category`
...

**Output Description:**
AVERAGE VALUES FOR EACH CATEGORY
KURTA: 456.15
SET: 832.9
TOP: 524.85
BLOUSE: 521.2
WESTERN DRESS: 762.01
ETHNIC DRESS: 720.51
BOTTOM: 358.03
SAREE: 801.62
DUPATTA: 305.0
...

**Insight:**
"Set" has the highest average order value, followed by "Saree", and then "Western Dress". "Dupatta" has the lowest average order value,
  followed by "Bottom", and then "Kurta".
...
_________________________________________________________________
__________________________________________________________________________________________________________________________
4. CUSTOMER/LOCATION ANALYSIS
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which cities generate the most revenue?

**SQL Query:**
  -- We will choose the top cities with the most revenue

SELECT `shipping_city`, ROUND(SUM(amount), 2) AS total_revenue
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `shipping_city`
ORDER BY `total_revenue` DESC
LIMIT 10
...

**Output Description:**
shipping_city	total_revenue
BENGALURU	    6797490.49
HYDERABAD	    5117817.79
MUMBAI	      3960358.98
NEW DELHI   	3708238.79
CHENNAI	      3293185.44
PUNE	        2607185.68
KOLKATA	      1584569.37
GURUGRAM    	1216550.37
THANE       	1048748.86
LUCKNOW	      1004524.28
...

**Insight:**
These cities are of unique values to us since they show which city has the most demand for the company's products. This makes it easier
  to avoid under-supplying to these cities and consequently losing revenue.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which states perform best/worst?

**SQL Query:**
-- Which states perform best/worst?

WITH state_revenue AS (
  SELECT 
    shipping_state,
    SUM(amount) AS total_revenue
  FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
  WHERE `shipping_state` IS NOT NULL
     AND `amount` IS NOT NULL
  GROUP BY shipping_state
),

ranked_states AS (
  SELECT 
    shipping_state,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS top_rank,
    RANK() OVER (ORDER BY total_revenue ASC) AS bottom_rank
  FROM state_revenue
)

SELECT 
  shipping_state,
  total_revenue,
  'Top 5' AS performance_group
FROM ranked_states
WHERE top_rank <= 5

UNION ALL

SELECT 
  shipping_state,
  total_revenue,
  'Bottom 5' AS performance_group
FROM ranked_states
WHERE bottom_rank <= 5;  
...

**Output Description:**
  ## BEST PERFORMING STATES
shipping_state	total_revenue	      performance_group
MAHARASHTRA	    12451646.720000003	Top 5
KARNATAKA	      9832369.7600000035	Top 5
UTTAR PRADESH	  6441333.5700000161	Top 5
TELANGANA	      6345101.0300000031	Top 5
TAMIL NADU	    5959175.6599999964	Top 5
  ## WORST PERFORMING STATES
PB	            399.0	              Bottom 5
AR	            493.0	              Bottom 5
PONDICHERRY	    529.0	              Bottom 5
RAJSHTHAN	      563.0	              Bottom 5
PUNJAB/MOHALI/ZIRAKPUR	568.0	      Bottom 5
...

**Insight:**
  “The revenue distribution across regions is highly skewed, with a small number of regions contributing the majority of sales.
  This indicates strong market concentration, while several regions show significantly lower performance, suggesting potential 
  opportunities for market expansion or operational improvement. However, the reliance on top-performing regions also introduces 
  revenue concentration risk.”
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Are there cities with high cancellations?

**SQL Query:**
  -- We will take the top 10 cities
SELECT `shipping_city`, SUM(is_cancelled) AS number_of_cancellations
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `shipping_city`
ORDER BY `number_of_cancellations` DESC
LIMIT 10
...

**Output Description:**
shipping_city	number_of_cancellations
BENGALURU	    1311
HYDERABAD	    1194
NEW DELHI	    788
MUMBAI	      784
CHENNAI	      721
PUNE	        556
KOLKATA	      354
THANE	        248
LUCKNOW	      231
GURUGRAM	    208
...

**Insight:**
  The cities with the high cancellation most likely don't value the products as much, therefore they are less likely to be lifelong 
  customers. Thus, it would require large funding of marketing to establish the products in those cities.
  Or it could be the case that there is a courier/website lag or malfunction specific to that those specific city that 
  frustrates the customers and results in them cancelling. This case would be easier and cheaper to fix than the former case.
...
_________________________________________________________________
__________________________________________________________________________________________________________________________
5. OPERATIONS & LOGISTICS
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which cities generate the most revenue?

**SQL Query:**
  -- We will choose the top 10 cities that generate the most revenue
SELECT `shipping_city`, ROUND(SUM(amount), 2) AS total_revenue
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `shipping_city`
ORDER BY `total_revenue` DESC
LIMIT 10
...

**Output Description:**
shipping_city	total_revenue
BENGALURU	    6797490.49
HYDERABAD	    5117817.79
MUMBAI	      3960358.98
NEW DELHI	    3708238.79
CHENNAI	      3293185.44
PUNE	        2607185.68
KOLKATA	      1584569.37
GURUGRAM	    1216550.37
THANE	        1048748.86
LUCKNOW	      1004524.28
...

**Insight:**
This information could help the company divest their marketing funds from the cities making the revenue since the population there is 
  already familiar with the product. They could then invest in cities which make less revenue.
...
_________________________________________________________________
  ## Task X: Create Cleaned Dataset View

**Business Question:**
Which states perform best/worst?

**SQL Query:**
  ## By Revenue
SELECT `shipping_state`, ROUND(SUM(amount), 2) AS total_revenue
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `shipping_state`
ORDER BY `total_revenue` DESC
LIMIT 10

  NOTE: THESE QUERIES WILL HAVE TO BE RUN SEPARATELY
  
  ## By Quantity
SELECT  `shipping_state`, SUM(quantity) AS total_quantity
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_deduplicated`
GROUP BY `shipping_state`
ORDER BY `total_quantity` DESC
LIMIT 10
...

**Output Description:**
  ## By Revenue
shipping_state	total_revenue
MAHARASHTRA	    12447098.97
KARNATAKA	      9826657.94
UTTAR PRADESH	  6427988.65
TELANGANA	      6336032.65
TAMIL NADU	    5961710.59
DELHI	          4074045.05
KERALA	        3559161.49
WEST BENGAL	    3322491.76
ANDHRA PRADESH	2955181.58
HARYANA	        2702759.68

  ## By Quantity
shipping_state	total_quantity
MAHARASHTRA	    18969
KARNATAKA	      14835
TAMIL NADU	    9552
TELANGANA	      9402
UTTAR PRADESH	  8973
DELHI	          5937
KERALA	        5392
WEST BENGAL	    5033
ANDHRA PRADESH	4409
GUJARAT	        3848
...

**Insight:**
  This tells us where which states have the highest demand for the company products and which states the most products. Some 
  funding for marketing can targeted away from the states with the highest revenue since they have less space for growth, assuming the 
  the population of the said states consist of fairly few people. With regards to the quantity bought by each state, there is a wide 
  gap between the two most popular states and the other states. This shows that the two states (MAHARASHTRA AND KARNATAKA) most likely have the 
  products as a staple (perhaps as a symbol of culture or influence).
...
_________________________________________________________________
__________________________________________________________________________________________________________________________
