-----------------------------------------------------------------------------------------
-- PROJECT: E-Commerce Sales Data Cleaning
-- TOOL: MySQL
-- OBJECTIVE: Transform raw, inconsistent, and dirty e-commerce sales data into a 
--            structured, reliable dataset ready for production and analysis.
-----------------------------------------------------------------------------------------

-- ==========================================
-- STEP 1: ENVIRONMENT SETUP & DATA STAGING
-- ==========================================

-- Create a working copy table with the exact same schema as the raw data source
CREATE TABLE messy.Ecommerce LIKE messy.messy_ecommerce_sales_data;
 
-- Populate the working table with all records from the raw data source
INSERT INTO messy.Ecommerce 
SELECT * FROM messy.messy_ecommerce_sales_data;

-- ==========================================
-- STEP 2: IDENTIFYING & REMOVING DUPLICATES
-- ==========================================

-- Check for duplicate records using ROW_NUMBER() across all key columns
SELECT id, Customer_Name, order_id, `order_date`, product, category, quantity, price, Payment_Method, Status, Total,
       ROW_NUMBER() OVER(
           PARTITION BY id, Customer_Name, order_id, `order_date`, product, category, quantity, price, Payment_Method, Status, Total
       ) AS row_num 	
FROM messy.Ecommerce;
 
-- Isolate and view duplicate records (where row_num > 1)
SELECT *
FROM (
    SELECT id, Customer_Name, order_id, `order_date`, product, category, quantity, price, Payment_Method, Status, Total,
           ROW_NUMBER() OVER(
               PARTITION BY id, Customer_Name, order_id, `order_date`, product, category, quantity, price, Payment_Method, Status, Total
           ) AS row_num 	
    FROM messy.Ecommerce
) dub   
WHERE row_num > 1;
 
-- Create a temporary staging table to safely filter out duplicates
CREATE TABLE messy.Ecommerce2 (
    `ID` INT,
    `Customer_Name` TEXT,
    `Order_ID` TEXT,
    `Order_Date` TEXT,
    `Product` TEXT,
    `Category` TEXT,
    `Quantity` INT,
    `Price` TEXT,
    `Payment_Method` TEXT,
    `Status` TEXT,
    `Total` TEXT
);

-- Insert only the unique records (row_num = 1) into the staging table
INSERT INTO messy.Ecommerce2 (ID, Customer_Name, Order_ID, Order_Date, Product, Category, Quantity, Price, Payment_Method, Status, Total)
SELECT ID, Customer_Name, Order_ID, Order_Date, Product, Category, Quantity, Price, Payment_Method, Status, Total
FROM (
    SELECT *, 
           ROW_NUMBER() OVER(
               PARTITION BY ID, Customer_Name, Order_ID, Order_Date, Product, Category, Quantity, Price, Payment_Method, Status, Total
           ) AS row_num
    FROM messy.ecommerce
) AS temp
WHERE row_num = 1;

-- Clear all records from the primary working table
TRUNCATE TABLE messy.ecommerce;

-- Reload the unique, deduplicated records back into the primary working table
INSERT INTO messy.ecommerce
SELECT * FROM messy.Ecommerce2;

-- Drop the temporary staging table
DROP TABLE messy.Ecommerce2;
 
-- ==========================================
-- STEP 3: STANDARDIZING DATE FORMATS
-- ==========================================

-- Verify the string-to-date conversion pattern
SELECT STR_TO_DATE(`order_date`, '%m/%d/%Y'), `order_date`
FROM messy.Ecommerce;
 
-- Hardfix known date anomaly for a specific corrupted ID string
UPDATE messy.Ecommerce 
SET `order_date` = '01/05/2023' 
WHERE ID = 114;

-- Convert text date strings into standard SQL DATE format (YYYY-MM-DD)
UPDATE messy.Ecommerce
SET `order_date` = STR_TO_DATE(`order_date`, '%m/%d/%Y');
 
-- Alter the column data type from TEXT to DATE permanently
ALTER TABLE messy.Ecommerce
MODIFY COLUMN `order_date` DATE;
 
-- Audit query to check for any unmapped or corrupted dates remaining
SELECT * 
FROM messy.Ecommerce 
WHERE STR_TO_DATE(`order_date`, '%m/%d/%Y') IS NULL 
  AND `order_date` IS NOT NULL 
  AND `order_date` != '';

-- ==========================================
-- STEP 4: STANDARDIZING TEXT CATEGORIES
-- ==========================================

-- Inspect distinct categories for variations or structural typos
SELECT DISTINCT category FROM messy.Ecommerce ORDER BY 1;

-- Standardize variations of 'electronic' into a singular 'electronics' tag
UPDATE messy.Ecommerce 
SET category = 'electronics' 
WHERE category LIKE 'electronic%';

-- ==========================================
-- STEP 5: CLEANING QUANTITY VALUES
-- ==========================================

-- Check for anomalies in the quantity column (e.g., negative entries)
SELECT DISTINCT quantity FROM messy.Ecommerce ORDER BY 1;

-- Remove accidental negative signs from structural inputs
UPDATE messy.Ecommerce 
SET quantity = TRIM(LEADING '-' FROM quantity) 
WHERE quantity LIKE '-%';

-- ==========================================
-- STEP 6: CLEANING PRICE VALUES
-- ==========================================

-- Inspect the price column for non-numeric corruptions, symbols, or negative values
SELECT DISTINCT price FROM messy.Ecommerce ORDER BY 1;
SELECT * FROM messy.Ecommerce WHERE price LIKE '-%' OR price LIKE 'abd' OR price LIKE 'four%' OR price LIKE '%$' ORDER BY 1;

-- Handle explicit data corruption anomalies on specific row IDs
UPDATE messy.Ecommerce SET price = NULL WHERE id = 101;
UPDATE messy.Ecommerce SET price = 400 WHERE id = 110;
UPDATE messy.Ecommerce SET price = 300 WHERE id = 120;
 
-- Strip trailing/leading negative signs and empty spaces from numeric fields
UPDATE messy.Ecommerce SET price = TRIM(LEADING '-' FROM price) WHERE price LIKE '-%';
UPDATE messy.Ecommerce SET price = REPLACE(price, ' ', '');

-- Use Regular Expressions to identify and nullify remaining non-numeric corrupt values
UPDATE messy.Ecommerce 
SET price = NULL
WHERE price NOT REGEXP '^[0-9]+(\\.[0-9]+)?$' 
  AND price IS NOT NULL;

-- Permanently convert the price column from TEXT to DECIMAL for accurate math modeling
ALTER TABLE messy.Ecommerce 
MODIFY COLUMN price DECIMAL(10,2);

-- ==========================================
-- STEP 7: CLEANING TOTAL VALUES
-- ==========================================

-- Inspect total sales field for signs of formatting corruptions
SELECT DISTINCT total FROM messy.Ecommerce ORDER BY 1;

-- Strip negative prefixes from total calculation entries
UPDATE messy.Ecommerce 
SET total = TRIM(LEADING '-' FROM total) 
WHERE total LIKE '-%';
 
-- Use Regular Expressions to clean up remaining text corruptions inside the total column
UPDATE messy.Ecommerce 
SET total = NULL
WHERE total NOT REGEXP '^[0-9]+(\\.[0-9]+)?$' 
  AND total IS NOT NULL;

-- Final data state check before migration
SELECT * FROM messy.Ecommerce ORDER BY 1;

-- ==========================================
-- STEP 8: PRODUCTION DEPLOYMENT
-- ==========================================

-- Empty the original production data table completely
TRUNCATE TABLE messy.messy_ecommerce_sales_data;

-- Overwrite the original table with the pristine, cleaned dataset
INSERT INTO messy.messy_ecommerce_sales_data
SELECT * FROM messy.Ecommerce;

-- Clean up workspace environment by removing the primary working table
DROP TABLE messy.Ecommerce;
