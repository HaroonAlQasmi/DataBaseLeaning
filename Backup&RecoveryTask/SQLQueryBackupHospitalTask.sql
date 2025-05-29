-- Create HospitalDB
CREATE DATABASE HospitalDB;


-- Set Recovery Model to FULL
ALTER DATABASE HospitalDB SET RECOVERY FULL;


-- Use the database
USE HospitalDB;


-- Create dummy tables
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    BirthDate DATE,
    Gender CHAR(1),
    AdmissionDate DATETIME
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    Specialization NVARCHAR(100)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
    AppointmentDate DATETIME,
    Diagnosis NVARCHAR(255)
);

-- Insert dummy data
INSERT INTO Patients (FullName, BirthDate, Gender, AdmissionDate) VALUES
('Ali Mansour', '1980-06-15', 'M', '2024-05-10 08:30'),
('Fatma Zayed', '1992-09-01', 'F', '2024-05-12 10:15'),
('Khaled Al-Sayed', '1975-01-22', 'M', '2024-05-15 09:45');

INSERT INTO Doctors (FullName, Specialization) VALUES
('Dr. Layla Hassan', 'Cardiology'),
('Dr. Omar Hegazy', 'Neurology'),
('Dr. Noor Adel', 'Pediatrics');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Diagnosis) VALUES
(1, 1, '2024-05-10 09:00', 'Hypertension'),
(2, 2, '2024-05-12 11:00', 'Migraine'),
(3, 3, '2024-05-15 10:30', 'Common Cold');

-- Full Backup (simulate Sunday)
BACKUP DATABASE HospitalDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\HospitalDB\Full_20240526_0100.bak';


-- Differential Backup (simulate weekday)
BACKUP DATABASE HospitalDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\HospitalDB\Diff_20240527_0100.bak'
WITH DIFFERENTIAL;


-- Transaction Log Backup (simulate hourly)
BACKUP LOG HospitalDB 
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\HospitalDB\Log_20240527_1400.trn';

-- Strategy Summary:
-- Full Backup: Every Sunday at 1 AM

-- Differential Backup: Every night at 1 AM (Mon–Sat)

-- Transaction Log Backup: Every hour, 24/7

-- File Naming Convention:
-- Format: C:\Backups\HospitalDB\{BackupType}_YYYYMMDD_HHMM.bak