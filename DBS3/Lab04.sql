-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Jan 31, 2019
-- Purpose: Lab 4 DBS301
-- ***********************

-- Question 1 –-

SELECT to_char(min(salary), '$999,999.00') AS "MinSalary", to_char(avg(salary), '$999,999.00') AS "AvgSalary", 
    to_char(avg(salary)-min(salary), '$999,999.00') AS "Real Amount"
    FROM Employees;
    
-- Question 2 --

SELECT department_id AS "Department", to_char(max(salary), '$999,999.00') AS "MaxSalary",
    to_char(min(salary), '$999,999.00') AS "MinSalary", to_char(avg(salary), '$999,999.00') As "AvgSalary"
    FROM Employees
    GROUP BY department_id
    ORDER BY "AvgSalary" DESC;
    
-- Question 3 --

SELECT department_id AS "Dept#", job_id AS "Job", count(employee_id) AS "How Many"
    FROM Employees
    GROUP BY department_id, job_id
    HAVING count(employee_id) > 1
    ORDER BY "How Many" DESC;
    
-- Question 4 --

SELECT job_id AS "Job Titile", count(salary) AS "Total Amount Each Month"
    FROM Employees
    WHERE upper(job_id) NOT IN ('AD_PRES', 'AD_VP')
    GROUP BY job_id
    HAVING count(salary) > 11000
    ORDER BY "Total Amount Each Month" DESC;
    
-- Question 5 --

SELECT manager_id AS "Manager", count(employee_id) AS "How Many He/She Supercises"
    FROM Employees
    WHERE manager_id NOT IN (100, 101, 102) 
    GROUP BY manager_id 
    HAVING count(employee_id) > 2
    ORDER BY "How Many He/She Supercises" DESC;

-- Question 6 --
    
SELECT department_id AS "Department", max(hire_date) "Latest HireDate", min(hire_date) "Earliest HireDate"
    FROM Employees
    WHERE department_id NOT IN (10, 20) AND hire_date < sysdate AND hire_date > to_date(31122009, 'ddmmyyyy')
    GROUP BY department_id 
    ORDER BY "Latest HireDate" DESC;
    


    
    
    

