CREATE DATABASE LearningSystem

USE LearningSystem

-- Table Creation
CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
); 
CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 
 
CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
 
CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
);

-- Data Insertion
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 
 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 
 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 
 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 
 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3);


-- Aggregation Queries (Beginner Level)
-- 1. Total number of students
SELECT COUNT(*) AS TotalStudents FROM Students;

-- 2. Total number of enrollments
SELECT COUNT(*) AS TotalEnrollments FROM Enrollments;

-- 3. Average rating per course
SELECT CourseID, AVG(Rating) AS AvgRating FROM Enrollments GROUP BY CourseID;

-- 4. Total number of courses per instructor
SELECT InstructorID, COUNT(*) AS CourseCount FROM Courses GROUP BY InstructorID;

-- 5. Number of courses in each category
SELECT CategoryID, COUNT(*) AS CourseCount FROM Courses GROUP BY CategoryID;

-- 6. Number of students enrolled in each course
SELECT CourseID, COUNT(StudentID) AS StudentCount FROM Enrollments GROUP BY CourseID;

-- 7. Average course price per category
SELECT CategoryID, AVG(Price) AS AvgPrice FROM Courses GROUP BY CategoryID;

-- 8. Maximum course price
SELECT MAX(Price) AS MaxPrice FROM Courses;

-- 9. Min, Max, and Avg rating per course
SELECT CourseID, MIN(Rating) AS MinRating, MAX(Rating) AS MaxRating, AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

-- 10. Count of students who gave rating = 5
SELECT COUNT(*) AS CountRating5 FROM Enrollments WHERE Rating = 5;


-- Aggregation Queries (Intermediate Level)
-- 1. Average completion per course
SELECT CourseID, AVG(CompletionPercent) AS AvgCompletion FROM Enrollments GROUP BY CourseID;

-- 2. Students enrolled in more than 1 course
SELECT StudentID, COUNT(*) AS CourseCount
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 1;

-- 3. Revenue per course (price * number of enrollments)
SELECT e.CourseID, COUNT(e.EnrollmentID) * c.Price AS Revenue
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY e.CourseID, c.Price;

-- 4. Instructor name + distinct students
SELECT i.FullName, COUNT(DISTINCT e.StudentID) AS DistinctStudents
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName;

-- 5. Average enrollments per category
SELECT c.CategoryID, AVG(enroll_count) AS AvgEnrollments
FROM (
    SELECT CourseID, COUNT(*) AS enroll_count
    FROM Enrollments
    GROUP BY CourseID
) ec
JOIN Courses c ON ec.CourseID = c.CourseID
GROUP BY c.CategoryID;

-- 6. Average course rating by instructor
SELECT i.InstructorID, i.FullName, AVG(e.Rating) AS AvgRating
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.InstructorID, i.FullName;

-- 7. Top 3 courses by enrollments
SELECT TOP 3 CourseID, COUNT(*) AS Enrollments
FROM Enrollments
GROUP BY CourseID
ORDER BY Enrollments DESC;

-- 8. Avg days to 100% (mock logic: just pick enrollments with 100% and subtract dates)
SELECT CourseID, AVG(DATEDIFF(DAY, s.JoinDate, e.EnrollDate)) AS AvgDaysToComplete
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
WHERE e.CompletionPercent = 100
GROUP BY CourseID;

-- 9. % students who completed each course
SELECT CourseID,
       COUNT(CASE WHEN CompletionPercent = 100 THEN 1 END) * 100.0 / COUNT(*) AS CompletionRate
FROM Enrollments
GROUP BY CourseID;

-- 10. Courses published per year
SELECT YEAR(PublishDate) AS Year, COUNT(*) AS CourseCount
FROM Courses
GROUP BY YEAR(PublishDate);


-- Aggregation Queries (Advanced Level)
-- 1. Student with most completed courses (100%)
SELECT TOP 1 StudentID, COUNT(*) AS CompletedCourses
FROM Enrollments
WHERE CompletionPercent = 100
GROUP BY StudentID
ORDER BY CompletedCourses DESC;

-- 2. Instructor earnings from enrollments
SELECT i.InstructorID, i.FullName, SUM(c.Price) AS TotalEarnings
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.InstructorID, i.FullName;

-- 3. Category avg rating (? 4)
SELECT cat.CategoryID, cat.CategoryName, AVG(e.Rating) AS AvgRating
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryID, cat.CategoryName
HAVING AVG(e.Rating) >= 4;

-- 4. Students rated below 3 more than once
SELECT StudentID, COUNT(*) AS LowRatings
FROM Enrollments
WHERE Rating < 3
GROUP BY StudentID
HAVING COUNT(*) > 1;

-- 5. Course with lowest average completion
SELECT TOP 1 CourseID, AVG(CompletionPercent) AS AvgCompletion
FROM Enrollments
GROUP BY CourseID
ORDER BY AvgCompletion ASC;

-- 6. Students enrolled in all courses by instructor 1
SELECT e.StudentID
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.InstructorID = 1
GROUP BY e.StudentID
HAVING COUNT(DISTINCT e.CourseID) = (
    SELECT COUNT(*) FROM Courses WHERE InstructorID = 1
);

-- 7. Duplicate ratings check
SELECT StudentID, CourseID, COUNT(*) AS DupCount
FROM Enrollments
GROUP BY StudentID, CourseID
HAVING COUNT(*) > 1;

-- 8. Category with highest avg rating
SELECT TOP 1 cat.CategoryID, cat.CategoryName, AVG(e.Rating) AS AvgRating
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryID, cat.CategoryName
ORDER BY AvgRating DESC;
