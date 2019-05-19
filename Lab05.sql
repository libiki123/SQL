-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Jan 31, 2019
-- Purpose: Lab 5 DBS301
-- ***********************

-- Question 1 –-

SELECT department_name, city, street_address, postal_code
    FROM Departments, Locations
    WHERE Departments.location_id = Locations.location_id
    ORDER BY city, department_name;
    
-- Question 2 –-

SELECT last_name || ' ' || first_name AS "FULL NAME", hire_date, to_char(salary,'$999,999.00') AS "SALARY", department_name, city
    FROM Departments, Employees, Locations
    WHERE Employees.department_id = Departments.department_id AND Departments.location_id = Locations.location_id 
        AND (upper(department_name) LIKE 'A%' OR upper(department_name) LIKE 'S%')
    ORDER BY department_name, "FULL NAME";

-- Question 3 –-

SELECT last_name || ' ' || first_name AS "FULL NAME", department_name, city, postal_code, state_province
    FROM Departments, Employees, Locations
    WHERE Employees.department_id = Departments.department_id AND Departments.location_id = Locations.location_id
        AND upper(state_province) IN ('ONTARIO', 'NEW JERSEY', 'WASHINGTON')
    ORDER BY city, department_name;

-- Question 4 –-

SELECT a.last_name AS "Employee", a.employee_id AS "Emp#", b.last_name "Manager", a.manager_id AS "Mgr#"
    FROM Employees a, Employees b 
    WHERE a.manager_id = b.employee_id;

-- Question 5 –- assume you want to see all departments

SELECT department_name, city, street_address, postal_code, country_name
    FROM (Departments LEFT JOIN Locations 
        USING(location_id))
        INNER JOIN Countries
            USING (country_id)
    ORDER BY department_name DESC;
    
-- Question 6 –- assume you want to see all employees

SELECT first_name|| '/' || last_name AS "FULL NAME", hire_date, to_char(salary,'$999,999.00') AS "SALARY", department_name
    FROM Employees a LEFT JOIN Departments b
        ON (a.department_id = b.department_id)
    WHERE upper(department_name) LIKE 'A%' OR upper(department_name) LIKE 'S%'
    ORDER BY department_name, last_name;

-- Question 7 –- assume you want to see all employees

SELECT last_name|| ',' || first_name AS "FULL NAME", department_name, city, postal_code, state_province
    FROM Employees a LEFT JOIN Departments b
        ON (a.department_id = b.department_id)
        INNER JOIN Locations c
            ON(b.location_id = c.location_id)
    WHERE upper(state_province) IN ('ONTARIO', 'NEW JERSEY', 'WASHINGTON')
    ORDER BY city, department_name;

-- Question 8 –- assume you want to see all department

SELECT department_name, to_char(max(salary),'$999,999.00') AS "HIGH", to_char(min(salary),'$999,999.00') AS "LOW",
    to_char(avg(salary),'$999,999.00') AS "AVG"
    FROM Employees a RIGHT JOIN Departments b
        ON(a.department_id = b.department_id)
    GROUP BY department_name
    ORDER BY "AVG" DESC;

-- Question 9 

SELECT a.last_name AS "Employee", a.employee_id AS "Emp#", b.last_name "Manager", a.manager_id AS "Mgr#"
    FROM Employees a FULL JOIN Employees b 
        ON (a.manager_id = b.employee_id)
    WHERE a.employee_id IN (
        SELECT b.employee_id 
            FROM Employees a RIGHT JOIN Employees b 
                ON (a.manager_id = b.employee_id)
            WHERE a.employee_id IS NULL OR b.manager_id IS NULL);
    
