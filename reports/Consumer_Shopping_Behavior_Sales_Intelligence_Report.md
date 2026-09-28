# Consumer Shopping Behavior & Sales Intelligence

## 1. Project Overview

### Business Problem

A retail company wants to understand consumer shopping behavior in order to identify purchasing patterns, customer segments, product category trends, and factors associated with customer purchasing behavior.

The analysis focuses on customer demographics, product categories, purchase amounts, seasons, discounts, subscription status, payment methods, purchase frequency, reviews, and previous purchases.

### Project Objective

The objective of this project is to:

- Analyze consumer shopping behavior.
- Identify customer behavioral segments.
- Understand product category and seasonal purchasing patterns.
- Analyze payment method and purchase frequency patterns.
- Examine subscription and discount usage.
- Build an interactive Power BI dashboard.
- Generate business insights from the analyzed data.

### Technology Stack

| Area | Technology |
|---|---|
| Data Preparation | Python |
| Data Analysis | Pandas, NumPy |
| Data Visualization | Matplotlib, Power BI |
| Database | PostgreSQL |
| Query Language | SQL |
| Dashboard | Power BI |
| Calculations | DAX |


## 2. Dataset & Data Understanding

### Dataset Description

The dataset contains customer-level shopping behavior records used to analyze purchasing patterns and customer characteristics.

The dataset contains:

- **3,900 records**
- **18 columns**
- **3,900 unique Customer IDs**

### Main Variables

| Variable | Description |
|---|---|
| Customer ID | Unique customer identifier |
| Age | Customer age |
| Gender | Customer gender |
| Item Purchased | Product purchased |
| Category | Product category |
| Purchase Amount (USD) | Recorded purchase amount in USD |
| Location | Customer location |
| Size | Product size |
| Color | Product color |
| Season | Season associated with the purchase |
| Review Rating | Customer review rating |
| Subscription Status | Subscription status |
| Shipping Type | Shipping/fulfillment method |
| Discount Applied | Whether a discount was applied |
| Promo Code Used | Whether a promotional code was used |
| Previous Purchases | Number of previous purchases reported in the dataset |
| Payment Method | Payment method used |
| Frequency of Purchases | Reported purchase frequency |

### Data Structure

The dataset contains demographic, product, purchasing, promotional, and behavioral attributes.

The data was treated as a **customer-level shopping behavior dataset** rather than a complete historical transaction database because each Customer ID appears once in the dataset.

### Initial Data Quality Checks

The following checks were performed during data preparation:

- Dataset dimensions were verified.
- Data types were inspected.
- Missing values were identified.
- Duplicate records were checked.
- Customer ID uniqueness was verified.
- Leading and trailing spaces in text fields were checked.
- Numeric value ranges were reviewed.
- Categorical values were inspected.


## 3. Data Preparation & Cleaning

The raw dataset was prepared using Python with Pandas and NumPy before performing SQL analysis and Power BI visualization.

### Data Cleaning Steps

The following data preparation steps were performed:

1. Loaded the raw CSV dataset using Pandas.
2. Checked the number of rows and columns.
3. Inspected column names and data types.
4. Checked for missing values.
5. Checked for duplicate records.
6. Verified Customer ID uniqueness.
7. Checked text fields for leading and trailing spaces.
8. Reviewed the ranges of numeric columns.
9. Examined categorical values for consistency.
10. Exported the validated dataset as a cleaned CSV file.

### Missing Values

The `Review Rating` column contained **37 missing values** out of 3,900 records.

These values were retained as missing rather than being imputed because review ratings are subjective and could not be reliably inferred from the available data.

### Duplicate Check

No duplicate records were identified in the dataset.

All **3,900 Customer IDs were unique**, with one record per Customer ID in the dataset.

### Numeric Validation

The following observed ranges were reviewed:

| Column | Minimum | Maximum |
|---|---:|---:|
| Age | 18 | 70 |
| Purchase Amount (USD) | 20 | 100 |
| Review Rating | 2.5 | 5.0 |
| Previous Purchases | 1 | 50 |

### Data Consistency Checks

The `Discount Applied` and `Promo Code Used` fields contained identical values for all 3,900 records. Both fields were retained as provided in the source dataset.

The cleaned dataset was saved as:

`data/cleaned/customer_shopping_behavior_cleaned.csv`

This cleaned dataset was subsequently used for PostgreSQL analysis and Power BI reporting.

## 4. Exploratory Data Analysis (Python)

Exploratory Data Analysis (EDA) was performed using Python, Pandas, NumPy, and Matplotlib to understand customer behavior and identify important patterns before database and dashboard analysis.

### Overall Metrics

| Metric | Result |
|---|---:|
| Total Customers | 3,900 |
| Total Recorded Purchase Amount | $233,081 |
| Average Purchase Amount | $59.76 |
| Average Review Rating | 3.75 |
| Average Previous Purchases | 25.35 |
| Customers with Subscription | 1,053 |
| Customers with Discount | 1,677 |
| Missing Review Ratings | 37 |

### Category Analysis

| Category | Customers | Recorded Purchase Amount | Average Purchase |
|---|---:|---:|---:|
| Clothing | 1,737 | $104,264 | $60.03 |
| Accessories | 1,240 | $74,200 | $59.84 |
| Footwear | 599 | $36,093 | $60.26 |
| Outerwear | 324 | $18,524 | $57.17 |

Clothing has the highest number of records and the highest total recorded purchase amount among the product categories.

### Seasonal Analysis

| Season | Customers | Recorded Purchase Amount | Average Purchase |
|---|---:|---:|---:|
| Fall | 975 | $60,018 | $61.56 |
| Spring | 999 | $58,679 | $58.74 |
| Winter | 971 | $58,607 | $60.36 |
| Summer | 955 | $55,777 | $58.41 |

Fall has the highest recorded purchase amount and the highest average purchase amount among the four seasons.

### Subscription Analysis

| Subscription Status | Customers | Recorded Purchase Amount | Average Purchase | Avg. Previous Purchases |
|---|---:|---:|---:|---:|
| No | 2,847 | $170,436 | $59.87 | 25.08 |
| Yes | 1,053 | $62,645 | $59.49 | 26.08 |

Subscription customers represent 1,053 records in the dataset.

### Discount Analysis

| Discount Applied | Customers | Recorded Purchase Amount | Average Purchase |
|---|---:|---:|---:|
| No | 2,223 | $133,670 | $60.13 |
| Yes | 1,677 | $99,411 | $59.28 |

The analysis describes differences between records with and without discounts. These results should not be interpreted as evidence that discounts caused changes in purchase amount.

### Payment Method Analysis

Recorded purchase amounts were relatively similar across the payment methods.

| Payment Method | Customers | Recorded Purchase Amount | Average Purchase |
|---|---:|---:|---:|
| Credit Card | 671 | $40,310 | $60.07 |
| PayPal | 677 | $40,109 | $59.25 |
| Cash | 670 | $40,002 | $59.70 |
| Debit Card | 636 | $38,742 | $60.92 |
| Venmo | 634 | $37,374 | $58.95 |
| Bank Transfer | 612 | $36,544 | $59.71 |

### Purchase Frequency Analysis

The dataset contains seven reported purchase-frequency categories:

- Every 3 Months
- Annually
- Quarterly
- Monthly
- Bi-Weekly
- Fortnightly
- Weekly

The recorded purchase amounts across these frequency groups were relatively similar.

### Customer Behavioral Segmentation

Customer segments were created using the `Previous Purchases` field:

| Segment | Previous Purchases | Customers | Avg. Previous Purchases | Avg. Purchase |
|---|---:|---:|---:|---:|
| High | 35 or more | 1,210 | 42.63 | $60.40 |
| Medium | 20–34 | 1,212 | 27.02 | $59.14 |
| Low | Below 20 | 1,478 | 9.84 | $59.75 |

The High segment has the highest average number of previous purchases, while the Low segment contains the largest number of customer records.

These segments are behavioral groupings based on the `Previous Purchases` field and should not be interpreted as confirmed customer lifetime-value or transaction-history segments.

### Category and Gender Analysis

The category mix was broadly similar across male and female records. Clothing represented approximately 44.5% of both groups, while Accessories represented approximately 31–32%.

### Review Rating Analysis

The correlation between Review Rating and Purchase Amount was approximately **0.0299**, indicating a very weak linear association in this dataset.

Correlation does not establish causation, so this result was treated as a descriptive statistical observation rather than a causal relationship.


## 5. PostgreSQL & SQL Analysis

The cleaned dataset was imported into PostgreSQL to perform structured business analysis using SQL.

### Database Setup

A PostgreSQL database named `consumer_shopping_db` was created.

The cleaned dataset was loaded into the table:

`customer_shopping_behavior`

The table contains 18 columns and 3,900 customer-level records.

### SQL Analysis Performed

SQL queries were used to analyze:

- Product category performance
- Seasonal purchase patterns
- Subscription behavior
- Discount usage
- Payment method preferences
- Purchase frequency
- Customer behavioral segments
- Segment and category combinations
- Geographic purchase patterns
- Subscription and discount combinations
- Category rankings within customer segments

### Category Performance

The SQL analysis showed that Clothing had the highest recorded purchase amount at **$104,264**, followed by Accessories at **$74,200**.

### Seasonal Performance

Fall recorded the highest total purchase amount at **$60,018**, followed by Spring, Winter, and Summer.

### Customer Behavioral Segmentation

A SQL `CASE` expression was used to create behavioral segments based on `Previous Purchases`:

```sql
CASE
    WHEN previous_purchases >= 35 THEN 'High'
    WHEN previous_purchases >= 20 THEN 'Medium'
    ELSE 'Low'
END

The resulting segments were:

| Segment | Customers | Avg. Previous Purchases | Avg. Purchase |
|---|---:|---:|---:|
| High | 1,210 | 42.63 | $60.40 |
| Medium | 1,212 | 27.02 | $59.14 |
| Low | 1,478 | 9.84 | $59.75 |

### Segment and Category Analysis

SQL was used to compare product categories within each behavioral segment.

Key observations included:

- Clothing had the highest average purchase amount within the High and Medium segments.
- Accessories had the highest average purchase amount within the Low segment.
- Footwear was also among the higher-average-purchase categories across the segments.
- Outerwear generally had lower average purchase amounts compared with the other categories.

### Subscription and Discount Analysis

Subscription and discount fields were analyzed together to understand their observed relationship in the dataset.

The analysis showed:

- 2,223 records had neither subscription nor discount.
- 624 records had a discount but no subscription.
- 1,053 records had both subscription and discount.
- There were no records with subscription but without a discount.

These results describe the structure of the supplied dataset and do not establish that subscription status causes discount usage.

### Geographic Analysis

Purchase amounts were aggregated by customer location to identify locations with higher recorded purchase totals.

The analysis was used as a descriptive geographic comparison rather than as a measure of market potential because the number of records varies by location.

### Advanced SQL Analysis

Common Table Expressions (CTEs) and the `RANK()` window function were used to rank product categories within each customer behavioral segment.

This analysis helped identify the highest-average-purchase categories for High, Medium, and Low behavioral segments.

### SQL Skills Demonstrated

The PostgreSQL analysis demonstrated practical use of:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- Aggregate functions such as `SUM()` and `AVG()`
- `CASE` expressions
- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- Multi-column grouping
- Conditional aggregation
- Business-oriented SQL analysis


## 6. Power BI Dashboard & DAX

Power BI was used to convert the analyzed customer shopping data into an interactive business dashboard.

The dashboard contains two pages:

### Page 1 — Executive Overview

The Executive Overview provides a high-level view of customer and sales-related metrics.

#### Key Performance Indicators

The dashboard includes:

- Total Customers
- Total Purchase Amount
- Average Purchase Amount
- Average Review Rating
- Subscription Rate

#### Business Analysis Visuals

The page also includes:

- Purchase Amount by Category
- Purchase Amount by Season
- Customers by Subscription Status
- Customers by Customer Segment
- Average Purchase by Segment
- Purchase Amount by Payment Method
- Purchase Amount by Discount Status
- Purchase Amount by Purchase Frequency

Interactive slicers for **Category** and **Season** allow users to filter the dashboard and observe changes across the displayed metrics.

### Page 2 — Customer & Purchase Behavior

The second page focuses on customer segmentation and purchasing behavior.

Visuals include:

- Customer Segment Distribution
- Average Purchase by Customer Segment
- Average Previous Purchases by Customer Segment
- Customers by Segment & Category
- Purchase Amount by Purchase Frequency
- Purchase Amount by Payment Method

This page provides a more detailed view of customer behavior and purchasing patterns.

### DAX Measures

The following DAX measures were created for the dashboard:

```DAX
Total Customers =
DISTINCTCOUNT(
    customer_shopping_behavior_cleaned[Customer ID]
)


## 7. Key Business Insights & Recommendations

### Key Business Insights

Based on the Python, PostgreSQL, and Power BI analysis, the following observations were identified:

1. **Clothing is the largest category**
   
   Clothing contains 1,737 customer records and has the highest recorded purchase amount of $104,264.

2. **Fall has the highest recorded purchase amount**
   
   Fall recorded $60,018 in purchase amount and had the highest average purchase amount at $61.56 among the four seasons.

3. **Customer behavioral segments differ mainly in previous purchases**
   
   The High segment has an average of 42.63 previous purchases, compared with 27.02 for Medium and 9.84 for Low.

4. **Average purchase amounts are relatively close across segments**
   
   The average recorded purchase amount was $60.40 for High, $59.14 for Medium, and $59.75 for Low.

5. **Payment methods show relatively similar recorded purchase amounts**
   
   No payment method showed a large difference in average purchase amount compared with the others.

6. **Discount usage is present across a substantial portion of the dataset**
   
   1,677 records have a discount applied, while 2,223 records do not.

7. **Subscription and discount usage overlap in the supplied data**
   
   All 1,053 subscription records also have a discount applied. This describes the supplied dataset and does not establish a causal relationship between subscription and discount usage.

### Business Recommendations

Based on these descriptive findings, the following areas could be considered by a retail business:

- Monitor Clothing performance because it represents the largest category in the dataset.
- Review seasonal purchasing patterns when planning inventory and marketing activities.
- Use behavioral segments to organize customer analysis and targeted engagement strategies.
- Compare customer engagement initiatives across High, Medium, and Low behavioral groups.
- Continue monitoring payment method usage to ensure commonly used payment options remain supported.
- Analyze discount usage alongside customer behavior before designing promotional campaigns.
- Investigate subscription and discount relationships further using transaction-level data if available.
- Use Power BI dashboard filters to regularly compare category and seasonal performance.

## 8. Limitations & Data Considerations

The following limitations were considered while interpreting the analysis.

### 1. Customer-Level Dataset

The dataset contains one record per Customer ID. Therefore, it represents customer-level shopping behavior rather than a complete historical transaction database.

### 2. Previous Purchases

The `Previous Purchases` field was used as a behavioral indicator for customer segmentation.

It should not be interpreted as a complete transaction history or as a direct measure of customer lifetime value.

### 3. No Explicit Online/Offline Channel

The dataset does not contain a dedicated online/offline sales-channel field.

Therefore, `Shipping Type` was analyzed as a shipping or fulfillment attribute and was not treated as an online/offline sales-channel indicator.

### 4. Missing Review Ratings

There are 37 missing values in the `Review Rating` column.

These values were retained as missing because subjective ratings could not be reliably inferred from the available data.

### 5. Discount and Promo Code Fields

`Discount Applied` and `Promo Code Used` contain identical values across all 3,900 records.

Both fields were retained as provided in the source dataset.

### 6. Source Frequency Labels

The dataset contains both `Every 3 Months` and `Quarterly` as separate source values.

They were retained as separate categories rather than being silently merged.

### 7. Causality

The analysis identifies descriptive patterns and relationships in the available data.

Observed differences, correlations, or group-level patterns should not be interpreted as proof of causation.

### 8. Geographic Comparison

Locations contain different numbers of customer records.

Therefore, total purchase amounts by location should be interpreted as descriptive results rather than direct measures of market potential.

### 9. Dataset Scope

The findings are limited to the variables and records available in the supplied dataset.

Additional transaction-level information, customer history, marketing campaign data, costs, profitability, and channel information would be required for deeper business analysis.

## 9. Conclusion & Project Outcome

This project demonstrates an end-to-end data analytics workflow for understanding consumer shopping behavior.

The project started with raw customer shopping data and progressed through data preparation, exploratory analysis, SQL-based business analysis, and interactive Power BI visualization.

### End-to-End Workflow

```text
Raw Dataset
     ↓
Python Data Preparation & EDA
     ↓
Cleaned Dataset
     ↓
PostgreSQL Database
     ↓
SQL Business Analysis
     ↓
Power BI Data Modeling & DAX
     ↓
Interactive Dashboard
     ↓
Business Insights