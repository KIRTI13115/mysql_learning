-- Union 
-- Used to combine rows from two different tables using different columns 

-- there is UNION DISTINCT which shows only distinct combinations and then there is DISTINCT ALL which shows all combinations
-- by default union is distinct

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

-- UNIONS are used on similar columns from tables

-- practical usecase :
-- Suppose parks is running low on budget so it decides to choose the employees who are old and are getting paid more than 70000 so further changes can be made on them in order to
-- manage budgets. since salary can be taken care from salary table and age from demographics table we cannot use AND statement, also there is no relation between age and salary so joins cannot be used. 

SELECT first_name, last_name, 'Old Male' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old Female' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'High Earning' AS Label
FROM employee_salary
WHERE salary>70000
ORDER BY first_name;