-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Jan 24, 2019
-- Purpose: Lab 3 DBS301
-- ***********************

-- Question 1 –-

SELECT to_char(sysdate + 1, 'fmMonth ddth" of year "yyyy') AS "Tomorrow" FROM dual;

-- Question 2 –-

SELECT last_name, first_name, salary * 1.4 AS "Good Salary", ((salary * 1.4) - salary) * 12 AS "Annual Pay Increase"
    FROM Employees
    WHERE department_id = 20 OR department_id = 50 OR department_id = 60;
    
-- Question 3 –-

SELECT last_name|| ', ' || first_name || ' is ' || job_id AS "Person and job"
    FROM Employees
    WHERE UPPER(last_name) LIKE '%S' AND (UPPER(first_name) LIKE 'C%' OR UPPER(first_name) LIKE 'K%')
    ORDER BY last_name;
    
-- Question 4 –-

SELECT last_name, hire_date, round(months_between(sysdate, hire_date)/12) AS "Years worked"
    FROM Employees
    WHERE hire_date < to_date(20120101, 'yyyymmdd')
    ORDER BY "Years worked";
    
-- Question 5 –-

SELECT city, country_id, 
    (CASE 
        WHEN state_province IS NULL 
        THEN 'Unknown Province' 
        ELSE state_province 
    END) AS "PROVINCE" 
    FROM Locations
    WHERE UPPER(city) LIKE 'S%' AND (LENGTH(city) > 8);
    
-- Question 6 –-

SELECT last_name, hire_date, 
    to_char(next_day(add_months(hire_date,12),'Thursday'),'DAY, fmMonth "the" Ddsp "of year" yyyy' ) AS "REVIEW DATE"
    FROM Employees
    WHERE hire_date > to_date(20170101, 'yyyymmdd')
    ORDER BY "REVIEW DATE";

    






