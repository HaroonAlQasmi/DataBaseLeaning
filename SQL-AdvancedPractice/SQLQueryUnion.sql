CREATE DATABASE Training_JobApplication

USE Training_JobApplication

CREATE TABLE Trainees ( 
    TraineeID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Program VARCHAR(50), 
    GraduationDate DATE 
); 

CREATE TABLE Applicants ( 
    ApplicantID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Source VARCHAR(20), -- e.g., "Website", "Referral" 
    AppliedDate DATE 
);

INSERT INTO Trainees VALUES 
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'), 
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'), 
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01');

INSERT INTO Applicants VALUES 
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'), 
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'),  
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28'); 

-- Part 1: UNION Practice
-- 1. UNION (removes duplicates)
SELECT FullName, Email FROM Trainees
UNION
SELECT FullName, Email FROM Applicants;

-- 2. UNION ALL (keeps duplicates)
SELECT FullName, Email FROM Trainees
UNION ALL
SELECT FullName, Email FROM Applicants;
-- The Name appears twice with UNION ALL because she exists in both tables.

-- 3. People in both tables (intersection)
SELECT T.FullName, T.Email
FROM Trainees T
INNER JOIN Applicants A ON T.Email = A.Email;

-- Part 2: DROP, DELETE, TRUNCATE Observation
-- 4. DELETE specific rows
DELETE FROM Trainees WHERE Program = 'Outsystems';
-- TO check on the table
SELECT *
FROM Trainees,Applicants

-- 5. TRUNCATE TABLE
TRUNCATE TABLE Applicants;
-- The table structure remains and you can't rollback in most cases because it doesn't store a log

-- 6. DROP TABLE
DROP TABLE Applicants;
-- When you run select it gives an error saying Invalid object name

-- Part 3: Self-Discovery & Applied Exploration 

BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Applicants VALUES (104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');
    INSERT INTO Applicants VALUES (104, 'Error User', 'error@example.com', 'Website', '2025-05-11'); -- duplicate ID
    COMMIT;
END TRY
BEGIN CATCH
    PRINT 'Error encountered. Rolling back.';
    ROLLBACK;
END CATCH;

-- ACID Properties Explained

-- 1. Atomicity: All operations in a transaction succeed or none do.
-- Example: Transferring money. If debit from A succeeds but credit to B fails, rollback ensures no partial transaction.

-- 2. Consistency: A transaction moves the database from one valid state to another.
-- Example: If total course seat count is 30, you shouldn't end up with 31 students after a transaction.

-- 3. Isolation: Transactions execute independently, without interfering with each other.
-- Example: Two users booking a final seat at the same time shouldn’t double-book.

-- 4. Durability: Once committed, changes are permanent—even during a power failure.
-- Example: If you update your email in your profile and commit, it will persist even after a crash.

-- Summary:
-- ACID ensures that even in high-volume or failure-prone environments, your data remains reliable and valid.
