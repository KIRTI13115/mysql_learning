-- stored procedures
-- these are the way to store sql queries. when these are stored they can be used over and over again
-- its used to simplify repetitive code and iprove efficiency overall

-- to define in which table to create stored procedure we can define like this
USE parks_and_recreation;

CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

-- we can call stored procdures using CALL keyword 
CALL large_salaries();

--  here we have defined really simple stored procedure but in real cases we have really complex queries in stored procedures
-- to define multiple queries within single stored procedure we need to use delimiter

CREATE PROCEDURE large_salaries2()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

-- in the above query what happens is procedure doesnt have two queries rather it has one query under it and the other one executes as independent query

DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT * 
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT * 
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

-- now this query uses two queries under one stored procedure
-- when we call this stored procedure we will get two tables a ouput 

CALL large_salaries3();

-- we can also create stored procedure directly- by right clicking on Stored Procedures and creating one:
-- new_procedure was created using direct method
-- it's going to drop the procedure if it already exists.
USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`;
-- it automatically adds the dilimiter for us
DELIMITER $$
CREATE PROCEDURE new_procedure()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

DELIMITER ;

-- and changes it back at the end

-- this can be a genuinely good option to help you write your Stored Procedures faster, although either way
-- works

-- if we click finish you can see it is created the same 


-- we can also add parameters by defining the name of parameter and its datatype

CREATE PROCEDURE large_salaries4(p_employee_id INT)
SELECT salary 
FROM employee_salary
WHERE employee_id = p_employee_id;

CALL large_salaries4(1);

-- we defined that integer parameter can be passed and when the employee_id is same as passed integer it returns the salary of that employee


 



