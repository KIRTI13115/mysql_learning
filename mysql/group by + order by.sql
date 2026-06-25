-- Group by statement is used to group the rows that have same values unde3r the specified columns

SELECT gender
FROM employee_demographics
GROUP BY gender;

-- difference between group by and distinct is that group by rolls up all the values into rows and when we run aggregate functions it will be based on these rows
-- if we are not using aggregate functions with select statement then we need to use same tilte with group by statement

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary; 

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)  
FROM employee_demographics
GROUP BY gender;

-- ORDER BY 
-- order by sorts the column in ascending or descending order ASC for ascending ans DESC for descending, ascending is default
-- order of order by is quite important
SELECT *
FROM employee_demographics 
ORDER BY first_name;

SELECT *
FROM employee_demographics 
ORDER BY first_name DESC ;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC; -- if we first order by age and then by gender it makes no sense for ordering by gender

-- we can also order by column number instead of name but it is not preferred
SELECT *
FROM employee_demographics
ORDER BY 5,4;
