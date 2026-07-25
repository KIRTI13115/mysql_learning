-- CTEs - common table expressions
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level
-- one CTE can be executed just below its definition only

WITH CTE_Example AS
(SELECT dem.first_name,dem.last_name,gender, AVG(salary) OVER(partition by gender) AS win_avg
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
)
-- directly after using it we can query the CTE
SELECT *
FROM CTE_Example;

-- using it here wont work
SELECT *
FROM CTE_Example;

WITH CTE_Example AS
(SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- we can perform operations on this as well
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender; 

-- we can also define multiple ctes and then perform joins on them

WITH CTE_Example1 AS
(SELECT employee_id, last_name , birth_date
FROM employee_demographics
WHERE birth_date > '1980-01-01'
),
CTE_Example2 AS
(SELECT employee_id, last_name,salary
FROM employee_salary 
WHERE salary>50000
)
SELECT *
FROM CTE_Example1 cte1
JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;
    
-- we can define the names of columns as parameters of cte

WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT gender, ROUND(AVG(sum_salary/count_salary),2) result
FROM CTE_Example
GROUP BY gender;
