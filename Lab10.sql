-- ***********************
-- Name: Anh-Bang Truong
-- ID: 124753179
-- Date: Mar 29th, 2019
-- Purpose: Lab 10 DBS301
-- ***********************

-- Question 1 --
CREATE TABLE L10Cities AS (
    SELECT * FROM Locations
        WHERE location_id < 2000
);

-- Question 2 --
CREATE TABLE L10Towns AS (
    SELECT * FROM Locations
        WHERE location_id < 1500
);

-- Question 3 --
PURGE RecycleBin;
DROP TABLE L10Towns;
SHOW RecycleBin;

-- Question 4 --
FLASHBACK TABLE L10Towns TO BEFORE DROP;
DESCRIBE L10Towns;
SHOW RecycleBin;

-- Question 5 --
DROP TABLE L10Towns;
PURGE TABLE L10Towns;
FLASHBACK TABLE L10Towns TO BEFORE DROP;
-- object cant be restore because it have been completely removed

-- Question 6 --
CREATE VIEW CAN_CITY_VU AS (
    SELECT street_address, postal_code, city, state_province
        FROM L10Cities
        WHERE upper(country_id) LIKE 'CA'
);
SELECT * FROM CAN_CITY_VU;

-- Question 7 --
CREATE OR REPLACE VIEW CAN_CITY_VU AS (
    SELECT street_address AS "Str_Adr", postal_code AS "P_Code", city AS "City", state_province AS "Prov"
        FROM L10Cities
        WHERE upper(country_id) IN ('CA','IT')
);

-- Question 8 --
CREATE VIEW vwCity_DName_VU AS (
    SELECT department_name, city, state_province
        FROM departments RIGHT JOIN locations USING (location_id)
        WHERE upper(country_id) IN ('CA','IT')
);
SELECT * FROM vwCity_DName_VU;

-- Question 9 --
CREATE OR REPLACE VIEW vwCity_DName_VU AS (
    SELECT department_name AS "DName", city AS "City", state_province AS "Prov"
        FROM departments RIGHT JOIN locations USING (location_id)
        WHERE upper(country_id) NOT LIKE 'US'
);

-- Question 10 --
SELECT * FROM ALL_OBJECTS WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191B26';
DROP VIEW vwCity_DName_VU;
-- vwCity_DName_Vu view is no longer in the list
