CREATE DATABASE JOINs_Practice

USE JOINs_Practice

-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);
-- Job Seekers
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);
-- Job Postings
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
-- Applications
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);
-------------------------------------------------------------------------
-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');
-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');
-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');
-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');

-- Beginner Level Task-1: Here we utilaized INNER JOIN to view the relation between multiple tables
SELECT js.FullName, j.Title AS JobTitle, c.Name AS CompanyName
FROM Applications a 
INNER JOIN JobSeekers js ON a.SeekerID = js.SeekerID
INNER JOIN Jobs j ON a.JobID =j.JobID
INNER JOIN Companies c ON j.CompanyID = c.CompanyID;

-- Beginner Level Task-2: The Same idea as above
SELECT j.Title AS JobTitle, c.Name AS CompanyName
FROM Jobs j 
LEFT JOIN Applications a ON j.JobID = a.JobID
INNER JOIN Companies c ON j.CompanyID = c.CompanyID;


-- Beginner Level Task-3:
SELECT js.FullName, j.Title AS JobTitle, j.Location AS MatchingCity
FROM Applications a 
JOIN JobSeekers js ON a.SeekerID = js.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City = j.Location;

-- Beginner Level Task-4:We Used LEFT JOIN To show all jobseekers 
SELECT js.FullName, j.Title AS JobTitle, a.Status
FROM JobSeekers js
LEFT JOIN Applications a ON js.SeekerID = a.SeekerID
LEFT JOIN Jobs j ON a.JobID = j.JobID;

-- Beginner Level Task-5:
SELECT j.Title AS JobTitle, js.FullName AS ApplicantName
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
LEFT JOIN JobSeekers js ON a.SeekerID = js.SeekerID;
----------------------------------------------------------------------
-- Intermediate Level Task-6: The Output is empty because All Job seekers applied
SELECT js.FullName, js.Email
FROM JobSeekers js 
LEFT JOIN Applications a ON js.SeekerID = a.SeekerID
WHERE A.AppID IS NULL;

-- Intermediate Level Task-7: The Output is empty because all companies posted jobs
SELECT c.Name AS CompanyName
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.JobID IS NULL;

-- Intermediate Level Task-8:
SELECT js1.FullName AS Seeker1, js2.FullName AS Seeker2, js1.City AS SharedCity
FROM JobSeekers js1
JOIN JobSeekers js2 ON js1.City = js2.City AND js1.SeekerID <> js2.SeekerID;

-- Intermediate Level Task-9:
SELECT js.FullName, j.Title, j.Salary, js.City AS SeekerCity, j.Location AS JobCity
FROM Applications a
JOIN JobSeekers js ON a.SeekerID = js.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE j.Salary > 850 AND js.City <> j.Location;

-- Intermediate Level Task-10:
SELECT js.FullName, js.City AS SeekerCity, j.Location AS JobLocation
FROM Applications a
JOIN JobSeekers js ON a.SeekerID = js.SeekerID
JOIN Jobs j ON a.JobID = j.JobID;

-------------------------------------------------------------------------

-- Advanced Level Task-11:
SELECT j.Title 
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.AppID IS NULL;

-- Advanced Level Task-12:
SELECT js.FullName,j.Title AS JobTitle,j.Location AS MatchingCity
FROM Applications a
JOIN JobSeekers js ON a.SeekerID = js.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City = j.Location;

-- Advanced Level Task-13:
SELECT js1.FullName AS Seeker1, js2.FullName AS Seeker2, js1.City AS Location
FROM JobSeekers js1
JOIN Applications a1 ON js1.SeekerID = a1.SeekerID
JOIN Jobs j1 ON a1.JobID = j1.JobID
JOIN JobSeekers js2 ON js1.City = js2.City AND js1.SeekerID <> js2.SeekerID
JOIN Applications a2 ON js2.SeekerID = a2.SeekerID
JOIN Jobs j2 ON a2.JobID = j2.JobID
WHERE j1.JobID <> j2.JobID;

-- Advanced Level Task-14:
SELECT js.FullName,j.Title,js.City AS SeekerCity,j.Location AS JobCity
FROM Applications a
JOIN JobSeekers js ON a.SeekerID = js.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City <> j.Location;

-- Advanced Level Task-15:
SELECT DISTINCT js.City
FROM JobSeekers js
LEFT JOIN Companies c ON js.City = c.City
WHERE c.CompanyID IS NULL;

BACKUP DATABASE JOINs_Practice
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\SQL-JOINs-Practice.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of JOINS_Practice';