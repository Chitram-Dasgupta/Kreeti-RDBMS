-- PostgreSQL

-- 1. Create a trigger to fill up the full_name column in the dependents table while
-- inserting any new records.

ALTER TABLE dependents ADD COLUMN IF NOT EXISTS full_name varchar(255);
  
CREATE OR REPLACE FUNCTION trg_fill_full_name()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.full_name := CONCAT(NEW.first_name, ' ', NEW.last_name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fill_full_name
BEFORE INSERT ON dependents
FOR EACH ROW EXECUTE FUNCTION trg_fill_full_name();

-- 2. Create a trigger that stores the transaction records of each insert, update and
-- delete operations performed on the locations table into locations_info table

CREATE TABLE locations_info (
    id SERIAL PRIMARY KEY,
    operation VARCHAR(10) NOT NULL,
    location_id INT,
    street_address VARCHAR(255),
    pincode VARCHAR(10),
    city VARCHAR(255),
    state_province VARCHAR(255),
    country_id INT
);

CREATE OR REPLACE FUNCTION trg_locations_audit()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('INSERT', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('UPDATE', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('DELETE', OLD.location_id, OLD.street_address, OLD.pincode, OLD.city, OLD.state_province, OLD.country_id);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_locations_audit
AFTER INSERT OR UPDATE OR DELETE ON locations
FOR EACH ROW EXECUTE FUNCTION trg_locations_audit();

-- 3. For the following tables create a view named employee_information with
-- employee first name, last name, salary, department name, city, postal code insert
-- only those records whose postal code length is less than 5.

CREATE VIEW employee_information AS
SELECT e.first_name, e.last_name, e.salary, d.department_name, l.city, l.pincode
FROM employees e JOIN departments d 
  ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
  WHERE LENGTH(l.pincode) < 5;
  
-- 4. Explain ACID properties with an example

The ACID properties of a Relational DBMS are:

i. Atomicity: This property ensures that either the transaction fully completes or
is rolled back to start over from the beginning. If the transaction fails in
the middle, it is started over again from the start.

For example, in an online transaction, it is ensured that the deposit and the
corresponsing update in the total balance completes fully. Even if it fails in
the middle, the transaction restarts from the beginning. This ensures data
integrity.

ii. Consistency: This property ensures that a transaction moves the database from
one consistent state to another consistent state. It guarantees that the 
database is always in a consistent state, maintaining data integrity and 
preserving data integrity constraints.

For example, in an online transaction, it is ensured that the deposit and the
balance are updated by the DB transaction. As a result, data integrity is
maintained and the Database is in a consistent state.

iii. Isolation: This property ensures that multiple transactions can execute
simultaneously without interfering with each other. Each transaction operates
as if it is the only transaction executing on the database, even if multiple 
transactions are executing concurrently.

iv. Durability: This property makes sure that the changes commited to the 
database persist even if there are power outages.

-- 5. Answer the above question with explanation

The Occupation column has been used to make the index. This is because, after
sorting the table by the Occupation column, the original rows will get placed
in the given sequence: 1, 3, 2, 5 and 4.
