-- --------------------------------------------------------------------
-- SQL CRASH COURSE Part 3
-- --------------------------------------------------------------------


show tables;
show schemas;
use organisation;
-- ----------------------------------------------------------------------
-- Q0. explore a little bit by yourself with some "SELECT * FROM tables".

SELECT * FROM departments LIMIT 3;
SELECT * FROM dept_emp LIMIT 3;
SELECT * FROM dept_manager LIMIT 3;
SELECT * FROM employees LIMIT 3;
SELECT * FROM salaries LIMIT 3;

-- ----------------------------------------------------------------------
-- Q1. What is the employee id of the highest paid employee? 

SELECT 
    emp_id, MAX(salary) AS Higest_Payed
FROM
    salaries
GROUP BY emp_id
ORDER BY Higest_Payed DESC;

-- ----------------------------------------------------------------------
-- Q2. What is the name of the youngest employee ?

SELECT 
	concat(first_name, ' ', last_name) as full_name, hire_date AS Oldest_Employee
FROM 
	employees
Order by Oldest_Employee DESC;
-- there are a lot of employees hired in the same day. 


-- ----------------------------------------------------------------------
-- Q3. What is the name of the first hired employee ?

SELECT 
	concat(first_name, ' ', last_name) as full_name, hire_date AS Oldest_Employee
FROM 
	employees
Order by Oldest_Employee ASC;
-- there are a lot of employees hired in the same day. 


-- ----------------------------------------------------------------------
-- Q4. What percentage of employees are Female?

-- version with this facny tool over()
select gender, count(*) * 100.0 / sum(count(*)) over()  as 'Gender_in_%'
from employees
group by gender;

-- version calculed 'by hand'
SELECT 
	(ROUND(((SELECT COUNT(gender) FROM employees WHERE gender = 'F') * 100) / COUNT(gender),0)) as "%_Female",
    (ROUND(((SELECT COUNT(gender) FROM employees WHERE gender = 'M') * 100) / COUNT(gender),0)) as "%_Male"
FROM employees;


-- ----------------------------------------------------------------------
-- Q5 Show the employee count by department name wise, sorted alphabetically on department name.

-- number employees listed on 'dept_emp'  by dept
SELECT 
    inn.dept_name AS "Dept_Name" , COUNT(inn.dept_name) as "Number of employees by dept"
FROM
    (SELECT 
        dts.dept_no, dts.dept_name,
        dem.emp_id
    FROM
        departments AS dts
    INNER JOIN dept_emp AS dem 
    ON dts.dept_no = dem.dept_no
    ) AS inn
GROUP BY inn.dept_name
ORDER BY inn.dept_name;     


-- ----------------------------------------------------------------------
-- Q6. Count the number of new employees by each calendar year (take the value of year from from_date)

SELECT 
	YEAR(from_date) AS 'YEAR', COUNT(*) AS "number of new employees by year"
FROM 
	dept_emp
GROUP BY YEAR(from_date)
ORDER BY YEAR(from_date);

-- ---------------------------------------------------------------------
-- Q7. Count the number of employees by each calendar year (take the value of year from from_date)
/*
didn't know how to solve this... 
 
*/

-- ---------------------------------------------------------------------
-- Q8. What is the number of managers hired each calendar year.

SELECT YEAR(from_date) AS 'YEAR', COUNT(*) AS "number of new Managers by year"
FROM dept_manager
GROUP BY YEAR(from_date)
ORDER BY YEAR(from_date);

-- ---------------------------------------------------------------------
-- Q9 # What will be the department wise break up of managers ?

SELECT 
    inn.dept_name AS "Dept_Name" , COUNT(inn.dept_name) as "Managers by dept"
FROM
    (SELECT 
        dts.dept_no, dts.dept_name,
        dma.emp_id
    FROM
        departments AS dts
    INNER JOIN dept_manager AS dma 
    ON dts.dept_no = dma.dept_no
    ) AS inn
GROUP BY inn.dept_name
ORDER BY inn.dept_name;   


-- ---------------------------------------------------------------------
-- Q10. What is the number of male and female managers hired each calendar year from 1990 onwards?

SELECT 
	COUNT(inn.gender) as "Female Managers from 1990 onwards"
FROM(
	SELECT 
        emp.gender, dma.from_date,
        dma.emp_id
    FROM
        employees AS emp
    INNER JOIN dept_manager AS dma 
    ON emp.emp_id = dma.emp_id
    ) AS inn
WHERE inn.gender = 'F' AND YEAR(inn.from_date) > 1990;

SELECT 
	COUNT(inn.gender) as "Male Managers from 1990 onwards"
FROM(
	SELECT 
        emp.gender, dma.from_date,
        dma.emp_id
    FROM
        employees AS emp
    INNER JOIN dept_manager AS dma 
    ON emp.emp_id = dma.emp_id
    ) AS inn
WHERE inn.gender = 'M' AND YEAR(inn.from_date) > 1990;

 /* Tried this, but didn't work.  The idea was to get both numbers in the same table, as in the Q4. 
 The problem is in the "FROM inn" from the sbquery. says that the table "inn" doesn't exist.  
 Didn't know how to solve this. 
 
SELECT 
	(SELECT COUNT(inn.gender) FROM inn WHERE (gender = 'F' AND YEAR(inn.from_date) >= 1990)) as "Female Managers",
	(SELECT COUNT(inn.gender) FROM inn WHERE (gender = 'F' AND YEAR(inn.from_date) >= 1990)) as "Female Managers"
FROM(
	SELECT 
        emp.gender, dma.from_date,
        dma.emp_id
    FROM
        employees AS emp
    INNER JOIN dept_manager AS dma 
    ON emp.emp_id = dma.emp_id
    ) inn;

*/



-- -------------------------------        