# Customer & Commercial Analytics

## Project Overview

This project analyzes e-commerce customer and sales data to understand customer behavior, revenue performance, purchasing patterns, discounts, and commercial performance.

The analysis focuses on answering practical business questions using SQL and turning transaction-level data into useful customer and commercial insights.

## Business Objectives

- Understand overall customer and order performance
- Identify high-value customers
- Analyze revenue by product category
- Compare returning and non-returning customers
- Understand customer purchase frequency
- Analyze the impact of discounts on revenue and order value
- Compare performance across devices
- Analyze delivery time and customer ratings
- Measure customer contribution to total revenue
- Identify top-performing categories and customers

## Dataset

**Dataset:** E-Commerce Customer Behavior Dataset V2

The dataset contains e-commerce transaction and customer behavior information.

### Key Columns

- `Order_ID` - Unique order identifier
- `Customer_ID` - Customer identifier
- `Date` - Order date
- `Age` - Customer age
- `Gender` - Customer gender
- `City` - Customer city
- `Product_Category` - Product category
- `Unit_Price` - Price per unit
- `Quantity` - Quantity purchased
- `Discount_Amount` - Discount applied
- `Total_Amount` - Final transaction amount
- `Payment_Method` - Payment method
- `Device_Type` - Device used for the purchase
- `Session_Duration_Minutes` - Session duration
- `Pages_Viewed` - Number of pages viewed
- `Is_Returning_Customer` - Returning customer indicator
- `Delivery_Time_Days` - Delivery time
- `Customer_Rating` - Customer rating

## SQL Analysis

The project covers 18 business questions across:

### Customer Analytics
- Customer count
- Customer revenue
- Customer order frequency
- First and latest purchases
- Purchase gaps
- Customer revenue ranking
- Revenue contribution

### Commercial Analytics
- Total revenue
- Revenue by product category
- Top-performing categories
- Discount impact
- Average order value
- Device-level performance

### Customer Experience
- Delivery time analysis
- Customer ratings
- Returning vs non-returning customer behavior

## SQL Techniques Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- Aggregate functions
- `CASE WHEN`
- `CTE`
- `JOIN`
- Window functions
- `ROW_NUMBER()`
- `DENSE_RANK()`
- `LAG()`
- `DATEDIFF()`
- Conditional aggregation
- `COUNT(DISTINCT)`
- Running totals and contribution analysis

## Project Structure

```text
customer-commercial-analytics/
│
├── README.md
├── challenges.md
└── solutions.sql
