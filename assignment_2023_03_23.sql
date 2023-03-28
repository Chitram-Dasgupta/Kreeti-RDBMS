-- PostgreSQL

-- 1. Find all the departments where the minimum salary is less than 2000.
SELECT d.department_name FROM departments d WHERE EXISTS (
  SELECT e.employee_id FROM employees e 
    WHERE e.department_id = d.department_id AND e.salary < 2000
);

-- 2. Find all the countries where no employees exist.
SELECT c.country_name FROM countries c WHERE country_id NOT IN (
  SELECT l.country_id FROM locations l WHERE EXISTS (
    SELECT d.location_id FROM departments d WHERE EXISTS (
      SELECT e.employee_id FROM employees e WHERE e.department_id = d.department_id
    ) AND d.location_id = l.location_id
  )
);

-- 3. From the following tables write a query to find all the jobs, 
--having at least 2 employees in a single department.(don’t use joins)
SELECT job_title FROM jobs WHERE job_id IN (
  SELECT DISTINCT job_id FROM (
    SELECT DISTINCT job_id, department_id, (SELECT count(employee_id) 
      FROM employees e2 
      WHERE e2.department_id = e1.department_id) AS num_employees
      FROM employees e1
  ) t WHERE num_employees >= 2
);
    
-- 4. From the following tables write a query to find all the countries,
-- having cities with all the city names starting with 'a'.(don’t use joins)
SELECT country_name FROM countries WHERE country_id IN
(SELECT country_id FROM
  (SELECT DISTINCT country_id,
    (SELECT city FROM locations l2
      WHERE l2.location_id = l1.location_id) AS same_cities
        FROM locations l1) t1 WHERE LEFT(same_cities, 1) IN ('a'));
      
-- 5. From the following tables write a query to find all the departments, having no cities.
SELECT d.department_name FROM departments d WHERE d.location_id IN
  (SELECT location_id FROM locations l WHERE l.city IS NULL);
