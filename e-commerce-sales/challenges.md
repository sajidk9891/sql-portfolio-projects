# SQL Challenges

## 1. Monthly Order Volume

Analyze how monthly order volume changes over time (Dec 2010-Dec 2011).

Count distinct orders, excluding credit notes.

## 2. Top Products by Quantity

Identify the 5 products with highest total quantity sold.

Exclude credit notes and ignore blank descriptions.

Group by SKU (StockCode) + Description.

## 3. Top Products by Net Revenue

Identify the 5 products with highest net revenue.

Ignore blank descriptions.

Group by SKU (StockCode) + Description.
Ties are Ignored: If the 5th, 6th, and 7th products all have the exact same number of sales, 
a strict LIMIT 5 will arbitrarily cut off two of them. 
To fix this, we may need to use window functions like DENSE_RANK() depending on your business logic.

## 4. Top Countries by Net Revenue

Find the top 5 countries by net revenue.

Ignore blank country values.
