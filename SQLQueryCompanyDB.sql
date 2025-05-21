-- Create the database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Create DEPARTMENT table
CREATE TABLE Department (
    DNUM INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    SSN INT -- Manager's SSN (FK to Employees)
);

-- Create LOC table
CREATE TABLE Loc (
    DNUM INT,
    LOC INT,
    PRIMARY KEY (DNUM, LOC),
    FOREIGN KEY (DNUM) REFERENCES Department(DNUM)
);

-- Create EMPLOYEES table
CREATE TABLE Employees (
    SSN INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender BINARY NOT NULL,
    Super_ID INT,  -- FK to Employees.SSN (supervisor)
    BirthDate DATE,
    DNUM INT NOT NULL,  -- FK to Department
    FOREIGN KEY (DNUM) REFERENCES Department(DNUM),
    FOREIGN KEY (Super_ID) REFERENCES Employees(SSN)
);

-- Add FK from Department to Employees (Manager's SSN)
ALTER TABLE Department
ADD CONSTRAINT FK_Dept_Manager
FOREIGN KEY (SSN) REFERENCES Employees(SSN);

-- Create PROJECT table
CREATE TABLE Project (
    PNUM INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    LOC INT NOT NULL,
    City VARCHAR(50) NOT NULL,
    DNUM INT NOT NULL,
    FOREIGN KEY (DNUM) REFERENCES Department(DNUM)
);

-- Create WORK table (Many-to-Many: Employees <-> Project)
CREATE TABLE Work (
    SSN INT,
    PNUM INT,
    Hours DECIMAL(5,2),
    PRIMARY KEY (SSN, PNUM),
    FOREIGN KEY (SSN) REFERENCES Employees(SSN),
    FOREIGN KEY (PNUM) REFERENCES Project(PNUM)
);

-- Create DEPENDENT table
CREATE TABLE Dependent_ (
    DNum INT,  -- Dependent number or name (based on your ERD naming)
    BD DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')) NOT NULL,
    SSN INT NOT NULL, -- Employee's SSN
    PRIMARY KEY (DNum, SSN),
    FOREIGN KEY (SSN) REFERENCES Employees(SSN)
);

BACKUP DATABASE CompanyDB
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\CompanyDB_Backup.bak'
WITH FORMAT, INIT, NAME = 'CompanyDB Full Backup';

-- Msg 3201, Level 16, State 1, Line 69
--Cannot open backup device 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\CompanyDB_Backup.bak'. Operating system error 5(Access is denied.).
--Msg 3013, Level 16, State 1, Line 69
--BACKUP DATABASE is terminating abnormally.

-- The Way I fixed the above Error Is by giving permissions to the SQL server to modify the folder I wish to save in