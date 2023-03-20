-- PostgreSQL

-- 1. Create the following schema.
CREATE TABLE jobs (
	job_id serial PRIMARY KEY,
	job_title varchar(255),
	min_salary integer,
	max_salary integer
);

CREATE TABLE regions(
	region_id serial PRIMARY KEY,
	region_name varchar(255)
);

CREATE TABLE countries (
	country_id serial PRIMARY KEY,
	country_name varchar(255),
	region_id integer REFERENCES regions(region_id)
);

CREATE TABLE locations (
	location_id serial PRIMARY KEY,
	street_address varchar(255),
	postal_code varchar(255),
	city varchar(255),
	state_province varchar(255),
	country_id integer REFERENCES countries(country_id)
);

CREATE TABLE departments (
	department_id serial PRIMARY KEY,
	department_name varchar(255),
	location_id integer REFERENCES locations(location_id)
);

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	email varchar(255),
	phone_number varchar(255),
	hire_date date,
	job_id integer REFERENCES jobs(job_id),
	salary integer,
	manager_id integer REFERENCES employees(employee_id),
	department_id integer REFERENCES departments(department_id)
);

CREATE TABLE dependents (
	dependent_id serial PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	relationship varchar(255),
	employee_id integer REFERENCES employees(employee_id)
);

-- 2. Insert 5 rows in the jobs, dependents, regions, countries, locations,
-- departments tables and  10 rows in the Employee table.

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES ('Frontend Developer', 50000, 300000);

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES ('Backend Developer', 60000, 350000);

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES ('Database Engineer', 50000, 325000);

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES ('DevOps Engineer', 30000, 200000);

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES ('Testing Engineer', 25000, 100000);

INSERT INTO regions(region_name)
VALUES ('North America');

INSERT INTO regions(region_name)
VALUES ('South America');

INSERT INTO regions(region_name)
VALUES ('Europe');

INSERT INTO regions(region_name)
VALUES ('Asia');

INSERT INTO regions(region_name)
VALUES ('Oceania');

INSERT INTO countries(country_name, region_id)
VALUES ('USA', 
	(SELECT region_id FROM regions WHERE region_name = 'North America'));

INSERT INTO countries(country_name, region_id)
VALUES ('Argentina', 
	(SELECT region_id FROM regions WHERE region_name = 'South America'));

INSERT INTO countries(country_name, region_id)
VALUES ('Germany', 
	(SELECT region_id FROM regions WHERE region_name = 'Europe'));

INSERT INTO countries(country_name, region_id)
VALUES ('India', 
	(SELECT region_id FROM regions WHERE region_name = 'Asia'));

INSERT INTO countries(country_name, region_id)
VALUES ('New Zealand', 
	(SELECT region_id FROM regions WHERE region_name = 'Oceania'));

INSERT INTO locations (street_address, postal_code, city, state_province, country_id)
VALUES ('32 Lions Creek Avenue', '1600', 'Miami', 'Florida', 
	(SELECT country_id FROM countries WHERE country_name = 'USA'));

INSERT INTO locations (street_address, postal_code, city, state_province, country_id)
VALUES ('64 Diego Maradona Street', '3100', 'Buenos Aires', 'Buenos Aires', 
	(SELECT country_id FROM countries WHERE country_name = 'Argentina'));

INSERT INTO locations (street_address, postal_code, city, state_province, country_id)
VALUES ('128 Herman Hesse Street', '6500', 'Berlin', 'Berlin', 
	(SELECT country_id FROM countries WHERE country_name = 'Germany'));

INSERT INTO locations (street_address, postal_code, city, state_province, country_id)
VALUES ('256 Shakespeare Avenue', '128', 'Kolkata', 'West Bengal', 
	(SELECT country_id FROM countries WHERE country_name = 'India'));

INSERT INTO locations (street_address, postal_code, city, state_province, country_id)
VALUES ('512 Lions Creek Avenue', '257', 'Auckland', 'Auckland', 
	(SELECT country_id FROM countries WHERE country_name = 'New Zealand'));

INSERT INTO departments (department_name, location_id)
VALUES ('Web Design', (SELECT location_id FROM locations WHERE city = 'Auckland'));

INSERT INTO departments (department_name, location_id)
VALUES ('Development', (SELECT location_id FROM locations WHERE city = 'Kolkata'));

INSERT INTO departments (department_name, location_id)
VALUES ('Logistics', (SELECT location_id FROM locations WHERE city = 'Berlin'));

INSERT INTO departments (department_name, location_id)
VALUES ('Marketing', (SELECT location_id FROM locations WHERE city = 'Buenos Aires'));

INSERT INTO departments (department_name, location_id)
VALUES ('Finance', (SELECT location_id FROM locations WHERE city = 'Miami'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('John', 'Doe', 'john_doe@gmail.com', '9625381350', '2019-03-15',
	(SELECT job_id FROM jobs WHERE job_title = 'Frontend Developer'), 90000, NULL,
	(SELECT department_id FROM departments WHERE department_name = 'Web Design'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Alice', 'Smith', 'alice_smith@gmail.com', '7492582091', '2017-06-19',
	(SELECT job_id FROM jobs WHERE job_title = 'Backend Developer'), 95000, NULL,
	(SELECT department_id FROM departments WHERE department_name = 'Development'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Arun', 'Sharma', 'arun_sharma@gmail.com', '7261459714', '2019-09-11',
	(SELECT job_id FROM jobs WHERE job_title = 'Database Engineer'), 82000, NULL,
	(SELECT department_id FROM departments WHERE department_name = 'Logistics'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Varun', 'Gupta', 'varun_gupta@gmail.com', '7482194561', '2020-09-25',
	(SELECT job_id FROM jobs WHERE job_title = 'DevOps Engineer'), 80000, 
	(SELECT employee_id FROM employees WHERE first_name = 'John' AND last_name = 'Doe'),
	(SELECT department_id FROM departments WHERE department_name = 'Development'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Suresh', 'Aggarwal', 'suresh_aggarwal@gmail.com', '7427194561', '2020-12-28',
	(SELECT job_id FROM jobs WHERE job_title = 'Testing Engineer'), 70000, 
	(SELECT employee_id FROM employees WHERE first_name = 'John' AND last_name = 'Doe'),
	(SELECT department_id FROM departments WHERE department_name = 'Marketing'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Sunil', 'Mittal', 'sunil_mittal@gmail.com', '6472819567', '2021-07-24',
	(SELECT job_id FROM jobs WHERE job_title = 'Frontend Developer'), 120000, 
	(SELECT employee_id FROM employees WHERE first_name = 'Varun' AND last_name = 'Gupta'),
	(SELECT department_id FROM departments WHERE department_name = 'Web Design'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Gaurav', 'Pal', 'gaurav_pal@gmail.com', '6372819465', '2018-05-28',
	(SELECT job_id FROM jobs WHERE job_title = 'Database Engineer'), 100000, 
	(SELECT employee_id FROM employees WHERE first_name = 'Suresh' AND last_name = 'Aggarwal'),
	(SELECT department_id FROM departments WHERE department_name = 'Development'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Priyankar', 'Sen', 'priyankar_sen@gmail.com', '6754298417', '2022-02-22',
	(SELECT job_id FROM jobs WHERE job_title = 'Backend Developer'), 96000, 
	(SELECT employee_id FROM employees WHERE first_name = 'John' AND last_name = 'Doe'),
	(SELECT department_id FROM departments WHERE department_name = 'Finance'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Rakesh', 'Chopra', 'rakesh_chopra@gmail.com', '7361296543', '2020-08-10',
	(SELECT job_id FROM jobs WHERE job_title = 'Testing Engineer'), 50000, 
	(SELECT employee_id FROM employees WHERE first_name = 'Sunil' AND last_name = 'Mittal'),
	(SELECT department_id FROM departments WHERE department_name = 'Logistics'));

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date,
	job_id, salary, manager_id, department_id)
VALUES ('Adam', 'Johnson', 'adam_johnson@gmail.com', '6452839560', '2019-12-01',
	(SELECT job_id FROM jobs WHERE job_title = 'Frontend Developer'), 75000, 
	(SELECT employee_id FROM employees WHERE first_name = 'John' AND last_name = 'Doe'),
	(SELECT department_id FROM departments WHERE department_name = 'Finance'));

INSERT INTO dependents(first_name, last_name, relationship, employee_id) 
VALUES ('Veronica', 'Doe', 'Wife', 
	(SELECT employee_id FROM employees WHERE first_name = 'John' AND last_name = 'Doe'));

INSERT INTO dependents(first_name, last_name, relationship, employee_id) 
VALUES ('Sagarika', 'Mittal', 'Wife', 
	(SELECT employee_id FROM employees WHERE first_name = 'Sunil' AND last_name = 'Mittal'));

INSERT INTO dependents(first_name, last_name, relationship, employee_id) 
VALUES ('Snatosh', 'Chopra', 'Son', 
	(SELECT employee_id FROM employees WHERE first_name = 'Rakesh' AND last_name = 'Chopra'));

INSERT INTO dependents(first_name, last_name, relationship, employee_id) 
VALUES ('Ranjit', 'Sen', 'Son', 
	(SELECT employee_id FROM employees WHERE first_name = 'Priyankar' AND last_name = 'Sen'));

INSERT INTO dependents(first_name, last_name, relationship, employee_id) 
VALUES ('Nichole', 'Johnson', 'Wife', 
	(SELECT employee_id FROM employees WHERE first_name = 'Adam' AND last_name = 'Johnson'));

-- 3. Column:
-- a. In departments table, add a new field ‘manager_name’ of type VARCHAR
-- b. REMOVE field max_salary from jobs. 
-- c. In the locations table, rename postal_code column to pincode.

ALTER TABLE departments ADD COLUMN manager_name varchar(255);

ALTER TABLE jobs DROP COLUMN max_salary;

ALTER TABLE locations RENAME postal_code TO pincode;

-- 4. Constraints:
-- First_name and last_name should not be null
-- Min_salary must be greater than 1000
-- Max length of postal_code should be 10.

ALTER TABLE employees
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE dependents
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE jobs ADD CHECK (min_salary > 1000);

ALTER TABLE locations ADD CHECK (char_length(pincode) <= 10);
