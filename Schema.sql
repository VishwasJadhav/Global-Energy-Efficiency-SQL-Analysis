CREATE DATABASE ENERGYDB;
USE ENERGYDB;


-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10),
    Country VARCHAR(100) PRIMARY KEY
);

SELECT * FROM COUNTRY;

-- 2. emission table
CREATE TABLE emission (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION;


-- 3. population table
CREATE TABLE population (
    countripopulationes VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;   

-- 5. gdp table
CREATE TABLE gdp (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM COUNTRY;
SELECT * FROM EMISSION;
SELECT * FROM POPULATION;
SELECT * FROM PRODUCTION;   
SELECT * FROM GDP;
SELECT * FROM CONSUMPTION;