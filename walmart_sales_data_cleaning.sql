-- created a duplicate of the raw table "walmart_sales"
CREATE TABLE walmart_sales_staging
LIKE walmart_sales
;

SELECT *
FROM walmart_sales_staging
;

-- Inserted the same values on the raw table
INSERT INTO walmart_sales_staging
SELECT *
FROM walmart_sales
;

-- Inspected the columns and their types
DESCRIBE walmart_sales_staging;

-- Check for duplicates
-- Created a CTE 
WITH walmart_duplicate AS
( 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY Store, `Date`, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment) AS row_num
FROM walmart_sales_staging
)
SELECT *
FROM walmart_duplicate
WHERE row_num > 1
;

-- Check every column with Nulls & blanks
SELECT Unemployment
FROM walmart_sales_staging
WHERE Unemployment IS NULL OR Unemployment = ''
;

-- Convert Date column to Date type
ALTER TABLE walmart_sales_staging
MODIFY COLUMN `Date` DATE;

SELECT `Date`
FROM walmart_sales_staging
WHERE STR_TO_DATE(`Date`, '%d-%m-%Y') IS NULL;

UPDATE walmart_sales_staging
SET `Date` = str_to_date(`Date`, '%d-%m-%Y')
;

ALTER TABLE walmart_sales_staging
MODIFY COLUMN `Date` DATE;

-- Convert weekly_sales & Fuel_Price to decimal(10,2) type of column
SELECT *
FROM walmart_sales_staging
;

ALTER TABLE walmart_sales_staging
MODIFY COLUMN `Weekly_sales` DECIMAL(10,2)
;

ALTER TABLE walmart_sales_staging
MODIFY COLUMN `Fuel_Price` DECIMAL(10,2)
;

-- Create new columns
SELECT *
FROM walmart_sales_staging
;

ALTER TABLE walmart_sales_staging
ADD COLUMN yearly varchar(20)
;

UPDATE walmart_sales_staging
SET yearly= LEFT(`Date`, 4)
;

ALTER TABLE walmart_sales_staging
ADD COLUMN monthly varchar(20)
;

UPDATE walmart_sales_staging
SET monthly= substring(`Date`, 1, 7)
;

-- Trimming whitespace & checking if holiday_flag is only 0 and 1
UPDATE walmart_sales_staging
SET Store = TRIM(Store)
;

UPDATE walmart_sales_staging
SET `Date` = TRIM(`Date`)
;

UPDATE walmart_sales_staging
SET Weekly_Sales = TRIM(Weekly_Sales)
;

UPDATE walmart_sales_staging
SET Holiday_Flag = TRIM(Holiday_Flag)
;

UPDATE walmart_sales_staging
SET Temperature = TRIM(Temperature)
;

UPDATE walmart_sales_staging
SET Fuel_Price = TRIM(Fuel_Price)
;

UPDATE walmart_sales_staging
SET CPI = TRIM(CPI)
;

UPDATE walmart_sales_staging
SET Unemployment = TRIM(Unemployment)
;

SELECT Holiday_Flag
FROM walmart_sales_staging
WHERE Holiday_Flag NOT IN (0,1) OR holiday_flag IS NULL
;

-- GROUP by store and date
SELECT *
FROM walmart_sales_staging
;

SELECT Store, yearly, SUM(Weekly_sales), AVG(Weekly_sales), COUNT(Weekly_sales)
FROM walmart_sales_staging
GROUP by Store, yearly
;


