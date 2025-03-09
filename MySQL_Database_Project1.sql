-- My SQL Project
-- Creating Database
create database if NOT Exists Project_1;
-- Show Databases
show databases;
-- Use Database as follow
use Project_1;
-- Create Table we table name Customers
create table Customers(CustomerID int NOT NULL PRIMARY KEY,
						Fullname varchar(100) NOT NULL,
                        PhoneNumber int NOT NULL UNIQUE
                        );
-- Checking that Customers Table is created or not
Show tables;
-- Entering the table records
insert into Customers(CustomerID, FullName, PhoneNumber) values
					(1, "Vanessa McCarthy", 0757536378),
                    (2, "Marcos Romero", 0757536379),
                    (3, "Hiroki Yamane", 0757536381),
                    (4, "Anna Iversen", 0757536382),
                    (5, "Diana Pinto", 0757536383),
                    (6, "Altay Ayhan", 0757536384),
                    (7, "Jane Murphy", 0757536385),
                    (8, "Laurina Delgado", 0754536376),
                    (9, "Mike Edwards", 0757236375),
                    (10, "Karl Pederson", 0757936374);
-- Checking the entire table Records from Customers Table
Select * from Customers;
-- Creating the table with Table Name Booking
create table Booking(BookingID int, BookingDate Date, TableNumber int, NumberOfGuest int, CustomerID int);
-- Checking that Booking table is created or not
Show tables;
-- Entering the Records into Booking table
insert into Booking(BookingID, BookingDate, TableNumber, NumberOfGuest, CustomerID) values
					(10, '2021-11-10', 7, 5, 1),  
					(11, '2021-11-10', 5, 2, 2),  
					(12, '2021-11-10', 3, 2, 4), 
					(13, '2021-11-11', 2, 5, 5),  
					(14, '2021-11-11', 5, 2, 6),  
					(15, '2021-11-11', 3, 2, 7), 
					(16, '2021-11-11', 3, 5, 1),  
					(17, '2021-11-12', 5, 2, 2),  
					(18, '2021-11-12', 3, 2, 4), 
					(19, '2021-11-13', 7, 5, 6),  
					(21, '2021-11-14', 3, 2, 4);
-- Checkin the Booking Recordsd are enter or not
select * from Booking;
-- Creating table Restaurant
create table Restaurant(CourseName varchar(100) PRIMARY KEY, Cost decimal(3,2));
-- check the Restaurant table is created or not
show tables;
-- Updating he Cost Decimal DataType(4,2)
Alter table Restaurant modify column Cost decimal(4,2); 
-- Entering the records into Restaurant table
insert into Restaurant(CourseName, Cost) values
						("Greek salad", 15.50), 
						("Bean soup", 12.25), 
						("Pizza", 15.00), 
						("Carbonara", 12.50), 
						("Kabasa", 17.00), 
						("Shwarma", 11.30);
-- Check the Restaurant Table Records
Select * from Restaurant;
-- To see All the created tables
show tables from Project_1;
show tables;
-- Filter data using the WHERE clause and logical operators
select * from Booking where Bookingdate between "2021-11-11" and "2021-11-13";
-- Create a JOIN Query
select Customers.FullName, Booking.CustomerID from Customers
Right Join Booking
 ON Customers.CustomerID=Booking.CustomerID
 where BookingDate="2021-11-11";
 -- Create a GROUP BY Query
 Select BookingDate, Count(BookingDate) from Booking
 group by BookingDate;
 -- Create a REPLACE Statement and then see the changes made
 Replace into Restaurant (CourseName, Cost) values ("Kabasa", 20.00);
 select * from Restaurant;
 -- Create Constraints and then see the columns created in the table 'DeliveryAddress'
 Create table DeliveryAddress(
							ID int PRIMARY KEY, 
							Address Varchar(255) NOT NULL, 
                            Type varchar(100) NOT NULL default "Private",
                            CustomerID int NOT NULL,
                            foreign key(CustomerID) references Customers(CustomerID)
                            );
SHOW COLUMNS FROM DeliveryAddress;
-- Alter Table Structure and then see the columns from Courses
Alter table Restaurant add Ingredients varchar(255);
show columns from restaurant;
select * from Restaurant;
-- Create a Subquery
Select FullName from Customers where(Select CustomerID from Booking where customers.customerID=Booking.customerID and BookingDate='2021-11-11');
-- Create a Virtual Table and then see the Virtual Table
create VIEW BOOKINGVIEW as select BookingID, BookingDate, NumberOfGuest from Booking
	where NumberOfGuest>3 and BookingDate<"2021-11-13";
select * from BookingView;
-- Create a Stored Procedure and then call the Stored Procedure
Create PROCEDURE GetBookingDate(InputDate date)
Select * from booking
where Bookingdate=InputDate;
CALL GetBookingDate ("2021-11-13");
-- useing string function
select concat("ID: ", BookingID,', Date: ', BookingDate, ', number of guest: ',NumberOfGuest) as "Booking_Detaiks" from Booking;
