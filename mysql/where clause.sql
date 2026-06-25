-- where clause is used to filter or select rows of data based on condition 

SELECT * 
FROM employee_demographics
WHERE first_name='Leslie';

SELECT * 
FROM employee_salary
WHERE salary > 50000;

SELECT * 
FROM employee_demographics
WHERE gender != 'male' ; -- use of !=(not equal to)

-- AND NOT OR OPERATORS

SELECT * 
FROM employee_demographics
WHERE gender != 'male' 
AND birth_date > 1980-01-01;

SELECT * 
FROM employee_demographics
WHERE gender != 'male' 
OR birth_date > 1980-01-01;

SELECT * 
FROM employee_demographics
WHERE NOT gender != 'male' 
AND birth_date > 1980-01-01;

-- where clause also follows PEMDAS rule

SELECT * 
FROM employee_demographics
WHERE NOT (gender = 'male' AND age > 30 ) OR employee_id > 5 ;

-- LIKE statement (used to filter rows with conditions similar to defined by like statement
-- special characters % and _
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'Do%' ;

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'A__' ;





