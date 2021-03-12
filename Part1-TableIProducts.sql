-- Table Products

-- ------------------------------------------------------------------------------------
-- Q14 -- How many products are there?

SELECT 
    COUNT(*) AS 'Amount_of_products'
FROM
    products;

-- ------------------------------------------------------------------------------------   
-- Q15 -- How many brands?

SELECT 
    COUNT(DISTINCT brand) as UniqueBrands
FROM
    products;
 
-- ------------------------------------------------------------------------------------  
-- Q16.1 -- How many products per brand ?

SELECT 
    brand, COUNT(brand) AS items
FROM
    products
GROUP BY brand
ORDER BY items DESC;

-- ------------------------------------------------------------------------------------
-- Q16.2 -- How many products per category?

SELECT 
    manual_categories AS 'Categories',
    COUNT(manual_categories) AS ProductsPerCategory
FROM
    products
GROUP BY manual_categories
ORDER BY ProductsPerCategory DESC;

-- ------------------------------------------------------------------------------------
-- Q17.1 -- What is the average price per brand?

SELECT 
    brand, ROUND((SUM(price) / COUNT(price)), 2) AS AvgPrice
FROM
    products
GROUP BY brand
ORDER BY AvgPrice DESC;

-- ------------------------------------------------------------------------------------
-- Q17.2 -- What is the average price per category?

SELECT 
    manual_categories,
    ROUND((SUM(price) / COUNT(price)), 2) AS AvgPrice
FROM
    products
GROUP BY manual_categories
ORDER BY AvgPrice DESC;

-- ------------------------------------------------------------------------------------
-- Q18.1 -- What is the name and description of the most expensive product per brand ?

SELECT 
   inn.name_en, inn.short_desc_en
FROM
    (SELECT 
        p.name_en, p.short_desc_en, p.brand, MAX(CAST(p.price as FLOAT)) as MxP
    FROM
        products p
    GROUP BY p.name_en, p.short_desc_en, p.brand
    ORDER BY MxP DESC
        ) AS inn;

/* This version shows the brand and price
SELECT 
	name_en, short_desc_en, brand, MAX(CAST(price as FLOAT)) as price
FROM 
	products
GROUP BY brand, name_en, short_desc_en
ORDER BY price DESC;
*/

-- ------------------------------------------------------------------------------------
-- Q18.2 -- What is the name and description of the most expensive product per category?

SELECT 
   inn.name_en, inn.short_desc_en
FROM
    (SELECT 
        p.name_en, p.short_desc_en, p.manual_categories, MAX(CAST(p.price as FLOAT)) as MxP
    FROM
        products p
    GROUP BY p.name_en, p.short_desc_en, p.manual_categories
    ORDER BY MxP DESC
        ) AS inn;
