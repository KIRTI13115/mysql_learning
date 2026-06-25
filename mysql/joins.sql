 -- joins allow u to group two tables or more if they have common column (common column does not mean column name should be same it means data within it must be similar) 
 -- there are several types of joins 
 
 -- INNER JOINS
 -- returns the rows that have same value in both columns on which we are trying on from both tables
 
 SELECT *
 FROM employee_demographics AS dem
 JOIN employee_salary AS sal  -- by default join is inner join 
   ON dem.employee_id = sal.employee_id;
  
  
  SELECT *
  FROM employee_demographics AS dem
  INNER JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id;
     
  SELECT dem.employee_id, age, occupation
  FROM employee_demographics AS dem
  INNER JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id;
     
  -- OUTER JOINS 
  -- there are two types of outer joins - left join and right join
  -- left join matches the values from left table to right table and parametrize the row even if no match is found (as null) and vice versa for right join
  
  SELECT *
  FROM employee_demographics AS dem
  LEFT JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id;
     
  SELECT *
  FROM employee_demographics AS dem
  RIGHT JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id;  -- no match was found for employee_id =2 so it parametrized the row with null values in demographics table
  
  SELECT dem.employee_id, gender, occupation
  FROM employee_demographics AS dem
  RIGHT JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id;
     
  -- SELF JOINS
  -- it is used to join table to itself
  
  -- use case - suppose we have to pair the employees for an event and the condition is employee is paired with the employee with next employee id
  SELECT emp1.employee_id partner1,
  emp1.first_name parnter1_name,
  emp1.last_name partner1_last_name,
  emp2.employee_id partner2,
  emp2.first_name parnter2_name,
  emp2.last_name partner2_last_name
  FROM employee_salary  emp1
  INNER JOIN employee_salary emp2
     ON emp1.employee_id + 1  = emp2.employee_id; -- 1 is partnered with 2, 2 with 3 and so on
     
 -- joining multiple tables together
 SELECT dem.employee_id, dem.first_name, dem.last_name,
  sal.dept_id,
 parks.department_name
  FROM employee_demographics AS dem
  INNER JOIN employee_salary AS sal  
     ON dem.employee_id = sal.employee_id
  INNER JOIN parks_departments AS parks
	 ON sal.dept_id = parks.department_id;
     
 -- demographics table cannot directly be joined with parks table because there is no common column of same type like department's id or name
 -- but it can be joined with it through salary table because they can be joined using employee_id and further salary can be joined to parks using dept_id
 -- dept_id and department_id are different names but same type of info
 -- in self join aliasing is important to distinguish first and second table
