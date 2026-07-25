-- limit is used to extract specific number of rows

SELECT *
FROM employee_demographics
ORDER BY age
LIMIT 3; -- when only single integer is specified then it extracts that number of rows from top

SELECT *
FROM employee_demographics
ORDER BY age
LIMIT 2, 1; -- when specified as x,y then it extracts y number of rows after x

-- Aliasing is method of renaming the column

SELECT gender, AVG(age) AS avg_age 
FROM employee_demographics
GROUP BY gender;