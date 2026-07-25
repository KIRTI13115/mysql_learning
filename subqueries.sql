-- subqueries are basically queries within query
-- these are used when we want to perform operations on colums which are generated after applying operations on original col of given table
-- so we create temp table using subquery and then perform query on that

SELECT first_name, salary,
			(SELECT AVG(salary)
				FROM employee_salary)
FROM employee_salary;

-- now suppose we want to group by gender find aggregates of age and then average of those new aggregate columns

SELECT AVG(max_age)
FROM 
	(SELECT gender,  
    MAX(age) AS max_age,
    MIN(age) AS min_age,
    COUNT(age)
		FROM employee_demographics
        GROUP BY gender) AS temp_table;

 
