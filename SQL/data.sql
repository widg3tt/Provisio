DROP DATABASE IF EXISTS Provisio;
CREATE DATABASE Provisio;
USE Provisio;

DROP TABLE IF EXISTS Hotels;
CREATE TABLE Hotels (
    HotelID int NOT NULL,
    HotelName varchar(50) NOT NULL,
    Address varchar(255) NOT NULL,
    NumberOfRooms int NOT NULL,
    PhoneNumber varchar(15) NOT NULL,
    PRIMARY KEY (HotelID)
);

DROP TABLE IF EXISTS Amenities;
CREATE TABLE Amenities (
    AmenityID int NOT NULL,
    Name varchar(255) NOT NULL,
    Cost double NOT NULL,
    ChargeRecurrence varchar(15) NOT NULL,
    PRIMARY KEY (AmenityID)
);

DROP TABLE IF EXISTS Rooms;
CREATE TABLE Rooms (
    RoomID int NOT NULL,
    Size varchar(255) NOT NULL,
    NumberOfGuests int NOT NULL,
    Price double NOT NULL,
    HotelID INT references Hotels(ID),
    PRIMARY KEY (RoomID)
);

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    UserID int NOT NULL AUTO_INCREMENT,
    Email varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    LastName varchar(255) NOT NULL,
    Password varchar(50) NOT NULL,
    LoyaltyPoints int NOT NULL,
    PRIMARY KEY (UserID)
);

DROP TABLE IF EXISTS Reservations;
CREATE TABLE Reservations (
    ReservationID int NOT NULL AUTO_INCREMENT,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    Guests int NOT NULL,
    Nights int NOT NULL,
    Points int NOT NULL,
    Amenities varchar(255),
    CostPerNight double NOT NULL,
    TotalCost double NOT NULL,
    HotelID INT references Hotels(ID),
    RoomID INT references Rooms(ID),
    Email varchar(255) references Users(Email),
    PRIMARY KEY (ReservationID)
) AUTO_INCREMENT=1000;

INSERT INTO Hotels (HotelId, HotelName, Address, NumberOfRooms, PhoneNumber)
VALUES (1, 'Hotel One', '123 4th St Springfield, ORE 97229', 1, '458-123-4567');

INSERT INTO Hotels (HotelId, HotelName, Address, NumberOfRooms, PhoneNumber)
VALUES (2, 'Hotel Two', '456 7th St Dever, CO 80014', 1, '303-789-1011');

INSERT INTO Hotels (HotelId, HotelName, Address, NumberOfRooms, PhoneNumber)
VALUES (3, 'Hotel Three', '891 2nd St San Francisco, CA 91016', 1, '628-121-3141');

INSERT INTO Amenities (AmenityId, Name, Cost, ChargeRecurrence) 
VALUES (1, 'WI-FI', 12.99, 'Flat');
INSERT INTO Amenities (AmenityId, Name, Cost, ChargeRecurrence) 
VALUES (2, 'Breakfast', 8.99, 'Nightly');
INSERT INTO Amenities (AmenityId, Name, Cost, ChargeRecurrence) 
VALUES (3, 'Parking', 19.99, 'Nightly');

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (1, 'Queen Room', 1, 115.00, 1);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (2, 'Double full room', 3, 150.00, 1);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (3, 'King Room', 2, 115.00, 1);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (4, 'Double Queen Room', 4, 150.00, 1);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (5, 'Queen Room', 1, 115.00, 2);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (6, 'Double Full Room', 3, 150.00, 2);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (7, 'King Room', 2, 115.00, 2);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (8, 'Double Queen Room', 4, 150.00, 2);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (9, 'Queen Room', 1, 115.00, 3);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (10, 'Double Full Room', 3, 150.00, 3);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (11, 'King Room', 2, 115.00, 3);

INSERT INTO Rooms (RoomId, Size, NumberOfGuests, Price, HotelId)
VALUES (12, 'Double Queen Room', 4, 150.00, 3);

INSERT INTO Users (Email, FirstName, LastName, Password, LoyaltyPoints) 
VALUES ('Celine.Layn@gmail.com', 'Celine', 'Layn', 'Winter23', 0);

INSERT INTO Users (Email, FirstName, LastName, Password, LoyaltyPoints) 
VALUES ('Steve.Jenkin@gmail.com', 'Steve', 'Jenkin', 'Winter2023', 0);

INSERT INTO Users (Email, FirstName, LastName, Password, LoyaltyPoints) 
VALUES ('Tracy.Ross@gmail.com', 'Tracy', 'Ross', 'Winter2023!', 0);

INSERT INTO Reservations (CheckInDate, CheckOutDate, Guests, Nights, Points, Amenities, CostPerNight, TotalCost, HotelID, RoomID, Email)
VALUES ('2023-02-02', '2023-02-12', 1, 10, 1000, 'Breakfast', 115.00, 1150.00, 1, 1, 'Celine.Layn@gmail.com');

INSERT INTO Reservations (CheckInDate, CheckOutDate, Guests, Nights, Points, Amenities, CostPerNight, TotalCost, HotelID, RoomID, Email)
VALUES ('2023-03-02', '2023-03-12', 2, 10, 1000, 'Parking', 115.00, 1150.00, 2, 7, 'Steve.Jenkin@gmail.com');

INSERT INTO Reservations (CheckInDate, CheckOutDate, Guests, Nights, Points, Amenities, CostPerNight, TotalCost, HotelID, RoomID, Email)
VALUES ('2023-04-02', '2023-04-12', 3, 10, 1000, 'Wi-Fi', 150.00, 1500.00, 3, 10, 'Tracy.Ross@gmail.com');




