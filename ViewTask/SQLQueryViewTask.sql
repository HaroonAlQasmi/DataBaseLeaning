CREATE DATABASE BankingSystem

USE BankingSystem

CREATE TABLE Customer ( 
    CustomerID INT PRIMARY KEY, 
    FullName NVARCHAR(100), 
    Email NVARCHAR(100), 
    Phone NVARCHAR(15), 
    SSN CHAR(9) 
); 
  
CREATE TABLE Account ( 
    AccountID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    Balance DECIMAL(10, 2), 
    AccountType VARCHAR(50), 
    Status VARCHAR(20) 
); 
 
CREATE TABLE Transactions ( 
    TransactionID INT PRIMARY KEY, 
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID), 
    Amount DECIMAL(10, 2), 
    Type VARCHAR(10), -- Deposit, Withdraw 
    TransactionDate DATETIME 
); 
 
CREATE TABLE Loan ( 
    LoanID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    LoanAmount DECIMAL(12, 2), 
    LoanType VARCHAR(50), 
    Status VARCHAR(20) 
);

-- Dummy Data Insertion

INSERT INTO Customer VALUES
(1, 'Alice Johnson', 'alice@email.com', '123-456-7890', '123456789'),
(2, 'Bob Smith', 'bob@email.com', '987-654-3210', '987654321');

INSERT INTO Account VALUES
(101, 1, 5000.00, 'Savings', 'Active'),
(102, 2, 1200.00, 'Checking', 'Inactive');

INSERT INTO Transactions VALUES
(1001, 101, 1000.00, 'Deposit', GETDATE()),
(1002, 102, 200.00, 'Withdraw', DATEADD(DAY, -40, GETDATE()));

INSERT INTO Loan VALUES
(201, 1, 10000.00, 'Home', 'Approved'),
(202, 2, 5000.00, 'Car', 'Pending');

-- Customer Service View 
CREATE VIEW CustomerServiceView AS
SELECT 
    c.FullName, 
    c.Phone, 
    a.Status AS AccountStatus
FROM Customer c
JOIN Account a ON c.CustomerID = a.CustomerID;

-- Finance Department View
CREATE VIEW FinanceDepartmentView AS
SELECT AccountID, Balance, AccountType
FROM Account;

-- Loan Officer View
CREATE VIEW LoanOfficerView AS
SELECT LoanID, CustomerID, LoanAmount, LoanType, Status
FROM Loan;


-- Transaction Summary View
CREATE VIEW TransactionSummaryView AS
SELECT TransactionID, AccountID, Amount, Type, TransactionDate
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());

-- Calling Views to see if they work
SELECT * FROM CustomerServiceView;
SELECT * FROM FinanceDepartmentView;
SELECT * FROM LoanOfficerView;
SELECT * FROM TransactionSummaryView;

-- Backing up DB
BACKUP DATABASE BankingSystem
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\BankingSystem.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of BankingSystem';