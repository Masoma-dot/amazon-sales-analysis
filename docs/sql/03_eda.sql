-- EDA will be performed here
# SQL Work Log

EXPLORATORY DATA ANALYSIS WILL BE PERFORMED HERE

-- Format of the each layout.
______________________________________________________________________________________
## Task X: Counting the number of rows

**Business Question:** 
How many rows are in the dataset?
...

**SQL Query:**
SELECT COUNT(*) 
FROM `amazon_sales_analysis.amazon_sales_table`
...

**Output Description:**
There are 128975 rows in the dataset.
...

Insight:
The number of rows align with the number mentioned on https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data (when we exclude the header row).
...
_____________________________________________________________________________________

## Task X: Check the number of columns and the data type of each column.

**Business Question:**
How many columns describe the data we are working with, and what are the types of data in the dataset?
...

**SQL Query:**
#### Checking the number of rows in the table
SELECT column_name, data_type
FROM `capstone-projects-489309.amazon_sales_analysis.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'amazon_sales_table'

#### Checking the number of each data type
WITH column_description AS ( 
SELECT column_name, data_type
FROM `capstone-projects-489309.amazon_sales_analysis.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'amazon_sales_table')

SELECT COUNT(data_type), data_type
FROM column_description
GROUP BY data_type
...

**Output Description:**
There are 24 columns in the dataset. Number of data types: INT64 (2), STRING (18), DATE (1), FLOAT64 (2), BOOL (1).
...

**Insight:**
Due to the high number of columns in the dataset, this dataset is actually very important since we can check relationships between different columns to derive information to make better business decisions.
Due to the number of data types, this shows that the data is most descriptive. In other words, it has more Dimensions and fewer Metrics.
...
_____________________________________________________________________________________

## Task X: (Name)

**Business Question:**
Does the data have duplicates? If yes, how many Order IDs have duplicates?
...

**SQL Query:**
#### Checking if there are duplicates in the dataset.
SELECT `Order ID`, COUNT(*)
FROM `amazon_sales_analysis.amazon_sales_table`
GROUP BY `Order ID`
HAVING COUNT(*) > 1

#### Checking how many Order IDs have duplicates.
WITH checking_duplicates AS (
SELECT `Order ID`, COUNT(*)
FROM `amazon_sales_analysis.amazon_sales_table`
GROUP BY `Order ID`
HAVING COUNT(*) > 1)

SELECT COUNT(`Order ID`)
FROM checking_duplicates
...

**Output Description:**
Yes, here are a lot of Order IDs that have duplicates in the dataset. Specifically, 6846 Order IDs have duplicates.
...

**Insight:**
To avoid making misleading business insights using the data, the duplicates of Order ID have to be removed.
...
_____________________________________________________________________________________

## Task X: (Name)

**Business Question:**
How many rows in the data have missing/NULL values?
...

**SQL Query:**
SELECT 
  COUNT(*) AS total_rows,
  SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS missing_amount
FROM `amazon_sales_analysis.amazon_sales_table`;
...

**Output Description:**
-- There are 128975 total rows.
-- "Couriers" has 6872 missing values
-- "Currency" has 7795 missing values
-- "Amount" has 7795 missing values
-- "Shipping City" has 33 missing values
-- "Shipping State" has 33 missing values
-- "Shipping Postal Code" has 33 missing values
-- "Promotions IDs" has 49153 missing values
-- "Fulfilled by" has 89698 missing values
-- "Unnamed:22" has 49050 missing values
So the columns that contain missing values are: COURIERS, CURRENCY, AMOUNT, SHIPPING CITY, SHIPPING STATE, SHIPPING POSTAL CODE, PROMOTION IDS, FULFILLED BY, and UNNAMED:22
...

**Insight:**
It's still not wise to remove the rows since removing them would mean removing some information in those rows that's important. So we will work with the data while keeping in mind we have to exclude them in our queries, given the context.
As a result, we have to know which columns SPECIFICALLY have missing values. It's not important to find the number of missing rows since we won't remove the rows regardless.
...
_____________________________________________________________________________________

## Task X: (Name)

**Business Question:**
How many distinct values does each column have?
...

**SQL Query:**
SELECT 'Order ID' AS column_name, COUNT(DISTINCT `Order ID`) AS distinct_count
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Date', COUNT(DISTINCT `Date`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Status', COUNT(DISTINCT Status)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Fulfilment', COUNT(DISTINCT Fulfilment)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Sales Channel ', COUNT(DISTINCT `Sales Channel `)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ship-service-level', COUNT(DISTINCT `ship-service-level`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Style', COUNT(DISTINCT Style)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'SKU', COUNT(DISTINCT SKU)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Category', COUNT(DISTINCT Category)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Size', COUNT(DISTINCT Size)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ASIN', COUNT(DISTINCT ASIN)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Courier Status', COUNT(DISTINCT `Courier Status`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Qty', COUNT(DISTINCT Qty)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'currency', COUNT(DISTINCT currency)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Amount', COUNT(DISTINCT Amount)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ship-city', COUNT(DISTINCT `ship-city`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ship-state', COUNT(DISTINCT `ship-state`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ship-postal-code', COUNT(DISTINCT `ship-postal-code`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'ship-country', COUNT(DISTINCT `ship-country`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'promotion-ids', COUNT(DISTINCT `promotion-ids`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'B2B', COUNT(DISTINCT B2B)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'fulfilled-by', COUNT(DISTINCT `fulfilled-by`)
FROM `amazon_sales_analysis.amazon_sales_table`

UNION ALL

SELECT 'Unnamed: 22', COUNT(DISTINCT `Unnamed: 22`)
FROM `amazon_sales_analysis.amazon_sales_table`;
...

**Output Description:**
-- Category has 9 distinct values
-- ship-country has 1 distinct value
-- ship-postal-code has 9459 distinct values
-- ship-service-level has 2 distinct values
-- Qty has 10 distinct values
-- B2B has 2 distinct values
-- ship-state has 69 distinct values
-- Courier Status has 3 distinct values
-- Amount has 1410 distinct values
-- promotion-ids has 5787 distinct values
-- Sales Channel has 2 distinct values
-- ASIN has 7190 distinct values
-- SKU has 7195 distinct values
-- Date has 91 distinct values
-- currency has 1 distinct value
-- Style has 1377 distinct values
-- Unnamed: 22 has 1 distinct value
-- ship-city has 8955 distinct values
-- fulfilled-by has 1 distinct value
-- Size has 11 distinct values
-- Fulfilment has 2 distinct values
-- Status has 13 distinct values
-- Order ID has 120378 distinct values
...

**Insight:**
The columns have less than 20 distinct values (as a rule of thumb) can be easier to visualize using simple methods like bar graphs and histograms for faster and more efficient insights.
...
_____________________________________________________________________________________

## Task X: (Name)

**Business Question:**
...

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...
_____________________________________________________________________________________

