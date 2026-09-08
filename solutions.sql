-- ============================================================
-- E-Commerce Sales Analysis | SQL Portfolio Project
-- Dataset: Kaggle Online Retail (Dec 2010 - Dec 2011)
-- Tools: MySQL Workbench
-- ============================================================


-- ============================================================
-- Challenge 1: Monthly Order Volume
-- Analyze how monthly order volume changes over time.
-- Count distinct orders, excluding credit notes.
-- ============================================================

SELECT
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM sales_data
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY year, month
ORDER BY year, month;



-- ============================================================
-- Challenge 2: Monthly Net Revenue
-- Calculate total net revenue for each month.
-- ============================================================

SELECT
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    SUM(UnitPrice * Quantity) AS net_revenue
FROM sales_data
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY year, month
ORDER BY year, month;



-- ============================================================
-- Challenge 3: Top 5 Products by Quantity Sold
-- Exclude credit notes and blank descriptions.
-- Group by StockCode + Description.
-- ============================================================

WITH ranked_products AS (
    SELECT
        StockCode,
        Description,
        SUM(Quantity) AS total_quantity,
        ROW_NUMBER() OVER (
            ORDER BY SUM(Quantity) DESC
        ) AS rnk
    FROM sales_data
    WHERE InvoiceNo NOT LIKE 'C%'
      AND Description IS NOT NULL
      AND Description <> ''
    GROUP BY StockCode, Description
)

SELECT
    StockCode,
    Description,
    total_quantity
FROM ranked_products
WHERE rnk <= 5;



-- ============================================================
-- Challenge 4: Top 5 Products by Net Revenue
-- Ignore blank descriptions.
-- Group by StockCode + Description.
-- ============================================================

WITH ranked_products AS (
    SELECT
        StockCode,
        Description,
        SUM(UnitPrice * Quantity) AS net_revenue,
        ROW_NUMBER() OVER (
            ORDER BY SUM(UnitPrice * Quantity) DESC
        ) AS rnk
    FROM sales_data
    WHERE Description IS NOT NULL
      AND Description <> ''
    GROUP BY StockCode, Description
)

SELECT
    StockCode,
    Description,
    net_revenue
FROM ranked_products
WHERE rnk <= 5;



-- ============================================================
-- Challenge 5: Top 5 Countries by Net Revenue
-- Ignore blank country values.
-- ============================================================

WITH ranked_countries AS (
    SELECT
        Country,
        SUM(UnitPrice * Quantity) AS net_revenue,
        ROW_NUMBER() OVER (
            ORDER BY SUM(UnitPrice * Quantity) DESC
        ) AS rnk
    FROM sales_data
    WHERE Country IS NOT NULL
      AND Country <> ''
    GROUP BY Country
)

SELECT
    Country,
    net_revenue
FROM ranked_countries
WHERE rnk <= 5;



-- ============================================================
-- Challenge 6: Revenue Contribution by Country
-- Calculate total revenue and each country's contribution.
-- ============================================================

WITH country_revenue AS (
    SELECT
        Country,
        SUM(UnitPrice * Quantity) AS revenue
    FROM sales_data
    WHERE InvoiceNo NOT LIKE 'C%'
    GROUP BY Country
)

SELECT
    Country,
    revenue,
    ROUND(
        revenue * 100 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_share_pct
FROM country_revenue
ORDER BY revenue DESC;



-- ============================================================
-- Challenge 7: Top 10 Customers by Revenue
-- Rank customers based on total purchase value.
-- ============================================================

WITH customer_sales AS (
    SELECT
        CustomerID,
        SUM(UnitPrice * Quantity) AS revenue
    FROM sales_data
    WHERE InvoiceNo NOT LIKE 'C%'
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
)

SELECT
    CustomerID,
    revenue
FROM customer_sales
ORDER BY revenue DESC
LIMIT 10;



-- ============================================================
-- Challenge 8: Average Order Value by Month
-- Calculate average revenue per order each month.
-- ============================================================

WITH monthly_orders AS (
    SELECT
        YEAR(InvoiceDate) AS year,
        MONTH(InvoiceDate) AS month,
        InvoiceNo,
        SUM(UnitPrice * Quantity) AS order_value
    FROM sales_data
    WHERE InvoiceNo NOT LIKE 'C%'
    GROUP BY year, month, InvoiceNo
)

SELECT
    year,
    month,
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM monthly_orders
GROUP BY year, month
ORDER BY year, month;



-- ============================================================
-- Challenge 9: Best-Selling Product in Each Country
-- Find the highest quantity-selling product per country.
-- ============================================================

WITH product_sales AS (
    SELECT
        Country,
        StockCode,
        Description,
        SUM(Quantity) AS total_quantity
    FROM sales_data
    WHERE InvoiceNo NOT LIKE 'C%'
      AND Description <> ''
    GROUP BY Country, StockCode, Description
),

ranked_products AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Country
               ORDER BY total_quantity DESC
           ) AS rnk
    FROM product_sales
)

SELECT
    Country,
    StockCode,
    Description,
    total_quantity
FROM ranked_products
WHERE rnk = 1;



-- ============================================================
-- Challenge 10: Revenue by Day of Week
-- Identify which weekday generates the most revenue.
-- ============================================================

SELECT
    DAYNAME(InvoiceDate) AS weekday,
    SUM(UnitPrice * Quantity) AS revenue
FROM sales_data
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY weekday
ORDER BY revenue DESC;
