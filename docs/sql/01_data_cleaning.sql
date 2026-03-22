-- Data cleaning queries will go here
## We are now done with the Exploratory Data Analysis, so we will be cleaning the data here.
________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
How can we create a cleaner version of the dataset that we will be able to further clean and then import to our visualisation tools?

**SQL Query:**
CREATE VIEW `capstone-projects-489309.amazon_sales_analysis.cleaned_data` AS
SELECT 
        `Order ID`,
        `Date`,
        Status,
        Fulfilment,
        `Sales Channel `,
        `ship-service-level`,
        Style,
        SKU,
        Category,
        Size,
        `ASIN`,
        -- Standardize courier status (keep NULLs as is)
        `Courier Status`,
        Qty,
        -- Keep RAW Amount (do NOT modify)
        Amount, 
        -- Standardize city formatting
        UPPER(`ship-city`) AS ship_city,
        `ship-state`,
        `ship-postal-code`,
        `ship-country`,
        -- Business flags (FEATURE ENGINEERING)
        CASE 
            WHEN Status = 'Cancelled' THEN 1
            ELSE 0
            END AS is_cancelled,
        CASE 
            WHEN `promotion-ids` IS NULL THEN 0
            ELSE 1
            END AS has_promotion,
        CASE
            WHEN B2B = TRUE THEN 1
            ELSE 0
            END AS is_b2b,
        -- Keep raw promotion-ids data (do NOT overwrite)
        `promotion-ids`,
        B2B
FROM `capstone-projects-489309.amazon_sales_analysis.amazon_sales_table`

...

**Output Description:**
The new VIEW did the following
  - It removed the problematic column "unnamed: 22"
  - It made the values for ship-city upper case for better consistency in the data
  - It created three new columns: is_cancelled, has_promotion, is_b2b. 
...

**Insight:**
  - The problematic "unnamed: 22" is now gone.
  - We will not find any inconsistencies in the shipping city data, such as the same city being written in different letter cases
  and thus being interpreted as being different.
  - The three new columns will help with dealing with the NULL values of the corresponding columns. They help us avoid making errors and
  inefficies because we would have to constantly filter out NULL values if it were not for them. Also, they serve as good KPI measures.
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
How can we fix the naming conventions and ensure that the letter casing is not a part of the reason we get misleading information?

**SQL Query:**
  CREATE OR REPLACE VIEW `capstone-projects-489309.amazon_sales_analysis.amazon_cleaned_data` AS
SELECT 
        -- We are changing the column names for better consistency
        -- We are writing all the categorical groups in upper case for better writing and consistency
        -- We are converting the FLOAT in ship-postal-code to INT64
        `Order ID` AS order_id,
        `Date` AS order_date,
        UPPER(Status) AS status,
        UPPER(Fulfilment) AS fulfilment,
        UPPER(`Sales Channel `) AS sales_channel,
        UPPER(`ship-service-level`) AS shipping_service_level,
        Style AS style,
        SKU AS stock_keeping_unit,
        UPPER(Category) AS category,
        UPPER(Size) AS size,
        `ASIN` AS amazon_standard_identification_number,
        UPPER(`Courier Status`) AS courier_status,
        `Qty` AS quantity,
        Amount AS amount, 
        UPPER(`ship_city`) AS shipping_city,
        UPPER(`ship-state`) AS shipping_state,
        `ship-postal-code` AS shipping_postal_code,
        UPPER(`ship-country`) AS shipping_country,
        `is_cancelled`,
        `has_promotion`,
        `is_b2b`,
        `promotion-ids` AS promotion_ids,
        `B2B` AS b2b
FROM `capstone-projects-489309.amazon_sales_analysis.cleaned_data`
...

**Output Description:**
  - All the column names have now changed been changed into conventional SQL naming: lowercase letters separated by space bars between
  - "Status", "Fulfilment", "Sales Channel", "ship-service-level", "Category", "Size", "Courier Status", "ship-city", "ship-state", 
    "ship-country" have values that are in upper case.
...

**Insight:**
  The better naming conventions will ensure fewer bugs in the SQL queries and better consistency in the headers. 
  The categorical columns having values only in uppercase will ensure there are misleading information... for example, now the same 
  name in both uppercase and lowercase will be the same name.
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...


________________________________________________________________________________________________________
## Task X: Create Cleaned Dataset View

**Business Question:**
What is the analysis-ready version of the Amazon sales dataset after standardizing structure, handling missing values, and creating key business flags?

**SQL Query:**
...

**Output Description:**
...

**Insight:**
...
