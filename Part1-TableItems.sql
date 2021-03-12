-- PART 1 - TABLE ITEMS

-- ----------------------------------------------------------------------
-- Q1. Select the entire line_item table.

SELECT 
    *
FROM
    line_item;
    
-- ----------------------------------------------------------------------
-- Q1.1 Select only the first 10 rows from the line_item table

SELECT 
    *
FROM
    line_item
LIMIT 10;

-- ----------------------------------------------------------------------
-- Q1.2. Select only the columns “stock keeping unit” (sku), unit_price and date from the line_item table (only the first 10 rows)

SELECT 
    sku AS "stock keeping unit" , unit_price, date
FROM
    line_item
LIMIT 10;

-- ----------------------------------------------------------------------
-- Q2. Count the total number of rows of the line_item table 
-- # Expected output: 293983

SELECT 
    COUNT(*) AS "Total number of Rows"
FROM
    line_item;

-- ----------------------------------------------------------------------
-- Q2.1. Count the total number of unique "sku" from the line_item table.
-- #Expected output: 7951

SELECT 
    COUNT(DISTINCT sku) AS "Total number of Unique SKU"
FROM
    line_item;

-- ----------------------------------------------------------------------
-- Q3. Generate a table with the average price of each sku.

SELECT 
    sku, ROUND(AVG(unit_price),2) AS avg_price
FROM
    line_item
GROUP BY sku;

-- ----------------------------------------------------------------------
-- Q3.1. Now name the column of the previous query with the average price "avg_price" through and alias, and sort the list by that column (bigger to smaller price)

SELECT 
    line_item.sku, ROUND(AVG(unit_price),2) AS avg_price
FROM
    line_item
GROUP BY sku
ORDER BY avg_price DESC;

-- ----------------------------------------------------------------------
-- Q4. Which products were bought in the largest quantities? Select the “stock keeping unit” (sku) and product_quantity of the 100 products with the biggest "product quantity"

SELECT 
    sku, product_quantity
FROM
    line_item
ORDER BY product_quantity DESC
LIMIT 100;

