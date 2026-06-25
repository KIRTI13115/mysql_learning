-- having clause is used to filter the rows using aggregate functions after group by
-- where clause cannot be used with aggregate functions before group by because aggregate functions occurs only after group by is implemented

-- SELECT gender, AVG(age)
-- FROM employee_demographics
-- WHERE AVG(age) > 40
-- GROUP BY gender;
-- this will not work

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- using both in single query

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 60000;