---------------------------------------------------------------------------------------------------------------
-- Name: Anh-Bang Truong (Ethan), 
-- ID: 124753179,
-- Group 7
-- Assignment 2
----------------------------------------------------------------------------------------------------------------
CREATE TABLE Schools(
    school_id       VARCHAR(10)     PRIMARY KEY,
    school_name     VARCHAR(30)     NOT NULL,
    school_type     VARCHAR(15)     NOT NULL
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Areas_info(
    area_id         VARCHAR(10)      PRIMARY KEY,
    area_name       VARCHAR(30)      NOT NULL,
    area_comment    VARCHAR2(300)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE School_list(
    CONSTRAINT School_list_pk PRIMARY (area_id, school_id),
    CONSTRAINT list_area_fk
        FOREIGN KEY (area_id) REFERENCES Area_info (area_id),
    CONSTRAINT list_school_fk
        FOREIGN KEY (school_id) REFERENCES Schools (school_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Address (
    adress_id       VARCHAR(10)     PRIMARY KEY,
    street          VARCHAR(30)     NOT NULL,
    city            VARCHAR(30)     NOT NULL,
    province        VARCHAR(20)     NOT NULL,
    postal_code     VARCHAR(10)     NOT NULL
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Properties_info(
    property_id             INT(5)          PRIMARY KEY,
    num_of_bedrooms         INT(2)          NOT NULL,
    num_of_bathrooms        INT(2)          NOT NULL,
    square_area             INT             NOT NULL,
    property_price          INT             NOT NULL,
    status                  VARCHAR(15)     NOT NULL,
    CONSTRAINT prop_address_fk
        FOREIGN KEY (address_id) REFERENCES Address (address_id),
    CONSTRAINT prop_area_fk
        FOREIGN KEY (area_id) REFERENCES Area_info (area_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Condo_type (
    con_type_id         VARCHAR(5)      PRIMARY KEY,
    maintenance_fee     INT             NOT NULL
     CONSTRAINT con_prop_fk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Single_home_type (
    sh_type_id      VARCHAR(5)      PRIMARY KEY,
    land_size       INT             NOT NULL
    CONSTRAINT sh_prop_fk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Outlets(
    outlet_id           VARCHAR(10)     PRIMARY KEY,
    outlet_name         VARCHAR(30)     NOT NULL,
    outlet_phone_num    VARCHAR(15)     NOT NULL
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Advertising(
    ad_id           VARCHAR(10)         PRIMARY KEY,
    ad_date         DATE                NOT NULL,
    ad_price        INT                 NOT NULL,
    CONSTRAINT ad_prop_fk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id),
    CONSTRAINT ad_outlet_fk
        FOREIGN KEY (outlet_id) REFERENCES Outlets (outlet_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Agencies(
    agency_id           VARCHAR(10)     PRIMARY KEY,
    agency_name         VARCHAR(30)     NOT NULL,
    agency_phone_num    VARCHAR(15)     NOT NULL
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Agency_listing(
    CONSTRAINT agency_listing_pk PRIMARY (agency_id, property_id),
    CONSTRAINT al_agency_fk
        FOREIGN KEY (agency_id) REFERENCES Agencies (agency_id),
    CONSTRAINT al_prop_fk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Clients_info (
    client_id       VARCHAR(10)         PRIMARY KEY,
    first_name      VARCHAR(20)         NOT NULL,
    last_name       VARCHAR(20)         NOT NULL,
    phone_num       VARCHAR(15)         NOT NULL,
    email           VARCHAR(30),
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Intent (
    intent_id           VARCHAR(10)         PRIMARY KEY,
    intent_to_sell      CHAR(1)             NOT NULL,
    intent_to_buy       CHAR(1)             NOT NULL,
    CONSTRAINT intent_client_fk
        FOREIGN KEY (client_id) REFERENCES Clients_info (client_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Ownership (
    ownership%      DECIMAL(5,4)            NOT NULL,
    CONSTRAINT ownership_pk PRIMARY (client_id, property_id),
    CONSTRAINT own_client_fk
        FOREIGN KEY (client_id) REFERENCES Clients_info (client_id),
    CONSTRAINT own_prop_fk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Records (
    record_id       VARCHAR(10)         PRIMARY KEY,
    sold_price      INT                 NOT NULL,
    CONSTRAINT records_prop_pk
        FOREIGN KEY (property_id) REFERENCES Properties_info (property_id),
    CONSTRAINT records_client_pk
        FOREIGN KEY (client_id) REFERENCES Clients_info (client_id)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE References (
    reference_id         VARCHAR(10)         PRIMARY KEY,
    reference_fee        INT                 NOT NULL
    CONSTRAINT reference_client_fk
        FOREIGN KEY (client_id) REFERENCES Clients_info (client_id),
    CONSTRAINT reference_record_fk
        FOREIGN KEY (record_id) REFERENCES Records (record_id)
);

    