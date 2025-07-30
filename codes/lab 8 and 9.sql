CREATE TABLE Country_ (
    CountryCode CHAR(3) PRIMARY KEY,
    CountryName VARCHAR(50),
    Continent VARCHAR(30),
    Population NUMBER(15),
    OfficialLanguage VARCHAR(30)
);

INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('SAU', 'Saudi Arabia', 'Asia', 35000000, 'Arabic');

INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('PAK', 'Pakistan', 'Asia', 231403000, 'Urdu');

INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('IDN', 'Indonesia', 'Asia', 277000000, 'Indonesian');

INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('EGY', 'Egypt', 'Africa', 104000000, 'Arabic');

CREATE TABLE Airport_ (
    AirportCode VARCHAR(10) PRIMARY KEY,
    AirportName VARCHAR(50),
    City_ VARCHAR(30),
    State_ VARCHAR(30),
    CountryCode CHAR(3),
    NumberOfTerminals NUMBER(2),
    EstablishedYear NUMBER(4),
    FOREIGN KEY (CountryCode) REFERENCES Country_(CountryCode)
);

INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('JED', 'King Abdulaziz Intl', 'Jeddah', 'Makkah', 'SAU', 3, 1981);

INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('KHI', 'Jinnah Intl', 'Karachi', 'Sindh', 'PAK', 3, 1929);

INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('CGK', 'Soekarno-Hatta Intl', 'Jakarta', 'Java', 'IDN', 3, 1985);

INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('CAI', 'Cairo Intl', 'Cairo', 'Cairo', 'EGY', 4, 1963);

CREATE TABLE Planee__ (
    PlaneID VARCHAR(10) PRIMARY KEY,
    Capacity_ NUMBER(4),
    Weight FLOAT(10),
    Company VARCHAR(50),
    Model_ VARCHAR(30),
    ManufactureYear NUMBER(4),
    AirportCode VARCHAR(10),
    FOREIGN KEY (AirportCode) REFERENCES Airport_(AirportCode)
);

INSERT INTO Planee__ (PlaneID, Capacity_, Weight, Company, Model_, ManufactureYear, AirportCode)
VALUES ('PL101', 200, 50000.00, 'Boeing', '737 MAX', 2020, 'JED');

INSERT INTO Planee__ (PlaneID, Capacity_, Weight, Company, Model_, ManufactureYear, AirportCode)
VALUES ('PL102', 250, 70000.00, 'Airbus', 'A320 Neo', 2019, 'KHI');

INSERT INTO Planee__ (PlaneID, Capacity_, Weight, Company, Model_, ManufactureYear, AirportCode)
VALUES ('PL103', 300, 80000.00, 'Boeing', '787 Dreamliner', 2021, 'CGK');

INSERT INTO Planee__ (PlaneID, Capacity_, Weight, Company, Model_, ManufactureYear, AirportCode)
VALUES ('PL104', 180, 55000.00, 'Airbus', 'A330', 2018, 'CAI');

CREATE TABLE Route_ (
    RouteID VARCHAR(10) PRIMARY KEY,
    Destination VARCHAR(50),
    TakeoffPoint VARCHAR(50),
    RouteType VARCHAR(20),
    Distance NUMBER(8, 2),
    PlaneID VARCHAR(10),
    FOREIGN KEY (PlaneID) REFERENCES Planee__(PlaneID)
);
INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT101', 'Medina', 'Jeddah', 'Domestic', 420.50, 'PL101');

INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT102', 'Lahore', 'Karachi', 'Domestic', 1020.75, 'PL102');

INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT103', 'Surabaya', 'Jakarta', 'Domestic', 760.25, 'PL103');

INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT104', 'Alexandria', 'Cairo', 'Domestic', 220.60, 'PL104');

select * from Country_
select * from Airport_
select * from Planee__
select * from Route_

-----------------------------------------------------------LAB 8----------------------------------------------------
------------Activity 1-------------
SELECT RouteType AS Type, PlaneID FROM Route_
UNION
SELECT DISTINCT 'Plane' AS Type, Company FROM Planee__;

------------Activity 2-------------
SELECT AirportCode, City_ AS Location FROM Airport_
UNION ALL
SELECT AirportCode, Model_ AS Location FROM Planee__
ORDER BY AirportCode;

------------Activty 3--------------
SELECT PlaneID FROM Planee__
INTERSECT
SELECT PlaneID FROM Route_;

------------Activity 4-------------
SELECT AirportCode FROM Airport_
MINUS
SELECT DISTINCT AirportCode FROM Planee__;

------------Activity 5-------------
SELECT CountryCode, CountryName, TO_CHAR(NULL) AS AirportName
FROM Country_
UNION
SELECT CountryCode, TO_CHAR(NULL) AS CountryName, AirportName
FROM Airport_;

-----------Activity 6-------------
SELECT TO_CHAR(RouteID) AS RouteID,
RouteType,
TO_CHAR(NULL) AS Capacity_
FROM Route_
UNION
SELECT TO_CHAR(NULL) AS RouteID,
Model_ AS RouteType,
TO_CHAR(Capacity_) AS Capacity_
FROM Planee__
ORDER BY 2;

-------------LAB TASK 1-----------
SELECT C.CountryCode, C.CountryName FROM Country_ C
MINUS
SELECT DISTINCT C.CountryCode, C.CountryName FROM Country_ C
JOIN Airport_ A ON C.CountryCode > A.CountryCode;

--------------LAB TASK 2-------------
SELECT AirportCode FROM Airport_
MINUS
SELECT DISTINCT AirportCode FROM Planee__;

-------------LAB TASK 3-------------
SELECT P.PlaneID, P.Model_ FROM Planee__ P
JOIN Airport_ A ON P.AirportCode = A.AirportCode
JOIN Country_ C ON A.CountryCode = C.CountryCode
WHERE C.Continent = 'Asia';

-------------LAB TASK 4-------------
SELECT AirportCode FROM Airport_
MINUS
SELECT DISTINCT A.AirportCode FROM Airport_ A
JOIN Planee__ P ON A.AirportCode > P.AirportCode
JOIN Route_ R ON P.PlaneID > R.PlaneID;

-------------LAB TASK 5------------
SELECT RouteID FROM Route_
WHERE TakeoffPoint IN ('Jeddah', 'Karachi', 'Jakarta');

------------LAB TASK 6--------------
SELECT PlaneID FROM Planee__
MINUS
SELECT DISTINCT PlaneID FROM Route_;

-----------------------------------------------------------LAB 9--------------------------------------------------------------------------
-------------Activity 1-------------
-- Inserting a new country into the Country_ table
INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('USA', 'United States', 'North America', 331002651, 'English');

-------------Activity 2-------------
-- Inserting a row into the Airport_ table, leaving the State_ column null
INSERT INTO Airport_ (AirportCode, AirportName, City_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('ATL', 'Hartsfield–Jackson Atlanta International Airport', 'Atlanta', 'USA', 2, 1925);

-- Inserting a row into the Planee__ table with a NULL value for the Manufacturer Year
INSERT INTO Planee__ (PlaneID, Capacity_, Weight, Company, Model_, ManufactureYear, AirportCode)
VALUES ('PL105', 250, 70000.00, 'Airbus', 'A380', NULL, 'ATL');

-------------Activity 3-------------
-- Inserting a record into the Route_ table using the SYSDATE function for the Date
INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT105', 'New York', 'Atlanta', 'International', 6500.75, 'PL105');

-- Inserting a record using the USER function for a created user
INSERT INTO Route_ (RouteID, Destination, TakeoffPoint, RouteType, Distance, PlaneID)
VALUES ('RT106', 'London', 'Atlanta', 'International', 7600.50, 'PL105');

-------------Activity 4-------------
-- Inserting a record with a specific date value for the EstablishedYear column in the Airport_ table
INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('SFO', 'San Francisco International Airport', 'San Francisco', 'California', 'USA', 4, TO_DATE('01-JAN-1930', 'DD-MON-YYYY'));

-------------Activity 5-------------
-- Create a script to insert an airport with substitution variables
INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('&AirportCode', '&AirportName', '&City_', '&State_', '&CountryCode', &NumberOfTerminals, &EstablishedYear);

-------------Activity 6-------------
-- Assuming airport_copy has the same structure as the Airport_ table
INSERT INTO airport_copy (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
SELECT AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear
FROM Airport_;

-------------Activity 7-------------
UPDATE Country_
SET Population = 36000000
WHERE CountryCode = 'SAU';

UPDATE Airport_
SET NumberOfTerminals = 4
WHERE AirportCode = 'KHI';

-------------Activity 8-------------
UPDATE Planee__
SET (Capacity_, Weight) = (SELECT Capacity_, Weight FROM Planee__ WHERE PlaneID = 'PL103')
WHERE PlaneID = 'PL102';

-------------Activity 9-------------
UPDATE Airport_
SET State_ = (SELECT State_ FROM Airport_ WHERE AirportCode = 'JED')
WHERE AirportCode = 'KHI';

-------------Activity 10-------------
DELETE FROM Airport_
WHERE AirportCode = 'CGK';

DELETE FROM Airport_;

-------------Activity 11-------------
DELETE FROM Route_
WHERE PlaneID IN (
    SELECT PlaneID FROM Planee__
);

-------------Activity 12-------------
TRUNCATE TABLE Route_;

-----------LAB TASK 1------------
UPDATE Country_
SET Population = Population * 1.05
WHERE Continent = 'Asia';

-----------LAB TASK 2------------
INSERT INTO Airport_ (AirportCode, AirportName, City_, State_, CountryCode, NumberOfTerminals, EstablishedYear)
VALUES ('MYR', 'Maryam Airport', 'MyCity', 'MyState', 'SAU', 2, 2024);

-----------LAB TASK 3------------
INSERT INTO Country_ (CountryCode, CountryName, Continent, Population, OfficialLanguage)
VALUES ('AFR', 'Network Operations', 'Africa', 50000000, 'English');

-----------LAB TASK 4------------
UPDATE Airport_
SET City_ = 'London'
WHERE AirportName = 'King Abdulaziz Intl';

-----------LAB TASK 5------------
DELETE FROM Route_
WHERE PlaneID = 'PL101';

-----------LAB TASK 6------------
DELETE FROM Airport_
WHERE AirportCode = 'MYR';


