--SQL-ONLINE-AUCTIONS-DATASET
-- created by @Anna-portfolio --https://github.com/Anna-portfolio 
--Full project in T-SQL of online auctions database, including: creating dataset, tables, constraints, foreign keys, views, functions, procedures, and triggers

--DESCRIPTION
--The following database is designed for collecting and processing information for online auctions. The database is called “Auctions” and consists of the following tables: 
--Users – users of the online actions 
--ContactDetails – data of users of the online actions 
--Orders - details of the orders placed by the users
--Products – details of products available in the online actions  
--Suppliers - details of suppliers supplying the products available in the online actions  

--Additional description of the tables can be found in the SQL comments. 

--CONTENT OVERVIEW
--The project includes: 
--creating tables and inserting values into them,
--constraints,
--foreign keys,
--views,
--functions,
--procedures,
--triggers
 



--CREATE TABLES 

-- TABLE: Users 
-- Create the Users table, containing the columns: UserID, FirstName, LastName, BirthDate 

 

CREATE TABLE Users ( 

UserID INT PRIMARY KEY, 

FirstName VARCHAR(20) NOT NULL, 

LastName VARCHAR(20) NOT NULL, 

BirthDate DATE 

) 

 

-- TABLE: ContactDetails 

--Create the ContactDetails table, containing the columns: UserID, AddressID, Address, Country 

CREATE TABLE ContactDetails ( 

UserID INT, 

AddressID INT NOT NULL PRIMARY KEY, 

Address VARCHAR(100) NOT NULL, 

Country VARCHAR(30) NOT NULL 

) 

 

-- TABLE: Orders 

--Create the Orders table, containing the columns: UserID, OrderID, OrderDate, DeliveryDate, AddressID 

CREATE TABLE Orders ( 

UserID INT, 

OrderID INT PRIMARY KEY, 

OrderDate DATE NOT NULL, 

DeliveryDate DATE NOT NULL, 

AddressID INT NOT NULL UNIQUE 

) 

 

-- TABLE: Products 

--Create the Products table, containing the columns: ProductID, SupplierID, ProductName, ProductPrice 

CREATE TABLE Products ( 

ProductID INT UNIQUE, 

SupplierID INT, 

ProductName VARCHAR(50) NOT NULL, 

ProductPrice INT NOT NULL 

) 

-- TABLE: Suppliers 

--Create the Suppliers table, containing the columns: SupplierID, SupplierName, SupplierPhone 

CREATE TABLE Suppliers ( 

SupplierID INT UNIQUE, 

SupplierName VARCHAR(50), 

SupplierPhone INT 

) 

 
 

-- CONSTRAINTS 

-- Add a constraint to the User table: the dates in the BirthDate column have to be higher or equal than 1900 

ALTER TABLE Users 

ADD CONSTRAINT c1 CHECK (BirthDate >= '1900-01-01') 

-- Add a constraint to the Order table: the values in the OrderID column have to be higher than zero  

ALTER TABLE Orders 

ADD CONSTRAINT c2 CHECK (OrderID > 0) 

-- Add a constraint to the Suppliers table: the values in the SupplierPhone table have to consist of at least 9 digits 

ALTER TABLE Suppliers 

ADD CONSTRAINT c3 CHECK (LEN(SupplierPhone) >= 9) 

 


--FOREIGN KEYS 

--Add a foreign key to the ContactDetails 

ALTER TABLE ContactDetails 

ADD FOREIGN KEY (UserID) REFERENCES Users(UserID) 

--Add a foreign key to the ContactDetails 

ALTER TABLE ContactDetails 

ADD FOREIGN KEY (AddressID) REFERENCES Orders(AddressID) 

--Add a foreign key to the Order table 

ADD FOREIGN KEY (UserID) REFERENCES Users(UserID) 

--Add a foreign key to the Suppliers table 

ALTER TABLE Suppliers 

ADD FOREIGN KEY (SupplierID) REFERENCES Product(SupplierID) 

 

 

--INSERT VALUES INTO THE TABLES 

INSERT INTO Users VALUES 

(1000, 'John', 'Doe', '1970-01-02'), 

(1001, 'Daisy', 'Smith', '1980-05-10'), 

(1002, 'Lewis', 'Kennedy', '1962-01-10'), 

(1003, 'Tomos', 'Holland', '1991-12-01'), 

(1004, 'Gabriella', 'Watts', '1981-11-01'), 

(1005, 'Rosa', 'Mcgee', '1960-11-12'), 

(1006, 'David', 'Wright', '1951-11-20'), 

(1007, 'Ana', 'Cooper', '1971-03-20'), 

(1008, 'Terry', 'Robertson', '1976-02-20'), 

(1009, 'Monica', 'Patel', '1995-02-25') 

 


INSERT INTO ContactDetails VALUES 

(1000, 124, '957 Turkey Pen Road, Brooklyn Nebraska (NE), 688471', 'USA'), 

(1001, 231, 'Apt. 855 84625 Randal Drive, Lake Antony, AL 26879', 'Canada'), 

(1002, 123, 'Apt. 448 743 McLaughlin Radial, North Jeffreyville, ME 01326-5074', 'USA'), 

(1003, 452, 'Apt. 337 Am Frankenberg 13b, Jamalheim, BB 61162', 'Germany'), 

(1004, 795, 'ul. Sieradzka 532, Lwówek, PK 40-733', 'Poland'), 

(1005, 465, '38761 Brock Stream, Port Vertieville, WY 84100-8795', 'Canada'), 

(1006, 345, '336 Côte Genouville, 10803 Avignon', 'France'), 

(1007, 435, 'Apt. 848 Quarzstr. 1, Schön Wibke, SN 39347', 'Germany'), 

(1008, 566, '22528 Edelmira Groves, Thompsonmouth, DE 24118', 'USA'), 

(1009, 165, 'ul. Mroczkowska 30633, Osiek, LS 88-588', 'Poland') 

 


INSERT INTO Orders VALUES 

(1003, 70000, 12, '2024-01-23', '2024-01-25', 452), 

(1000, 70001, 387, '2024-01-23', '2024-01-25', 124), 

(1008, 70002, 1005, '2024-01-24', '2024-01-26', 566), 

(1006, 70003, 5045, '2024-01-24', '2024-01-26', 345), 

(1002, 70004, 23, '2024-01-25', '2024-01-27', 123), 

(1005, 70005, 122, '2024-01-25', '2024-01-27', 465), 

(1009, 70006, 5445, '2024-01-26', '2024-01-28', 165) 

 


INSERT INTO Products VALUES 

(10012, 01, 'Putruanides T-Shirt', 20), 

(10032, 02, 'Suxeria Dinner Jacket', 100), 

(10050, 01, 'Cummerbund Bow Tie', 20), 

(10051, 02, 'Nellillon Poncho', 55), 

(10053, 03, 'Driri Cravat', 43), 

(10055, 03, 'Vuaria Socks', 12), 

(10056, 01, 'Sodazuno Polo Shirt', 34), 

(10084, 02, 'Voria Stockings', 12), 

(10122, 01, 'Llamopra Pajamas', 45), 

(10131, 02, 'Xiter Robe', 12), 

(10161, 03, 'Gonara Boots', 50), 

(10222, 02, 'Zucreon Shoes', 35), 

(10444, 03, 'Mubbuhiri Jeans', 25), 

(10476, 02, 'Gonara Scarf', 15), 

(10632, 01, 'Vithozuno Waistcoat', 10), 

(10689, 02, 'Oclite Knickers', 25), 

(10690, 03, 'Luccarvis Fleece', 20), 

(10775, 01, 'Ziborilia Blouse', 15) 

 


INSERT INTO Suppliers VALUES 

(01, 'Lingerie GmbH', 776885490), 

(02, 'Mahtava Ltd.', 765893445), 

(03, 'RTE Delivery Co.', 985431542) 

 

--VIEWS 

--VIEW [Clients Details]  
-- List records of all the clients, providing their: ID Number, fist name, last name, address, and country (incl. joining the User and ContactDetails tables by using JOIN; adding aliases for the tables; sorting alphabetically by user's last name).  

CREATE VIEW [Clients Details] AS 

SELECT U.UserID, U.FirstName, U.LastName, CD.Address, CD.Country 

FROM Users AS U 

LEFT JOIN ContactDetails AS CD 

ON U.UserID = CD.UserID 

WHERE U.UserID >= 1003 

ORDER BY U.LastName 

--Query view 

SELECT * FROM [Clients Details]; 

 


--VIEW [Orders Value per Country] 
-- Sum up the total orders values for each of the countries (incl. using the SUM() aggregate function for the order values; joining the Order and ContactDetails tables; adding aliases for the column using aggregate function and for the tables; sorting alphabetically by country name) 

CREATE VIEW [Orders Value per Country] AS 

SELECT SUM(O.Total) AS TotalCountry, CD.Country 

FROM ContactDetails AS CD 

LEFT JOIN Orders AS O 

ON CD.UserID = O.UserID 

GROUP BY CD.Country 

 
--Query view 
SELECT * FROM [Orders Value per Country]; 

 

 

--VIEW [Orders Jan2024]
-- Count records for the orders placed in January, 2024 (incl. using the COUNT() aggregate function) 

CREATE VIEW [Orders Jan2024] AS 

SELECT COUNT(OrderID) AS OrdersJan2024 

FROM Orders 

WHERE OrderDate BETWEEN '2024-01-01' AND '2024-01-31' 

SELECT * FROM [Orders Jan2024]; 

 

--VIEW [Avg Price per Supplier]
-- Calculate the average price of the products per supplier (incl. using the AVG() aggregate function; joining the Product and Suppliers tables by means of INNER JOIN;  
--adding aliases for the column using aggregate function and for the tables; sorting alphabetically by supplier name, reversed order) 
 

CREATE VIEW [Avg Price per Supplier] AS 

SELECT AVG(P. ProductPrice) AS AvgPricePerSupplier, D.SupplierName 

FROM Product AS P 

INNER JOIN Suppliers AS S 

ON P.SupplierID = S.SupplierID 

GROUP BY S.SupplierName 

 
--Query view 
SELECT * FROM [Avg Price per Supplier]; 

 

--VIEW [Lowest Price Product]
-- Choose the product with the lowest price (which additionally includes at least one space in its name), along with its supplier's name (incl. using the MIN() aggregate function; joining the Product and Suppliers tables by means of LEFT JOIN; adding aliases for the column using aggregate function and for the tables; sorting alphabetically by supplier name, reversed order) 
CREATE VIEW [Lowest Price Product] AS 

SELECT MIN(P.ProductPrice) AS ProductLowestPrice, S.SupplierName 

FROM Products AS P 

LEFT JOIN Suppliers AS S 

ON P.SupplierID = S.SupplierID 

WHERE P.ProductName LIKE '% %' 

GROUP BY S.SupplierName 

SELECT * FROM [Lowest Price Product] 

 

-- FUNCTION UserData 
-- Function which returns those users from the Users table (the columns of UserID, FirstName, LastName), whose ID is higher than ID provided as the parameter (@UserID).  

CREATE FUNCTION UserData (@UserID INT)  

RETURNS TABLE  

AS  

RETURN  

(  

SELECT UserID, FirstName, LastName  

FROM Users 

WHERE UserID > @UserID  

)  

GO  


--Call the function  

SELECT * FROM UserData (1005)  



-- FUNCTION ProductNameRange 
-- Function which returns those products from the Products table (the columns of ProductID, ProductName, SupplierID), including in their names the chain provided as the parameter (@Name).  

CREATE FUNCTION ProductNameRange (@Name NVARCHAR(50))  

RETURNS TABLE  

AS  

RETURN  

(  

SELECT ProductID, ProductName, SupplierID  

FROM Products  

WHERE ProductName LIKE @Name  

)  

GO  

 

--Call the function  

SELECT * FROM ProductNameRange ('p%')  



-- STORED PROCEDURE AddUserRecord
-- Procedure which adds a record into the Users table (UserID, FirstName, LastName, BirthDate). The procedurê also checks if the user with the same ID number does not already exist in the table (by using the parameter of @vUserID). 

CREATE PROCEDURE AddUserRecord (  

@vUserID INT,  

@vName NVARCHAR(20),  

@vSurname NVARCHAR(20),  

@vBirthdate DATE  

) AS  

BEGIN  

IF (NOT EXISTS (  

SELECT *  

FROM Users AS U  

WHERE U.UserID = @vUserID  

))  

INSERT INTO Users VALUES (  

@vUserID,  

@vName,  

@vSurname,  

@vBirthdate  

)  

END  

GO  


-- Execute the procedure 

EXECUTE AddUserRecord '1010', 'Michael', 'Smith', '1970-01-01'  

 

 

-- STORED PROCEDURE PriceChange 
-- Procedure which changes the product's unit price under specified ID (@vProductID) by the value provided as the parameter (@vUnitPriceChange). The procedurê also checks if the product with the same ID number does not already exist in the table (by using the parameter of @vProductID).  


CREATE PROCEDURE PriceChange @vProductID INT, @ vUnitPriceChange INT  

AS  

BEGIN  

IF (EXISTS (  

SELECT P.ProductID, P.ProductPrice  

FROM Products P  

WHERE P.ProductID = @vProductID))  

UPDATE Products SET ProductPrice = ProductPrice + @ vUnitPriceChange 

SELECT * FROM Products AS P  

WHERE P.ProductID = @vProductID;  

END;   

GO  

SELECT * FROM Products 

EXECUTE PriceChange 1, 10  

-- TRIGGER trgAfterSuppliersUpdate  
-- Create the Supplierlog table and trigger which adds record into the Supplierlog table each time the Suppliers table is updated 

CREATE TABLE Supplierlog  

(  

ID INT IDENTITY(1,1) PRIMARY KEY,  

Date DATETIME,  

Notes NVARCHAR(50)  

)  

GO  

CREATE TRIGGER trgAfterSuppliersUpdate  

ON Suppliers  

AFTER UPDATE  

AS  

BEGIN  

INSERT INTO Supplierlog (Date, Notes)  

VALUES (GETDATE(),'Record updated')  

END;  

GO 
