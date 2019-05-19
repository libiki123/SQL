-- *************************
-- Name: Anh-Bang Truong (Ethan)
-- ID: 124753179
-- Date: March 7, 2019
-- Purpose: Lab7 DBS301
-- *************************

-- Question 1 --
SELECT department_id
    FROM Departments
MINUS
SELECT department_id
    FROM Employees
    WHERE upper(job_id) LIKE 'ST_CLERK';
    
-- Question 2 -- 
-- minus all the countries that have a department
SELECT country_id, country_name
    FROM Countries
MINUS
SELECT DISTINCT country_id, country_name
    FROM (Departments JOIN Locations USING (location_id))
        JOIN Countries USING (country_id);
            
-- Question 3 --
SELECT DISTINCT job_id, department_id
    FROM Employees
    WHERE department_id = 10
UNION ALL        
SELECT DISTINCT job_id, department_id
    FROM Employees
    WHERE department_id = 50
UNION ALL
SELECT DISTINCT job_id, department_id
    FROM Employees
    WHERE department_id = 20;
    
-- Question 4 --
-- use the min to get the earliest date 
-- there can be only 2 senerios: 1 that never change job, 1 that change to the original
-- Reference --
SELECT employee_id, job_id
    FROM Employees
INTERSECT
SELECT employee_id, job_id
    FROM job_history;
-- Answer --
SELECT employee_id, job_id
    FROM Employees
INTERSECT
SELECT employee_id, job_id
    FROM job_history
    WHERE (employee_id, start_date) IN (
        SELECT employee_id, min(start_date)
            FROM job_history
            GROUP BY employee_id
    );
-- Question 5 --
SELECT last_name, department_id, to_char(null) AS "Department Name"
    FROM Employees
UNION ALL
SELECT to_char(null), department_id, department_name
    FROM Departments;


