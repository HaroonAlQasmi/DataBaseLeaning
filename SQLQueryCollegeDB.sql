CREATE DATABASE CollegeDB

USE CollegeDB

CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL
);

CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Mobile_no VARCHAR(15),
    Department_id INT NOT NULL,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name VARCHAR(100) NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    Address VARCHAR(255),
    Pin_code VARCHAR(10),
    No_of_seats INT
);

CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_name VARCHAR(100) NOT NULL,
    Duration VARCHAR(50),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Name AS (F_name + ' ' + L_name),
    Phone_no VARCHAR(15),
    DOB DATE,
    Age AS (DATEDIFF(YEAR, DOB, GETDATE())),
    Department_id INT,
    Hostel_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);

CREATE TABLE Exams (
    Exam_code INT PRIMARY KEY,
    Exam_date DATE,
    Exam_time TIME,
    Room VARCHAR(50),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE Student_Course (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

CREATE TABLE Student_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

CREATE TABLE Faculty_Subject (
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

CREATE TABLE Student_Exam (
    S_id INT,
    Exam_code INT,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exams(Exam_code)
);


BACKUP DATABASE CollegeDB
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\CollegeDB_Backup.bak'
WITH FORMAT, INIT, NAME = 'CollegeDB Full Backup';