CREATE DATABASE AirportDB

USE AirportDB

CREATE TABLE Airport (
airport_code VARCHAR(15) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL
);

CREATE TABLE Airplane_Type (
type_name VARCHAR(50) PRIMARY KEY,
company		VARCHAR(50) NOT NULL,
max_seats INT NOT NULL
);

CREATE TABLE Airplane (
airplane_id VARCHAR(20) PRIMARY KEY,
total_seats INT NOT NULL,
type_name VARCHAR(50) NOT NULL,
FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
);

CREATE TABLE Flight(
flight_id VARCHAR(20) PRIMARY KEY,
airline VARCHAR(50) NOT NULL,
Weekdays VARCHAR(50) NOT NULL,
restrictions TEXT
);

CREATE TABLE Flight_leg (
leg_no VARCHAR(20) PRIMARY KEY,
flight_id VARCHAR(20),
dep_airport VARCHAR(15),
arr_airport VARCHAR(15),
scheduled_dep_time TIME,
scheduled_arr_time TIME,
FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
FOREIGN KEY (dep_airport) REFERENCES Airport(airport_code),
FOREIGN KEY (arr_airport) REFERENCES Airport(airport_code)
);

CREATE TABLE leg_instance (
leg_no VARCHAR(20),
flight_date DATE,
dep_time TIME,
arr_time TIME,
available_seats INT,
airplane_id VARCHAR(20),
PRIMARY KEY (leg_no, flight_date),
FOREIGN KEY (leg_no) REFERENCES Flight_leg(leg_no),
FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
);

CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20)
);


CREATE TABLE Reservation (
    reservation_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    leg_no VARCHAR(20),
    flight_date DATE,
    seat_no VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (leg_no, flight_date) REFERENCES Leg_Instance(leg_no, flight_date)
);


CREATE TABLE Fare (
    fare_code VARCHAR(10) PRIMARY KEY,
    flight_id VARCHAR(20),
    amount DECIMAL(10,2),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);


CREATE TABLE Airport_Airplane_Type (
    airport_code VARCHAR(15),
    type_name VARCHAR(50),
    PRIMARY KEY (airport_code, type_name),
    FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
);

BACKUP DATABASE CompanyDB
TO DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\AirportDB_Backup.bak'
WITH FORMAT, INIT, NAME = 'AirportDB Full Backup';