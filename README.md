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
THE CLEANED DATASET IN GOOGLE BIGQUERY WILL CONNECTED TO POWER BI FOR VISUALISATIONS.
##### Quick, important facts before gathering insights from the visuals.
India is generally classified as a lower-middle-income country by global standards.
For the average citizen, spending around INR 649.51 every 30 days on clothing would be considered moderate to somewhat discretionary, meaning affordable for middle-class consumers but relatively high for lower-income groups.
The average monthly salary in India is roughly INR 25,000–30,000, though it varies widely by region, job type, and urban vs rural areas.
#### EXECUTIVE OVERVIEW

Key Performance Indices

<img width="657" height="75" alt="amazon-kpi-insights-visualisation" src="https://github.com/user-attachments/assets/792b00f9-a045-421c-9247-f9d96903fc25" />

The average order cost is 649.81. With the average monthly salary of 25,000-30,000, affordability/prices of the products is not a problem. The total quantity of 108,771 is underwhelming (since India has a population of roughly 1.43 billion people, therefore saturation is not the problem and there is a lot of room for quantity growth. The same applies to the total revenue made during the period.


Total Revenue Made Each Day
<img width="754" height="262" alt="amazon-revenue-by-day-visualisation" src="https://github.com/user-attachments/assets/2556060d-bf4a-49e3-ba33-cbe268ebbf8d" />

The period is between 30 April and 31 May. The total revenue decreases steadily during this period. This shows the customers are non-recurring. The customers can afford to buy at anytime of the month (as the revenue doesn't dip rapidly even during no-pay periods during the month).

#### PRODUCT PERFORMANCE
<img width="757" height="260" alt="10-highest-revenue-sku-visualization" src="https://github.com/user-attachments/assets/67224f15-1cde-479f-92ed-7fd73795fe41" />

Most of the revenue is made by a select few of SKUs (roughly 30 SKUs). This roughly makes Pareto's rule valid: 80% of revenue comes from 20% of the SKUs. For a higher return of revenue, most of the focus should on the top 30 SKUs.

#### REGIONAL PERFORMANCE
<img width="756" height="414" alt="revenue-by-state-visualisation" src="https://github.com/user-attachments/assets/a86f4851-2a44-4473-bc73-a8d0c823d2ba" />

Almost 100% of the revenue comes from 25 states. Thus, people are extremely aware of the products in those states. Marketing in those states should be aimed convert the customers to reoccuring, and at integrating the products with culture that will spread to the other states through campaigns, for example.

#### CANCELLATION INSIGHTS
<img width="346" height="58" alt="amazon-order-cancellation-summary-table" src="https://github.com/user-attachments/assets/31c88f26-09c2-4e97-9432-e578ee53ab18" />
<img width="534" height="196" alt="amazon-cancellations-by-state-visualisation" src="https://github.com/user-attachments/assets/e8933198-dba8-451a-8ccf-298dcdcf6cf6" />

Almost 5% of the orders are cancelled. This creates unnecessary expenses, reduces the profit and caused INR 6,412,390 loss of potential revenue. Only 10 states are the cause for most of the cancellations. Website and courier functionality in those states should be made efficient. Quality control should be ensured before delivering the products.
A survey should be run, asking reasons for cancellations. This is especially for B2B transactions since they are most likely reoccuring.

## BUSINESS RECOMMENDATIONS

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
