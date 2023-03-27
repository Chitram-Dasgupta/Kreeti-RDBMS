-- PostgreSQL

-- 1. From the following tables write a SQL query to find the details of an employee.
-- Return full name, email, salary, Department Name, postal code, and City.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
e.email, e.salary, d.department_name, l.pincode AS "postal code", l.city
FROM employees AS e 
  INNER JOIN departments AS d ON e.department_id = d.department_id
  INNER JOIN locations AS l ON d.location_id = l.location_id;
  
-- 2. From the following tables write a SQL query to find the departments whose location is
-- in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province,
-- street_address.
SELECT d.department_name, l.city
FROM departments AS d INNER JOIN locations AS l
ON d.location_id = l.location_id 
WHERE l.city IN ('Jammu Kashmir', 'Jharkhand');

-- 3. From the following tables write a SQL query to find the count of employees present in
-- different jobs whose average salary is greater than 10,000. Return all the jobs with
-- employee count, Job Name, and average salary.
SELECT COUNT(emp.first_name), j.job_title, AVG(emp.salary)
FROM 
  employees emp INNER JOIN jobs AS j 
    ON emp.job_id = j.job_id
  INNER JOIN departments AS dept 
    ON emp.department_id = dept.department_id
WHERE emp.department_id IN ( SELECT d.department_id 
  FROM employees AS e INNER JOIN departments AS d 
    ON e.department_id = d.department_id
  GROUP BY d.department_id
  HAVING AVG(e.salary) > 10000)
GROUP BY dept.department_id, j.job_title;

-- 4. From the following table write a SQL query to find all the first_names and
-- last_names in both dependents and employees tables. Return the duplicate records as
-- well and order the records in descending order of the last_name column.
SELECT first_name, last_name
FROM employees UNION ALL
SELECT first_name, last_name
FROM dependents
ORDER BY last_name DESC;

-- 5. From the following table write a SQL query to list every employee that has a manager
-- with the name of his or her manager.
SELECT CONCAT(e1.first_name, ' ', e1.last_name) AS employee_name, 
  CONCAT(e2.first_name, ' ', e2.last_name)AS manager_name
FROM employees AS e1
  INNER JOIN employees AS e2
    ON e1.manager_id = e2.employee_id;
  
-- 6. Find the departments that have more than 5 employees earning a salary greater than
-- 50,000 and are located in either New York or California. Include the department name,
-- location, and the number of employees meeting the criteria
  
SELECT department_name, 
  loc.state_province AS "location", COUNT(*) AS num_employees
FROM employees AS emp 
  INNER JOIN departments AS dept
    ON emp.department_id = dept.department_id
  INNER JOIN locations AS loc
    ON dept.location_id = loc.location_id
WHERE emp.salary > 50000
AND (loc.city = 'New York' OR loc.state_province = 'California')
GROUP BY dept.department_name, loc.state_province
HAVING COUNT(*) > 5;
  
-- 7. List any employees who have dependents and have a job title that includes the word
-- 'manager', and sort the results by department name in ascending order.
SELECT emp.employee_id, CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
FROM employees AS emp 
  INNER JOIN dependents AS deps
    ON emp.employee_id = deps.employee_id
  INNER JOIN jobs AS j 
    ON j.job_id = emp.job_id
  INNER JOIN departments AS dept
    ON dept.department_id = emp.department_id
WHERE j.job_title LIKE '%manager%'
ORDER By dept.department_name;

-- 8. Add a column in the dependent table called “city” depicting their current location of
--stay. Find all employees who have been hired in the past 3 years and have dependents
--living in a city that is different from the city they work in (if I work in Kolkata, then my
--dependent should not be in Kolkata).
--Additionally, only include employees whose salary is greater than the average salary of
--their job title(suppose, my job_title is ”developer” and the salary is 80k, and the average
--salary under the same job_title “developer” is 70k), and whose manager's job title
--includes the word 'director'. Finally, include the department name and location of each
--employee, and sort the results by department name in ascending order
ALTER TABLE dependents
ADD COLUMN city varchar(255);

UPDATE dependents AS deps SET city = CASE
  WHEN deps.dependent_id = 1 THEN 'Miami'
  WHEN deps.dependent_id = 2 THEN 'Buenos Aires'
  WHEN deps.dependent_id = 3 THEN 'Berlin'
  WHEN deps.dependent_id = 4 THEN 'Kolkata'
  WHEN deps.dependent_id = 5 THEN 'Dublin'
END

SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
  e.salary, d.department_name, l.city
FROM employees e
  INNER JOIN jobs j
    ON e.job_id = j.job_id
  INNER JOIN departments d
    ON e.department_id = d.department_id
  INNER JOIN locations l
    ON d.location_id = l.location_id
  INNER JOIN employees m
    ON e.manager_id = m.employee_id
  INNER JOIN jobs jm
    ON m.job_id = jm.job_id
  INNER JOIN dependents dep
    ON e.employee_id = dep.employee_id
WHERE e.hire_date >= now() - '3 years'::interval
  AND dep.city <> l.city
  AND e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE job_id = e.job_id
  )
  AND jm.job_title LIKE '%director%'
ORDER BY d.department_name;
