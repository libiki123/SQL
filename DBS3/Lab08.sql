-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Mar 14th, 2019
-- Purpose: Lab 5 DBS301
-- ***********************

-- Question 1 --
SELECT first_name || last_name AS "Full Name", to_char(salary, '$9,999,999.00') AS "Salary"
    FROM Employees
    WHERE salary IN (
        SELECT min(salary)
            FROM Employees
            GROUP BY department_id
    );
    
-- Question 2 --
SELECT first_name || last_name AS "Full Name", to_char(salary, '$9,999,999.00') AS "Salary", department_id
    FROM Employees
    WHERE (salary, department_id) IN (
        SELECT min(salary), department_id
            FROM Employees
            GROUP BY department_id
    );
    
-- Question 3 --
SELECT first_name || last_name AS "Full Name", to_char(salary + 120, '$9,999,999.00') AS "Salary", department_id
    FROM Employees
    WHERE (salary, department_id) IN (
        SELECT min(salary), department_id
            FROM Employees
            GROUP BY department_id
    );
    
-- Question 4 --
CREATE VIEW vwAllEmps AS (
    SELECT employee_id, last_name, salary, department_id, department_name, city, country_id
    FROM ((Employees LEFT JOIN Departments USING (department_id))
        LEFT JOIN Locations USING (location_id))
        lEFT JOIN Countries USING (country_id)
);

-- Qestion 5 --
-- a)
SELECT employee_id, last_name, to_char(salary, '$9,999,999.00') AS "Salary", city
    FROM vwAllEmps;
    
-- b)
SELECT to_char(sum(Salary), '$9,999,999.00') AS "Total salary", city
    FROM vwAllEmps
    GROUP BY city;
    
-- c)
SELECT employee_id, last_name, to_char(salary - 120, '$9,999,999.00') AS "Salary", department_id
    FROM vwAllEmps
    WHERE (salary, department_id) IN (
        SELECT min(salary), department_id
            FROM vwAllEmps
            GROUP BY department_id
    );
    
-- d)
-- does not work prompt error "cannot modify more than one base table through a join view"
INSERT INTO vwAllEmps VALUES (999,'testing',9999,10,'IT','Toronto','US');

-- e)
-- it work
DELETE FROM vwAllEmps WHERE employee_id = 144;

-- Question 6 --
CREATE VIEW vwAllDepts AS (
    SELECT department_id, department_name, city, country_id
        FROM (Departments LEFT JOIN Locations USING (location_id))
            LEFT JOIN Countries USING (country_id)
);

-- Question 7 --
-- a)
SELECT department_id, department_name, city
    FROM vwAllDepts;
    
-- b)
SELECT count(department_id) AS "Number of Departments", city
    FROM vwAllDepts
    GROUP BY city;

-- Question 8 --
CREATE VIEW vwAllDeptSumm AS (
    SELECT department_id, department_name, count(employee_id) AS "Number of Employees",
        count(commission_pct) AS "Number of Salaried Employees",
        to_char(sum(
            CASE WHEN commission_pct IS NULL
                THEN salary
                ELSE salary + (salary * commission_pct) END
            ), '$9,999,999.00') AS "Total salary"
        FROM Employees RIGHT JOIN Departments USING (department_id)
        GROUP BY department_id, department_name
);

-- Question 9 --
SELECT department_name, "Number of Employees"
    FROM vwAllDeptSumm
    WHERE "Number of Employees" > (
        SELECT avg("Number of Employees")
        FROM vwAllDeptSumm
    );
    
-- Question 10 --
-- a)
GRANT
  SELECT,
  INSERT,
  UPDATE
ON
  schema.Departments
TO
  dbs301_191b42;
  
-- b)
REVOKE
  INSERT,
  UPDATE
ON
  schema.Departments
FROM
  dbs301_191b42;
