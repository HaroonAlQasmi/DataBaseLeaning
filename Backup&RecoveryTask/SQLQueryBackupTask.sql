-- Step 1: Create Test Database
CREATE DATABASE TrainingDB;

USE TrainingDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    EnrollmentDate DATE
);
INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15');


-- Step 2: Full Backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Full.bak';


-- Insert New Record
INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');


-- Differential Backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Diff.bak' 
WITH DIFFERENTIAL;


-- Transaction Log Backup
ALTER DATABASE TrainingDB SET RECOVERY FULL;

BACKUP LOG TrainingDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Log.trn';


-- Copy-Only Backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_CopyOnly.bak' 
WITH COPY_ONLY;

