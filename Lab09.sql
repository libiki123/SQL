-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Mar 14th, 2019
-- Purpose: Lab 5 DBS301
-- ***********************


-- data modoling process, erd
-- Question 1 --
CREATE TABLE L09SalesRep AS (
    SELECT employee_id RepID, first_name FName, last_name LName, phone_number Phone#, salary Salary, commission_pct Commission
        FROM Employees
        WHERE department_id = 80
);

-- Question 2 --
CREATE TABLE L09Cust (
   Cust#	  	NUMBER(6),
   Custname 	VARCHAR2(30),
   City 		VARCHAR2(20),
   Rating		CHAR(1),
   Comments	    VARCHAR2(200),
   SalesRep#	NUMBER(7) 
);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (501, 'ABC LTD.', 'Montreal', 'C', 201);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (502, 'Black Giant', 'Ottawa', 'B', 202);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (503, 'Mother Goose', 'London', 'B', 202);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (701, 'BLUE SKY LTD', 'Vancouver', 'B', 102);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (702, 'MIKE and SAM Inc.', 'Kingston', 'A', 107);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (703, 'RED PLANET', 'Mississauga', 'C', 107);
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#)
    VALUES (717, 'BLUE SKY LTD', 'Regina', 'D', 102);

-- Question 3 --
CREATE TABLE L09GoodCust AS (
    SELECT cust# CustId, Custname Name, city Location, salesrep# RepId
        FROM L09Cust
        WHERE rating = 'A' OR rating ='B'
);

-- Question 4 --
ALTER TABLE L09SalesRep
    ADD JobCode VARCHAR2(12);
DESCRIBE L09SalesRep;
    
-- Question 5 --
-- A)
ALTER TABLE L09SalesRep
    MODIFY salary NOT NULL;
DESCRIBE L09SalesRep;

-- change to not null then null to see if it work
ALTER TABLE L09GoodCust
    MODIFY location NULL;
DESCRIBE L09GoodCust;

-- B)
-- increase size
ALTER TABLE L09SalesRep
    MODIFY fname VARCHAR2(37);
-- decrease size
SELECT max(length(fname))
            FROM L09SalesRep;
ALTER TABLE L09SalesRep
    MODIFY fname VARCHAR2(8);
    
-- Question 6 --
ALTER TABLE L09SalesRep
    DROP COLUMN jobcode;
    
-- Question 7 --
ALTER TABLE L09SalesRep
    ADD CONSTRAINT pk_repid PRIMARY KEY (repid);
ALTER TABLE L09GoodCust
    ADD CONSTRAINT pk_custid PRIMARY KEY (custid);

-- Question 8 --
ALTER TABLE L09SalesRep
    ADD CONSTRAINT un_phone# UNIQUE (phone#) ;
ALTER TABLE L09GoodCust
    ADD CONSTRAINT un_name UNIQUE (name);
    
-- Question 9 --
ALTER TABLE L09SalesRep
    ADD CONSTRAINT chk_salary CHECK (salary BETWEEN 6000 AND 12000);
ALTER TABLE L09SalesRep
    ADD CONSTRAINT chk_commission CHECK (commission < 0.5);

-- Question 10 --
-- create FK in the other table
ALTER TABLE L09GoodCust
    ADD CONSTRAINT fk_repid FOREIGN KEY (repid) REFERENCES L09SalesRep (repid);
-- It fail because in L09GoodCust repid doesn't corresponding to L09SalesRep repid

-- Question 11 --
UPDATE L09GoodCust
    SET repid = NULL;
DESCRIBE L09GoodCust;
ALTER TABLE L09GoodCust
    ADD CONSTRAINT fk_repid FOREIGN KEY (repid) REFERENCES L09SalesRep (repid);
-- it work since now there is no data in repid that not corresponding

-- Question 12 --
ALTER TABLE L09GoodCust
    DROP CONSTRAINT fk_repid;
UPDATE L09GoodCust
    SET repid = 502
    WHERE name = 'Black Giant';
UPDATE L09GoodCust
    SET repid = 503
    WHERE name = 'Mother Goose';
UPDATE L09GoodCust
    SET repid = 701
    WHERE name = 'BLUE SKY LTD';
UPDATE L09GoodCust
    SET repid = 702
    WHERE name = 'MIKE and SAM Inc.';
ALTER TABLE L09GoodCust
    ADD CONSTRAINT fk_repid FOREIGN KEY (repid) REFERENCES L09SalesRep (repid);
-- Again it wont work

-- Quesion 13 --
ALTER TABLE L09SalesRep
    DROP CONSTRAINT chk_salary;
ALTER TABLE L09SalesRep
    ADD CONSTRAINT chk_salary CHECK (salary BETWEEN 5000 AND 15000);
    
-- Question 14 --
DESCRIBE L09SalesRep;
DESCRIBE L09GoodCust;
SELECT  constraint_name, constraint_type, search_condition, table_name
    FROM user_constraints
    WHERE upper(table_name) IN ('L09SALESREP', 'L09GOODCUST')
    ORDER  BY  4 , 2;

Rollback;