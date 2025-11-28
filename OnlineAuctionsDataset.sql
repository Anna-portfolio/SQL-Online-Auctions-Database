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
 

-- Drop tables if they exist
DROP TABLE IF EXISTS SupplierLog;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS ContactDetails;
DROP TABLE IF EXISTS Users;


-- Create tables
-- Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    CONSTRAINT CHK_BirthDate CHECK (BirthDate >= '1900-01-01')
);

-- ContactDetails table
CREATE TABLE ContactDetails (
    AddressID INT PRIMARY KEY,
    UserID INT NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Country VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Contact_User FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY CHECK (OrderID > 0),
    UserID INT NOT NULL,
    OrderDate DATE NOT NULL,
    DeliveryDate DATE NOT NULL,
    AddressID INT NOT NULL,
    Total DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT FK_Orders_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Orders_Address FOREIGN KEY (AddressID) REFERENCES ContactDetails(AddressID)
);

-- Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50) NOT NULL,
    SupplierPhone VARCHAR(15) NOT NULL,
    CONSTRAINT CHK_PhoneLength CHECK (LEN(SupplierPhone) >= 9)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    SupplierID INT NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    ProductPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Products_Supplier FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Insert Data

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
(1009, 'Monica', 'Patel', '1995-02-25');

INSERT INTO ContactDetails VALUES
(124, 1000, '957 Turkey Pen Road, Brooklyn, NE 688471', 'USA'),
(231, 1001, 'Apt. 855 84625 Randal Drive, Lake Antony, AL 26879', 'Canada'),
(123, 1002, 'Apt. 448 743 McLaughlin Radial, North Jeffreyville, ME 01326-5074', 'USA'),
(452, 1003, 'Apt. 337 Am Frankenberg 13b, Jamalheim, BB 61162', 'Germany'),
(795, 1004, '532 Sieradz Street, Lwowek, PK 40-733', 'Poland'),
(465, 1005, '38761 Brock Stream, Port Vertieville, WY 84100-8795', 'Canada'),
(345, 1006, '336 Genouville Road, 10803 Avignon', 'France'),
(435, 1007, 'Apt. 848 Quartz St. 1, Schon Wibke, SN 39347', 'Germany'),
(566, 1008, '22528 Edelmira Groves, Thompsonmouth, DE 24118', 'USA'),
(165, 1009, '30633 Mroczkowska St, Osiek, LS 88-588', 'Poland');

INSERT INTO Orders VALUES
(70000, 1003, '2024-01-23', '2024-01-25', 452, 100),
(70001, 1000, '2024-01-23', '2024-01-25', 124, 50),
(70002, 1008, '2024-01-24', '2024-01-26', 566, 75),
(70003, 1006, '2024-01-24', '2024-01-26', 345, 30),
(70004, 1002, '2024-01-25', '2024-01-27', 123, 45),
(70005, 1005, '2024-01-25', '2024-01-27', 465, 80),
(70006, 1009, '2024-01-26', '2024-01-28', 165, 25);

INSERT INTO Suppliers VALUES
(1, 'Lingerie GmbH', '776885490'),
(2, 'Mahtava Ltd.', '765893445'),
(3, 'RTE Delivery Co.', '985431542');

INSERT INTO Products VALUES
(10012, 1, 'Putruanides T-Shirt', 20),
(10032, 2, 'Suxeria Dinner Jacket', 100),
(10050, 1, 'Cummerbund Bow Tie', 20),
(10051, 2, 'Nellillon Poncho', 55),
(10053, 3, 'Driri Cravat', 43),
(10055, 3, 'Vuaria Socks', 12),
(10056, 1, 'Sodazuno Polo Shirt', 34),
(10084, 2, 'Voria Stockings', 12),
(10122, 1, 'Llamopra Pajamas', 45),
(10131, 2, 'Xiter Robe', 12),
(10161, 3, 'Gonara Boots', 50),
(10222, 2, 'Zucreon Shoes', 35),
(10444, 3, 'Mubbuhiri Jeans', 25),
(10476, 2, 'Gonara Scarf', 15),
(10632, 1, 'Vithozuno Waistcoat', 10),
(10689, 2, 'Oclite Knickers', 25),
(10690, 3, 'Luccarvis Fleece', 20),
(10775, 1, 'Ziborilia Blouse', 15);

-- Views

-- Clients Details View
CREATE VIEW ClientDetails AS
SELECT U.UserID, U.FirstName, U.LastName, CD.Address, CD.Country
FROM Users U
LEFT JOIN ContactDetails CD ON U.UserID = CD.UserID
WHERE U.UserID >= 1003
ORDER BY U.LastName;

-- Orders Value per Country
CREATE VIEW OrdersValuePerCountry AS
SELECT CD.Country, SUM(O.Total) AS TotalValue
FROM ContactDetails CD
JOIN Orders O ON CD.AddressID = O.AddressID
GROUP BY CD.Country;

-- Orders in January 2024
CREATE VIEW OrdersJan2024 AS
SELECT COUNT(OrderID) AS OrdersCount
FROM Orders
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-01-31';

-- Average Price per Supplier
CREATE VIEW AvgPricePerSupplier AS
SELECT S.SupplierName, AVG(P.ProductPrice) AS AvgPrice
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
GROUP BY S.SupplierName
ORDER BY S.SupplierName DESC;

-- Lowest Priced Products with space in name
CREATE VIEW LowestPriceProduct AS
SELECT S.SupplierName, MIN(P.ProductPrice) AS LowestPrice
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE P.ProductName LIKE '% %'
GROUP BY S.SupplierName
ORDER BY S.SupplierName DESC;

-- Functions

-- Users with ID greater than parameter
CREATE FUNCTION GetUsersAboveID(@UserID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT UserID, FirstName, LastName
    FROM Users
    WHERE UserID > @UserID
);

-- Products containing a string in the name
CREATE FUNCTION GetProductsByName(@Name NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT ProductID, ProductName, SupplierID
    FROM Products
    WHERE ProductName LIKE @Name
);

-- Procedures

-- Add user procedure
CREATE PROCEDURE AddUser
    @UserID INT,
    @FirstName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @BirthDate DATE
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        INSERT INTO Users(UserID, FirstName, LastName, BirthDate)
        VALUES (@UserID, @FirstName, @LastName, @BirthDate);
    END
END;

-- Change product price procedure
CREATE PROCEDURE ChangeProductPrice
    @ProductID INT,
    @PriceChange DECIMAL(10,2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        UPDATE Products
        SET ProductPrice = ProductPrice + @PriceChange
        WHERE ProductID = @ProductID;
    END
END;

-- Trigger

CREATE TABLE SupplierLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    LogDate DATETIME,
    Notes NVARCHAR(50)
);

CREATE TRIGGER trgAfterSupplierUpdate
ON Suppliers
AFTER UPDATE
AS
BEGIN
    INSERT INTO SupplierLog(LogDate, Notes)
    VALUES (GETDATE(), 'Supplier record updated');
END;
