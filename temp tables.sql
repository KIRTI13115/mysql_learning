-- temporary tables
-- temporary tables are used to store intermediate results or queries and manipulate data before moving it to more permanent table

-- temporary tables are just present as temporary memory and are valid for the particular session only, for next session it would vanish
-- creating temp table

CREATE TEMPORARY TABLE temp_table
(
first_name varchar(50),
last_name varchar(50),
favourite_book varchar(100) 
);

SELECT *
FROM temp_table;

-- inserting data into temp table
INSERT INTO temp_table
VALUES ('Kirti', 'Gupta', 'ANXIOUS PEOPLE');

-- other way of creating temp table - ysing already existing table

CREATE TEMPORARY TABLE salary_above_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_above_50k;

-- we can use these temp tables in new files also but within this session only
-- this is the primary way temp tables are used especially if we are just querying data and have some complex data we want to put into boxes or these temp tables to use later
-- it helps us to kind of categorize and separate it out

-- temp tables are generally used with stored procedures when we have complex manipulations and multiple temp tables 
-- ctes are used for much simpler calculations because they cannot store such complex calculations 

