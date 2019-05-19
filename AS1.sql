-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Feb 18, 2019
-- Purpose: Assignment 1 - DBS301
-- ***********************

-- Question 1 –-
SELECT employee_id,
    cast(last_name || ', ' || first_name AS VARCHAR(25)) AS "FULL NAME",
    job_id,
    to_char(last_day(hire_date), 'fm[Month ddth " of " YYYY]') AS "Hire Day"
    FROM Employees
    WHERE to_char(hire_date, 'MM') IN (05,11)
    ORDER BY hire_date DESC;

-- Question 2 –-
SELECT 'Emp# ' || employee_id || ' named ' ||
    first_name || ' ' || last_name || ' who is ' ||
    job_id || ' will have a new salary of ' ||
    CASE WHEN upper(job_id) LIKE '%VP' 
        THEN to_char((salary * 1.25),'fm$999,999') 
        ELSE to_char((salary * 1.18),'fm$999,999') 
        END "MODIFIED SALARY"
    FROM Employees
    WHERE (salary NOT BETWEEN 5000 AND 10000) AND (upper(job_id) LIKE '%VP' OR upper(job_id) LIKE '%MAN' OR upper(job_id) LIKE '%MGR')
    ORDER BY salary DESC;
    
-- Question 3 –-
SELECT last_name, salary, job_id, NVL(to_char(manager_id), 'NONE') AS "Manager#",
    CASE WHEN commission_pct IS NULL 
        THEN to_char((salary  + 1000) * 12, 'fm$999,999.00') 
        ELSE to_char((salary + (salary * commission_pct) + 1000) * 12, 'fm$999,999.00') 
        END "Total Income"
    FROM Employees
    WHERE (commission_pct IS NULL OR upper(job_id) LIKE 'SA%')
        AND ((CASE WHEN commission_pct IS NULL 
                THEN salary  + 1000 
                ELSE salary + (salary * commission_pct) + 1000 END)  > 15000);
                
-- Question 4 –-
SELECT NVL(to_char(department_id), 'NONE') || ' ' || job_id || ' ' || min(salary) AS "Lowest Dept/Job Pay"
    FROM Employees
    WHERE upper(job_id) NOT LIKE '%REP' AND upper(job_id) NOT LIKE 'IT%' AND upper(job_id) NOT LIKE 'SA%'
    GROUP BY department_id, job_id
    HAVING (min(salary) BETWEEN 6000 AND 18000) 
        
    ORDER BY department_id, job_id;
                
-- Question 5 –-
SELECT last_name, salary, job_id
    FROM (Employees e LEFT JOIN Departments d USING (department_id))
        JOIN Locations l USING (location_id)
    WHERE (salary, department_id) NOT IN
        (
        SELECT min(salary), department_id
            FROM Employees
            GROUP BY department_id
        )
        AND upper(l.country_id) != 'US'
        AND upper(job_id) NOT LIKE '%PRES'
        AND upper(job_id) NOT LIKE '%VP'
    ORDER BY job_id; 
        
-- Question 6 –-
SELECT last_name, salary, job_id
    FROM Employees
    WHERE salary >
        (
         SELECT min(salary)
            FROM Employees
            WHERE upper(job_id) LIKE 'AC%'
        )
        AND (upper(job_id) LIKE 'IT%' OR upper(job_id) LIKE 'MK%')
    ORDER BY last_name;
    
-- Question 7 –-
SELECT cast(first_name || ' ' || last_name AS VARCHAR(25)) AS "Full Name", job_id,
    LPAD(to_char(salary, '$999,999'), 15, '=') AS "Salary", department_id
    FROM Employees
    WHERE salary < ANY
        (
        SELECT max(salary)
        FROM Employees
        WHERE (upper(job_id) NOT LIKE '%PRES'
            OR upper(job_id) NOT LIKE '%MAN'
            OR upper(job_id) NOT LIKE '%VP')
        )
        AND (upper(job_id) LIKE 'SA%'
        OR upper(job_id) LIKE 'MK%');
        

-- Question 8 –-
SELECT department_name,cast(NVL(city, 'Not Assigned Yet') AS VARCHAR(25)) AS "City",
    count(job_id) AS "# of jobs"
    FROM (Employees e FULL JOIN Departments d USING (department_id))
        FULL JOIN Locations l USING (location_id)
    GROUP BY department_name, city;




        
