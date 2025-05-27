CREATE DATABASE Training_CertificationPlatform

USE Training_CertificationPlatform

-- Table creation
CREATE TABLE Employee ( 
    EmployeeID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Position VARCHAR(50), 
    HireDate DATE 
); 
 
CREATE TABLE Trainer ( 
    TrainerID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Specialization VARCHAR(100) 
); 
 
CREATE TABLE Attendance ( 
    AttendanceID INT PRIMARY KEY, 
    EmployeeID INT, 
    Date DATE, 
    Status VARCHAR(20) 
); 
CREATE TABLE Course ( 
    CourseID INT PRIMARY KEY, 
    CourseName VARCHAR(100), 
    DurationWeeks INT 
); 
 
CREATE TABLE Batch ( 
    BatchID INT PRIMARY KEY, 
    CourseID INT, 
    StartDate DATE, 
    EndDate DATE 
); 
 
 
CREATE TABLE Exam ( 
    ExamID INT PRIMARY KEY, 
    CourseID INT, 
    ExamDate DATE 
); 
 
CREATE TABLE Result ( 
    ResultID INT PRIMARY KEY, 
    ExamID INT, 
    EmployeeID INT, 
    Score INT 
); 
CREATE TABLE Client ( 
    ClientID INT PRIMARY KEY, 
    ClientName VARCHAR(100), 
    ContactPerson VARCHAR(100) 
); 
CREATE TABLE Contract ( 
    ContractID INT PRIMARY KEY, 
    ClientID INT, 
    StartDate DATE, 
    EndDate DATE, 
    TotalValue DECIMAL(10,2) 
); 
 
 
CREATE TABLE Payment ( 
    PaymentID INT PRIMARY KEY, 
    ContractID INT, 
    PaymentDate DATE, 
    Amount DECIMAL(10,2) 
); 

-- Data Insertion
INSERT INTO dbo.Employee VALUES (1, 'Ali Al-Harthy', 'Admin', '2022-01-15'); 
INSERT INTO dbo.Trainer VALUES (101, 'Salim Al-Nabhani', 'Databases'); 
INSERT INTO dbo.Attendance VALUES (1001, 1, '2024-12-10', 'Present'); 

INSERT INTO dbo.Course VALUES (201, 'SQL Fundamentals', 4); 
INSERT INTO dbo.Batch VALUES (301, 201, '2025-01-10', '2025-02-07'); 
INSERT INTO dbo.Exam VALUES (401, 201, '2025-02-10'); 
INSERT INTO dbo.Result VALUES (501, 401, 1, 87); 

INSERT INTO dbo.Client VALUES (601, 'TechCorp LLC', 'Hassan Said'); 
INSERT INTO dbo.Contract VALUES (701, 601, '2025-01-01', '2025-12-31', 10000.00); 
INSERT INTO dbo.Payment VALUES (801, 701, '2025-02-01', 2000.00);


-- Schema Creation
CREATE SCHEMA HR;
CREATE SCHEMA Academics;
CREATE SCHEMA Sales;

-- Transfering Tables into schemas
ALTER SCHEMA HR TRANSFER dbo.Employee;
ALTER SCHEMA HR TRANSFER dbo.Trainer;
ALTER SCHEMA HR TRANSFER dbo.Attendance;

ALTER SCHEMA Academics TRANSFER dbo.Course;
ALTER SCHEMA Academics TRANSFER dbo.Batch;
ALTER SCHEMA Academics TRANSFER dbo.Exam;
ALTER SCHEMA Academics TRANSFER dbo.Result;

ALTER SCHEMA Sales TRANSFER dbo.Client;
ALTER SCHEMA Sales TRANSFER dbo.Contract;
ALTER SCHEMA Sales TRANSFER dbo.Payment;

-- Selecting data in schemas
SELECT * FROM HR.Employee
SELECT * FROM Academics.Course
SELECT * FROM Sales.Client

SELECT * FROM HR.Employee
where EmployeeID = 1

-- Creating a table within a schema and selecting it
CREATE TABLE HR.HAROON (
Name VARCHAR(25),
Title VARCHAR(25)
);

INSERT INTO HR.HAROON VALUES('Haroon AlQasmi','Best of the Best')
SELECT * FROM HR.HAROON

-- Backing up Database

BACKUP DATABASE Training_CertificationPlatform
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\Training_CertificationPlatform.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of Training_CertificationPlatform';