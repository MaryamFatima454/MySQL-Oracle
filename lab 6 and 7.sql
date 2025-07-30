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

----------------------------------------------------------LAB 6-------------------------------------------------------------
--------------ACTIVITIES------------

SELECT AirportCode, AirportName, City_, State_, CountryName, Continent
FROM Airport_ NATURAL JOIN Country_;

SELECT AirportCode, AirportName, City_, State_, CountryName, Continent
FROM Airport_ NATURAL JOIN Country_
WHERE Continent = 'Asia';

SELECT RouteID, Destination, TakeoffPoint, RouteType, PlaneID, Model_, Company
FROM Route_ JOIN Planee__ USING (PlaneID);

SELECT RouteID, Destination, TakeoffPoint, City_ AS Location, PlaneID, Model_, Company
FROM Route_ 
JOIN Planee__ USING (PlaneID)
JOIN Airport_ USING (AirportCode);

SELECT a.City_, c.CountryName 
FROM Airport_ a 
JOIN Country_ c USING (CountryCode)
WHERE CountryCode = 'PAK';

SELECT a.AirportName, a.City_, c.CountryName
FROM Airport_ a 
JOIN Country_ c 
ON a.CountryCode = c.CountryCode;

SELECT r.RouteID, r.Destination, a.AirportName
FROM Route_ r
JOIN Planee__ p ON r.PlaneID = p.PlaneID
JOIN Airport_ a ON p.AirportCode = a.AirportCode;

SELECT r.RouteID, a.City_, a.AirportName
FROM Route_ r
JOIN Planee__ p USING (PlaneID)
JOIN Airport_ a USING (AirportCode);

SELECT p.PlaneID, p.Company, p.Model_, p.AirportCode, a.City_
FROM Planee__ p
JOIN Airport_ a ON p.AirportCode = a.AirportCode
WHERE a.NumberOfTerminals > 3;

SELECT a1.AirportName AS Airport1, a1.City_ AS City1, 
       a2.AirportName AS Airport2, a2.City_ AS City2, 
       a1.NumberOfTerminals
FROM Airport_ a1
JOIN Airport_ a2 
ON a1.NumberOfTerminals = a2.NumberOfTerminals
WHERE a1.AirportCode <> a2.AirportCode;

SELECT r1.PlaneID, r1.Distance, r2.Distance
FROM Route_ r1 JOIN Route_ r2
ON r1.Distance BETWEEN r2.Distance AND (r2.Distance + 1000);

SELECT p.PlaneID, p.Company, a.AirportName 
FROM Planee__ p LEFT OUTER JOIN Airport_ a
ON p.AirportCode = a.AirportCode;

SELECT p.PlaneID, p.Company, a.AirportName 
FROM Planee__ p RIGHT OUTER JOIN Airport_ a
ON p.AirportCode = a.AirportCode;

SELECT p.PlaneID, p.Company, a.AirportName 
FROM Planee__ p FULL OUTER JOIN Airport_ a
ON p.AirportCode = a.AirportCode;

SELECT p.PlaneID, r.RouteID 
FROM Planee__ p CROSS JOIN Route_ r;

----TASK---

SELECT a.AirportCode, a.AirportName, a.City_, a.State_, c.CountryName
FROM Airport_ a
NATURAL JOIN Country_ c;

SELECT p.PlaneID, p.Company, a.AirportName
FROM Planee__ p
JOIN Airport_ a ON p.AirportCode = a.AirportCode;

SELECT p.PlaneID, a.AirportName, c.Continent
FROM Planee__ p
JOIN Airport_ a ON p.AirportCode = a.AirportCode
JOIN Country_ c ON a.CountryCode = c.CountryCode
WHERE c.Continent = 'Africa' ;

SELECT p.PlaneID, a.AirportName, 'Manager Name', a.City_
FROM Planee__ p
JOIN Airport_ a ON p.AirportCode = a.AirportCode;

SELECT  PlaneID,  Company,  Model_,  Capacity_,  AirportName, City_, CountryName, EstablishedYear
FROM  Planee__ p
JOIN  Airport_ a ON p.AirportCode = a.AirportCode
JOIN  Country_ c ON a.CountryCode = c.CountryCode

SELECT p.PlaneID, p.Company, a.AirportCode, a.AirportName
FROM Planee__ p
JOIN Airport_ a ON p.AirportCode = a.AirportCode
WHERE a.City_ = 'Toronto';

-----------------------------------------------------------LAB 7---------------------------------------------------------
---------ACTIVITIES---------
SELECT AirportName, City_
FROM Airport_
WHERE CountryCode = 
    (SELECT CountryCode 
     FROM Country_
     WHERE CountryName = 'Saudi Arabia');

SELECT PlaneID, Company, Capacity_ 
FROM Planee__
WHERE Company = (SELECT Company FROM Planee__ WHERE PlaneID = 'PL102')
AND Capacity_ > (SELECT Capacity_ FROM Planee__ WHERE PlaneID < 'PL102');

SELECT AirportName, City_, NumberOfTerminals
FROM Airport_
WHERE NumberOfTerminals = 
    (SELECT MAX(NumberOfTerminals) FROM Airport_);

SELECT AirportCode, AirportName, NumberOfTerminals
FROM Airport_
GROUP BY AirportCode, AirportName, NumberOfTerminals
HAVING NumberOfTerminals > 
    (SELECT NumberOfTerminals FROM Airport_ WHERE AirportCode = 'KHI');

SELECT CountryName, Population
FROM Country_
WHERE Population > 
    (SELECT MIN(Population)  FROM Country_);

SELECT CountryName
FROM Country_
WHERE CountryCode = 
    (SELECT CountryCode
     FROM Country_
     WHERE CountryCode = 'XYZ');

SELECT AirportName, City_, NumberOfTerminals
FROM Airport_
WHERE NumberOfTerminals > ANY
    (SELECT NumberOfTerminals
     FROM Airport_
     WHERE CountryCode = 'SAU');

SELECT AirportName, City_, NumberOfTerminals
FROM Airport_
WHERE NumberOfTerminals < ALL
    (SELECT NumberOfTerminals
     FROM Airport_
     WHERE CountryCode = 'EGY');

SELECT AirportName, City_
FROM Airport_ A
WHERE EXISTS
    (SELECT PlaneID
     FROM Planee__
     WHERE AirportCode = A.AirportCode);

SELECT CountryName
FROM Country_
WHERE CountryCode NOT IN
    (SELECT DISTINCT CountryCode
     FROM Airport_);
     
------TASK------

SELECT AirportName, EstablishedYear
FROM Airport_
WHERE CountryCode = (SELECT CountryCode
                      FROM Country_
                      WHERE CountryName = 'Saudi Arabia')
AND AirportName = 'King Abdulaziz Intl';

SELECT PlaneID, Model_, Capacity_
FROM Planee__
WHERE Capacity_ > (SELECT AVG(Capacity_)
                    FROM Planee__);

SELECT AirportName, City_
FROM Airport_
WHERE CountryCode IN (SELECT CountryCode FROM Country_ WHERE Population > 200000000);

SELECT *
FROM Country_
WHERE Population >= 200000000;

SELECT AirportName, City_, CountryCode
FROM Airport_
WHERE CountryCode IN (SELECT CountryCode FROM Country_ WHERE OfficialLanguage = 'Arabic');

SELECT AirportName, EstablishedYear
FROM Airport_
WHERE CountryCode = (SELECT CountryCode FROM Airport_ WHERE AirportCode = 'KHI');
