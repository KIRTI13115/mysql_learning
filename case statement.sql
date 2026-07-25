 -- case statements are used like if and else statement (different results or operations for different conditions)
 
 SELECT first_name, last_name,
 CASE
     WHEN age < 30 THEN 'Young'
     WHEN age BETWEEN 31 AND 50 THEN 'Old'
     WHEN age >= 50 THEN 'Retired'
 END
 FROM employee_demographics;
 
 -- use case : company decides to change the salary provide increment and bonuses based on different conditions find their new salary and bonuses
 -- conditions are : if salary < 50,000 -- 5%, >50,000 -- 7%, and if person is from finance department bonus = 10%
 
 SELECT first_name, last_name, salary,
 CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
 END AS new_salary,
 CASE 
	WHEN dept_id = 6 THEN salary * .10
E END AS bonus
F FROM employee_salary;