-----------------------------------------------------------------------------------------
-- PROJECT: E-Commerce Sales - Exploratory Data Analysis (EDA)
-- TOOL: MySQL
-- OBJECTIVE: Extracting actionable growth and marketing insights from transactional data.
-----------------------------------------------------------------------------------------

-- ==========================================
-- STEP 1: INITIAL DATA AUDIT & CORRECTIONS
-- ==========================================

-- Preview the clean database schema
SELECT * FROM messy.ecommerce;

-- Check total record count (Result: 96 rows)
SELECT COUNT(*) FROM messy.ecommerce;

-- Uncovering hidden nulls/blank categories and mapping them to their correct product type
UPDATE messy.ecommerce SET category = 'Clothing' WHERE product = 'jeans';
UPDATE messy.ecommerce SET category = 'electronics' WHERE product = 'vacuum';
UPDATE messy.ecommerce SET category = 'electronics' WHERE product = 'laptop';
UPDATE messy.ecommerce SET category = 'electronics' WHERE product = 'Headphones';
UPDATE messy.ecommerce SET category = 'Clothing' WHERE product = 'shoes';
UPDATE messy.ecommerce SET category = 'Sports' WHERE product = 'Yoga Mat';
UPDATE messy.ecommerce SET category = 'Books' WHERE product = 'Biography';
UPDATE messy.ecommerce SET category = 'electronics' WHERE product = 'Smartphone';
UPDATE messy.ecommerce SET category = 'Home' WHERE product = 'Microwave';
UPDATE messy.ecommerce SET category = 'Home' WHERE product = 'Lamp';

-- ==========================================
-- STEP 2: PRODUCT PERFORMANCE ANALYTICS
-- ==========================================

-- Finding the most frequently purchased products (Volume Analysis)
-- Insight: 'shoes' led the volume with 9 orders.
SELECT product, COUNT(product) 
FROM messy.ecommerce 
GROUP BY product 
ORDER BY COUNT(product) DESC;

-- Total Revenue and Quantity Sold per Product (Value Analysis)
-- Insight: 'Blender' generated the highest revenue (~28,000) with just 7 orders.
SELECT product, COUNT(quantity) AS total_orders, SUM(total) AS total_revenue
FROM messy.ecommerce 
GROUP BY product 
ORDER BY total_revenue DESC;

-- Checking high and low price extremities per product
SELECT * FROM messy.ecommerce ORDER BY price DESC;

-- ==========================================
-- STEP 3: MARKETING & PAYMENT CHANNEL OPTIMIZATION
-- ==========================================

-- Analyzing customer behavior based on transactional payment methods
-- Insight: Cash is king with 68k revenue (32 orders), Credit is lowest with 24k revenue (21 orders).
SELECT payment_method, 
       COUNT(*) AS total_orders,
       SUM(total) AS total_revenue
FROM messy.ecommerce
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Investigating the Product Returns (Churn/Friction metrics)
SELECT product, status, COUNT(*) AS total_orders
FROM messy.ecommerce 
WHERE status = 'Returned' 
GROUP BY product, status;

-- ==========================================
-- STEP 4: ADVANCED BUSINESS INTELLIGENCE (CTEs & Windows)
-- ==========================================

-- Query 1: Top 3 Highest Revenue-Generating Products Per Year
WITH sales_Year AS 
(
  SELECT product, YEAR(order_date) AS years, quantity, price, SUM(total) AS total
  FROM messy.ecommerce
  GROUP BY product, YEAR(order_date), price, quantity
),
product_Year_Rank AS (
  SELECT product, years, price, total, quantity, 
         DENSE_RANK() OVER (PARTITION BY years ORDER BY total DESC) AS ranking
  FROM sales_Year
)
SELECT product, years, price, total, ranking, quantity
FROM product_Year_Rank
WHERE ranking <= 3
  AND years IS NOT NULL
ORDER BY years AMOMENT, total DESC;


-- Query 2: Monthly Rolling Total of Revenue (Velocity tracking over time)
WITH date_cte AS (
    SELECT SUBSTRING(order_date, 1, 7) AS `date`, 
           SUM(total) AS total, 
           product, 
           quantity
    FROM messy.ecommerce
    GROUP BY `date`, product, quantity
)
SELECT `date`, product, quantity, total,
       SUM(total) OVER (ORDER BY `date` ASC) AS rolling_total
FROM date_cte
ORDER BY `date` ASC;
