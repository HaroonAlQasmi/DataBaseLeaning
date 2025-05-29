CREATE DATABASE SecurityLevelTaskDB

USE SecurityLevelTaskDB

-- Schema Creation
CREATE SCHEMA HR
CREATE SCHEMA Sales
-- HR schema tables
CREATE TABLE HR.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    HireDate DATE
);

CREATE TABLE HR.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);

-- Sales schema tables
CREATE TABLE Sales.Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100)
);

CREATE TABLE Sales.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Sales.Customers(CustomerID)
);

-- Insert Dummy Data into HR Tables
INSERT INTO HR.Departments (DepartmentID, DepartmentName)
VALUES 
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT Support');

INSERT INTO HR.Employees (EmployeeID, FirstName, LastName, HireDate)
VALUES 
(101, 'Alice', 'Johnson', '2018-06-12'),
(102, 'Bob', 'Smith', '2020-03-01'),
(103, 'Carol', 'White', '2019-09-23');

-- Insert Dummy Data into Sales Tables
INSERT INTO Sales.Customers (CustomerID, Name, Email)
VALUES 
(201, 'John Doe', 'john.doe@example.com'),
(202, 'Jane Smith', 'jane.smith@example.com'),
(203, 'David Brown', 'david.brown@example.com');

INSERT INTO Sales.Orders (OrderID, CustomerID, OrderDate)
VALUES 
(301, 201, '2024-12-01'),
(302, 202, '2025-01-15'),
(303, 203, '2025-03-22'),
(304, 201, '2025-05-10');

