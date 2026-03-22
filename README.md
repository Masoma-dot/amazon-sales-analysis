# AMAZON E-COMMERCE SALES ANALYSIS

Note: This project was independently completed. AI tools were used to refine explanations and improve documentation clarity.

## BUSINESS OBJECTIVES
Analyze Amazon sales data to uncover revenue trends, product performance, and regional insights to support business decision-making.

## DATASET OVERVIEW
(To be filled)

## DATA CLEANING
##### Source: Kaggle (specifically: https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data)
#### IMPORTANT COLUMN DESCRIPTIONS:
##### order_id - it shows the order IDs put by the customers
##### order_date - it shows the date at which the orders were made
##### amount - it shows the amount paid for each order made
##### SKU / ASIN - this is the Stock Keeping Unit / Amazon Standard Identification Number
##### shipping_state - the state in which the orders made will be delivered
##### shipping_city - the city in which the orders made will be delivered
##### shipping_postal_code - the postal code of the place at which the order will be delivered
##### status - describes the shipping status of an order made
##### shipping_service_level - states whether the service level is STANDARD or EXPEDITED
##### fulfilment - shows which party fulfilled the order
##### sales channel - answers "Through which platform or method did the customer place the order?"
##### category - shows the category of products that were ordered by the customers
##### style - the style of the product ordered
##### size - shows the size fit of the product ordered
##### shipping_country - the country in which the order made is delivered
##### b2b - states whether the order purchase is made by a business or a regular customer
##### courier_status - track the shipping condition of the order in the courier's responsibility


## DATA TRANSFORMATION
#### Business Question:
How can we create a cleaner version of the dataset that we will be able to further clean and then import to our visualisation tools?
#### Insight:
  - The problematic "unnamed: 22" is now gone.
  - We will not find any inconsistencies in the shipping city data, such as the same city being written in different letter cases
  and thus being interpreted as being different.
  - The three new columns will help with dealing with the NULL values of the corresponding columns. They help us avoid making errors and
  inefficies because we would have to constantly filter out NULL values if it were not for them. Also, they serve as good KPI measures.

## KEY QUESTIONS
### 1. Core Business Health
#### What is the total revenue?
#### What is the total number of orders?
#### What is the total quantity sold?
#### What is the cancellation rate?
#### What is the average order value (AOV)?
____________________________________________________
### 2. Time-Based Analysis
#### How does revenue trend over time (daily/monthly)?
#### Which days had the highest sales?
#### Are there sales spikes or drops?
#### How does cancellation trend over time?

### 3. Product Analysis
#### Which categories generate the most revenue?
#### Which categories have the highest cancellations?
#### Which products (SKU/ASIN) perform best?
#### What is the average order value per category?

### 4. Customer/Location Analysis
#### Which cities generate the most revenue?
#### Which states perform best/worst?
#### Are there cities with high cancellations?

### 5. Operations & Logistics
#### Which cities generate the most revenue?
#### Which states perform best/worst?
#### Are there cities with high cancellations?

## KEY INSIGHTS (IN SHORT DETAIL. THE FULL DETAIL IS IN insights.md)
### Overall Conclusion
#### The business shows strong revenue generation, high order reliability, and clear product-market fit.
#### However, performance is characterized by:
####  - high revenue concentration (products & regions)
####  - short-term volatility in sales trends
####  - untapped potential in underperforming regions

### Strategic Focus Areas:

#### - Diversify revenue across more regions
#### - Stabilize revenue trends through consistent demand strategies
#### - Optimize logistics in high-performing areas
#### - Investigate and reduce cancellation drivers at scale

## DASHBOARD
(To be filled)

## Business Recommendations

#### 1. Expand in Underperforming Regions (Growth Opportunity)
Revenue is heavily concentrated in a few regions, leaving significant untapped markets.

#### Action:

Launch targeted marketing campaigns in low-performing regions
Adjust product offerings and pricing to match regional demand

#### 2. Maximize Top-Performing Products (Revenue Driver)
A small number of products generate the majority of revenue.

#### Action:
Ensure consistent stock availability
Promote top products through ads and bundling strategies
Use them to drive cross-selling

#### 3. Stabilize Revenue Volatility (Business Risk)
Revenue shows high daily fluctuations with no consistent upward trend.

#### Action:
Introduce consistent promotions (weekly/monthly campaigns)
Implement customer retention strategies (loyalty, repeat incentives)

#### 4. Optimize Operations in High-Demand Areas (Efficiency)
High-performing regions drive most of the business and require operational reliability.

#### Action:
Improve inventory allocation and delivery efficiency
Investigate cancellation causes in high-volume areas
