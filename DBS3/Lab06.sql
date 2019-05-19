-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Jan 31, 2019
-- Purpose: Lab 5 DBS301
-- ***********************

-- Question 1 –-
SET AUTOCOMMIT ON 

-- Question 2 –-
INSERT INTO Employees
    VALUES (333,'AnhBang','Truong','atruong17@seneca.ca','111.111.1111','19-02-15','CO_OP',NULL,0.21,100,90);
    
-- Question 3 –-
UPDATE Employees
    SET salary = 2500
    WHERE upper(last_name) IN ('MATOS','WHALEN');
    
-- Question 4 –-
SELECT last_name
    FROM Employees
    WHERE department_id =
        (
        SELECT DISTINCT department_id
            FROM Employees
            WHERE upper(last_name) = 'ABEL'   
        );

-- Question 5 –-
SELECT last_name
    FROM Employees
    WHERE salary =
        (
        SELECT min(salary)
            FROM Employees
        );

-- Question 6 –-
SELECT city
    FROM Locations
    WHERE location_id IN
        (
        SELECT location_id
            FROM Departments d
            WHERE department_id IN
                (
                SELECT department_id
                    FROM Employees e
                    WHERE salary = 
                        (
                        SELECT min(salary)
                            FROM Employees
                        )
                )
        );

-- Question 7 –-
SELECT last_name, department_id, salary
    FROM Employees
    WHERE (salary, department_id) IN 
        (
        SELECT min(salary), department_id FROM Employees GROUP BY department_id
        )
    ORDER BY department_id;
    
-- Question 8 --
SELECT city, last_name
    FROM Employees e JOIN Departments d USING (department_id) JOIN Locations l USING (location_id)
    WHERE (salary, city) IN 
        (
        SELECT min(e.salary),l.city
            FROM employees e JOIN departments d ON e.department_id = d.department_id
                JOIN locations l ON d.location_id = l.location_id
            GROUP BY l.city
        );
        
-- Question 9 --
SELECT last_name, salary
    FROM Employees
    WHERE salary < ANY
        (
        SELECT min(salary) FROM Employees GROUP BY department_id
        )
    ORDER BY salary DESC, last_name;

-- Question 10 --
SELECT last_name, job_id, salary
    FROM Employees
    WHERE salary = ANY
        (
        SELECT DISTINCT salary FROM Employees WHERE upper(job_id) LIKE 'IT%'
        )
    ORDER BY salary, last_name;
