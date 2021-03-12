-- ----------------------------------------------------
-- SQL CRASH COURSE PART 2
-- Query the database joining tables
-- ----------------------------------------------------

-- ----------------------------------------------------
-- Query 1 ​ Our first query should return the "sku", "product_quantity", "date" and "unit_price" from the line_item table together with the "name" and the "price" of each product from the "products" table. We want only products present in both tables.

SELECT 
    itm.sku,
    itm.product_quantity,
    itm.date,
    itm.unit_price AS IPrice,
    prd.name_en,
    prd.price AS PPrice
FROM
    line_item itm
       INNER JOIN
    products prd ON itm.sku = prd.sku;

-- ----------------------------------------------------
-- Query 2 You might notice that the ​ unit_price ​ from the ​ line_item ​ table and the price from the ​ product ​ table is not the same. Let's investigate that! Extend your previous query by adding a column with the difference in price. Name that column ​ price_difference ​ .

SELECT 
    itm.sku,
    itm.product_quantity,
    itm.date,
    itm.unit_price AS IPrice,
    prd.name_en,
    prd.price AS PPrice,
    ROUND(prd.price - itm.unit_price, 1) AS price_diff
FROM
    line_item itm
        INNER JOIN
    products prd ON itm.sku = prd.sku;

-- ----------------------------------------------------
-- Query 3 Build a query that outputs the price difference that you just calculated, grouping products by category. Round the result.

SELECT  
	inn.manual_categories,
    ROUND(AVG(inn.price_dif),2) as AVG_Price_diff   
FROM
	(SELECT 
		line_item.sku, 
		line_item.product_quantity, 
		line_item.date, 
		line_item.unit_price, 
		products.name_en,	 
        products.price,              
		ROUND(ABS(line_item.unit_price - products.price), 1) AS price_dif,
		products.manual_categories         
	FROM line_item 
		INNER JOIN products             
		ON line_item.sku = products.sku)  as inn  
GROUP BY inn.manual_categories;

-- ----------------------------------------------------
-- Query 4. ​ Create the same query as before (calculating the price difference between the ​line_item and the ​products tables, but now grouping by brands instead of categories.
 
SELECT 
	inn.brand,
    ROUND(AVG(inn.price_dif),1) as AVG_price_dif
FROM
	(SELECT 
		itm.sku,
		itm.product_quantity,
		itm.date,
		prd.name_en,
		itm.unit_price AS IPrice,
		prd.brand,
		prd.price AS PPrice,
		ROUND(prd.price - itm.unit_price, 1) AS price_dif
	FROM
		line_item itm
			INNER JOIN
		products prd ON itm.sku = prd.sku ) AS inn
GROUP BY inn.brand
ORDER BY AVG_price_dif DESC;

-- ----------------------------------------------------
-- Query 5. ​ Let's focus on the brands with a big price difference: run the same query as before, but now limiting the results to only brands with an avg_price_dif of more than 50000. Order the results by ​ avg_price_dif ​ (bigger to smaller). 
 
SELECT 
	inn.brand,
    ROUND(AVG(inn.price_dif),1) as AVG_price_dif
FROM
	(SELECT 
		itm.sku,
		itm.product_quantity,
		itm.date,
		prd.name_en,
		itm.unit_price AS IPrice,
		prd.brand,
		prd.price AS PPrice,
		ROUND(prd.price - itm.unit_price, 1) AS price_dif
	FROM
		line_item itm
			INNER JOIN
		products prd ON itm.sku = prd.sku ) AS inn
WHERE
    inn.price_dif > 50000
GROUP BY inn.brand
ORDER BY AVG_price_dif DESC;


-- ----------------------------------------------------
-- Query 6. ​ Query 6. We want to know the sku, product_quantity and date of all the orders, ordered by SKU. If it takes too long and/or the connection gets lost try first selecting only the first 50 results and then ordering by sku.

SELECT
		ord.created_date,
        ord.state,
        itm.sku,
        itm.product_quantity
FROM line_item AS itm
INNER JOIN orders AS ord ON itm.id_order = ord.id_order
ORDER BY itm.sku;

-- ----------------------------------------------------
-- Query 7. ​ Add to the previous information about "​brand" ​and "​manual_categories" fields from the products table.

SELECT 
    ord.created_date, ord.state, 
    itm.sku, itm.product_quantity,
    prd.brand, prd.manual_categories
FROM
    line_item AS itm
        INNER JOIN
    orders AS ord ON itm.id_order = ord.id_order
        INNER JOIN
    products AS prd ON itm.sku = prd.sku;

-- -----------------------------------------------------------------------------
-- Query 8.​ We want to know which brand and which categories are most frequent in Cancelled orders. 
-- Let's keep working on the same query: now we want to keep only Cancelled orders. Modify this query to group the results from the previous query, first by category and then by brand, adding in both cases a count and ordering by descending count. If it takes too long and/or the connection gets lost try putting a LIMIT command.

SELECT
	inn.brand, COUNT(*) AS 'Cancelled Orders by Brand'
FROM (
	SELECT 
		-- ord.created_date, 
        ord.state, 
		-- itm.sku, 
        -- itm.product_quantity,
		prd.brand -- , prd.manual_categories
	FROM
		line_item AS itm
			INNER JOIN
		orders AS ord ON itm.id_order = ord.id_order
			INNER JOIN
		products AS prd ON itm.sku = prd.sku
       LIMIT 1000
        ) as inn     
WHERE inn.state = 'Cancelled' 
GROUP BY inn.brand ;
			 


SELECT * FROM line_item limit 1;
SELECT * FROM products limit 1;
SELECT * FROM orders limit 1;





