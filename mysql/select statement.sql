-- select statement is used to filter or select columns of data

SELECT * FROM parks_and_recreation.employee_demographics;
SELECT first_name,
birth_date,
age,
age+10
FROM parks_and_recreation.employee_demographics;
#PEMDAS

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;