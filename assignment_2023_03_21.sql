-- PostgreSQL

-- 1. Write the query to get the department and department wise total(sum) salary,
-- display it in ascending order according to salary.
SELECT department_name, sum(emp.salary) AS salary
FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id
GROUP BY dept.department_id ORDER BY salary;
    
-- 2. Write the query to get the department, total no. employee of each department,
-- total(sum) salary with respect to department from "Employee" table.
SELECT dept.department_name, COUNT(emp.*), SUM(emp.salary)
FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id 
GROUP BY dept.department_id;

-- 3. Get department wise maximum salary from "Employee" table order by salary ascending
SELECT dept.department_name, max(salary) AS "max_salary"
FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id
GROUP BY dept.department_id ORDER BY max_salary;

-- 4. Write a query to get the departments where average salary is more than 60k
SELECT dept.department_name, AVG(emp.salary) FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id
GROUP by dept.department_id HAVING AVG(salary) > 60000;

-- 5. Write down the query to fetch department name assign to more than one Employee
SELECT dept.department_name
FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id
GROUP BY emp.department_id, dept.department_name
HAVING COUNT(*) > 1;

-- 6. Write a query to show department_name and assignedTo where assignedTo
-- will be "One candidate" if its assigned to only one employee otherwise
-- "Multiple candidates"
SELECT dept.department_name,
CASE
  WHEN count(*) = 1 THEN 'One Candidate'
  ELSE 'Multiple Candidates'
END AS assignedTO
FROM employees AS emp, departments AS dept
  WHERE emp.department_id = dept.department_id
GROUP BY emp.department_id, dept.department_name;
