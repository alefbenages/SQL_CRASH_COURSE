-- PART 1 - TABLE ORDERS

-- ------------------------------------------------------------------------------------
-- Q5. How many orders were placed in total?

SELECT 
    COUNT(*) AS 'Number_of_placed_Orders'
FROM
    orders;

-- ------------------------------------------------------------------------------------
-- Q6. How many orders by state?

SELECT 
    state, COUNT(*) AS OrdersByState
FROM
    orders
GROUP BY state;

-- ------------------------------------------------------------------------------------
-- Q7. Select all the orders placed in January of 2017

SELECT 
    *
FROM
    orders
WHERE
    MONTH(created_date) = 1
        AND YEAR(created_date) = 2017;

-- ------------------------------------------------------------------------------------
-- Q8. How many orders were placed in January of 2017?

SELECT 
    COUNT(*) AS '# Orders of Jan-2017'
FROM
    orders
WHERE
    MONTH(created_date) = 1
        AND YEAR(created_date) = 2017;

-- ------------------------------------------------------------------------------------
-- Q9. How many orders were cancelled on January 4th 2017?

SELECT 
    COUNT(*) AS 'Cancelled Orders on Jan-4-2017'
FROM
    orders
WHERE
    DAY(created_date) = 4
        AND MONTH(created_date) = 1
        AND YEAR(created_date) = 2017
        AND state LIKE '%ancel%'; -- includes Cancel, cancel, Cancelled, cancell, etc...
        
-- ------------------------------------------------------------------------------------
-- Q10. How many orders have been placed each month of the year?

SELECT 
    YEAR(created_date) AS 'Year',
    MONTH(created_date) AS 'Month',
    COUNT(MONTH(created_date)) AS '#Orders'
FROM
    orders
GROUP BY YEAR(created_date) , MONTH(created_date)
ORDER BY YEAR(created_date) , MONTH(created_date);

-- ------------------------------------------------------------------------------------
-- Q11. What is the total amount paid in all the orders?

SELECT 
    SUM(total_paid) AS 'Total Paid'
FROM
    orders;

-- ------------------------------------------------------------------------------------
-- Q12. What is the average amount paid per order? Give a result to the previous question with only 2 decimals

SELECT 
    ROUND(AVG(total_paid), 2) AS 'Avg amount Paid'
FROM
    orders;

-- ------------------------------------------------------------------------------------
-- Q13 What is the date of the newest order?  # Expected output: 2017-01-01 00:07:19

SELECT 
    created_date AS 'Newest Order'
FROM
    orders
ORDER BY created_date ASC
LIMIT 1;

-- ------------------------------------------------------------------------------------
-- Q13.1 What about the oldest? # Expected output: 2018-03-14 13:58:36

SELECT 
    created_date AS 'Oldest Order'
FROM
    orders
ORDER BY created_date DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------
-- Q13.2 What is the day with the highest amount paid (and how much was paid that day)? 
-- # Expected output: 2017-11-24; 3,103,713
-- it ask for the highest amount paid in a day

SELECT 
    CONCAT(YEAR(created_date), '-', MONTH(created_date), '-',DAY(created_date)) AS 'Date',
    SUM(total_paid) AS total_paid
FROM
    orders
GROUP BY Date
ORDER BY total_paid DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------
-- Q13.3 What is the day with the highest amount of completed orders (and how many completed orders were placed that day)? # Expected output: 2017-11-24; 1,569

SELECT 
	CONCAT(YEAR(created_date), '-', MONTH(created_date), '-',DAY(created_date)) AS 'Date',
    state,
    COUNT(state) AS 'amount_of_orders'
FROM
    orders
WHERE
    state = 'Completed'
GROUP BY Date, state
ORDER BY amount_of_orders DESC
LIMIT 1;
