-- windows functions are really powerful and are somewhat like a group by - except they don't roll everything up into 1 row when grouping. 
-- windows functions allow us to look at a partition or a group, but they each keep their own unique rows in the output

-- showing use of group by and then windows function(how they are different)
SELECT gender, AVG(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;


SELECT gender, AVG(salary) OVER(partition by gender)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
-- but if we select the names as well the results will be different for group by and window function

SELECT dem.first_name,dem.last_name,gender, AVG(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name,dem.last_name, gender;

SELECT dem.first_name,dem.last_name,gender, AVG(salary) OVER(partition by gender) AS win_avg
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
-- rolling sum

SELECT dem.first_name,dem.last_name,gender,salary, SUM(salary) OVER(partition by gender order by dem.employee_id) AS win_avg
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
-- row number, rank, dense rank
SELECT dem.first_name,dem.last_name,gender,salary,
ROW_NUMBER() OVER(partition by gender order by salary desc) AS row_num ,  -- row number jut simply give new row number numerically 
RANK() OVER(partition by gender order by salary desc) AS rank_num, -- rank number positionally, if we have same value for column we ordered by then it assigns same rank to them but then next different row is numbered positionlly like here it skipped 6
DENSE_RANK() OVER(partition by gender order by salary desc) AS dense_rank_num -- dense rank assigns numerically same value same rank but next one is ranked numerically
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;


