-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Jan 17th, 2019
-- Purpose: Lab 2 DBS301
-- ***********************

-- Question 1 –-
SELECT employee_id, last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY"
    FROM Employees
    WHERE salary BETWEEN 8000 AND 12000
    ORDER BY salary DESC, last_name;
    
-- Question 2 –-
SELECT employee_id, last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY", job_id
    FROM Employees
    WHERE (salary BETWEEN 8000 AND 12000) AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
    ORDER BY salary DESC, last_name;
    
-- Question 3 –-
SELECT employee_id, last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY", job_id
    FROM Employees
    WHERE (salary < 8000 OR salary > 12000) AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
    ORDER BY salary DESC, last_name;

-- Question 4 –-
SELECT last_name, job_id, TO_CHAR(salary, '$999,999.99') AS "SALARY", hire_date
    FROM Employees
    WHERE hire_date < TO_DATE('2018-01-01', 'YYYY-MM-DD')
    ORDER BY hire_date;

-- Question 5 –-
SELECT last_name, job_id, TO_CHAR(salary, '$999,999.99') AS "SALARY", hire_date, employee_id
    FROM Employees
    WHERE (hire_date < TO_DATE('2018-01-01', 'YYYY-MM-DD')) AND salary > 12000
    ORDER BY job_id, salary DESC;

-- Question 6 –-
SELECT job_id AS "Job Title", first_name || ' ' || last_name AS "Full Name"
    FROM Employees
    WHERE LOWER(first_name) LIKE '%e%';
    
-- Question 7 –-
SELECT last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM Employees
    WHERE commission_pct IS NOT NULL;
    
-- Question 8 –-
SELECT last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM Employees
    WHERE commission_pct IS NOT NULL
    ORDER BY salary DESC;
    
-- Question 9 --
SELECT last_name, TO_CHAR(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM Employees
    WHERE commission_pct IS NOT NULL
    ORDER BY 2 DESC;

-- Question 10 --
-- you should never use numeric for sorting because in case when you concat 2 columns together
-- using numberic will in this case having sort base on 2 columns instead of 1