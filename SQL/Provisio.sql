-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 28, 2023 at 12:50 PM
-- Server version: 10.8.3-MariaDB
-- PHP Version: 8.0.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Provisio`
--
CREATE DATABASE IF NOT EXISTS `Provisio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Provisio`;

-- --------------------------------------------------------

--
-- Table structure for table `Amenities`
--

DROP TABLE IF EXISTS `Amenities`;
CREATE TABLE `Amenities` (
  `AmenityID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Cost` double NOT NULL,
  `ChargeRecurrence` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Amenities`
--

INSERT INTO `Amenities` (`AmenityID`, `Name`, `Cost`, `ChargeRecurrence`) VALUES
(1, 'WI-FI', 12.99, 'Flat'),
(2, 'Breakfast', 8.99, 'Nightly'),
(3, 'Parking', 19.99, 'Nightly');

-- --------------------------------------------------------

--
-- Table structure for table `Hotels`
--

DROP TABLE IF EXISTS `Hotels`;
CREATE TABLE `Hotels` (
  `HotelID` int(11) NOT NULL,
  `HotelName` varchar(50) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `NumberOfRooms` int(11) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Hotels`
--

INSERT INTO `Hotels` (`HotelID`, `HotelName`, `Address`, `NumberOfRooms`, `PhoneNumber`) VALUES
(1, 'Hotel One', '123 4th St Springfield, ORE 97229', 1, '458-123-4567'),
(2, 'Hotel Two', '456 7th St Denver, CO 80014', 1, '303-789-1011'),
(3, 'Hotel Three', '891 2nd St San Francisco, CA 91016', 1, '628-121-3141');

-- --------------------------------------------------------

--
-- Table structure for table `Reservations`
--

DROP TABLE IF EXISTS `Reservations`;
CREATE TABLE `Reservations` (
  `ReservationID` int(11) NOT NULL,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `Guests` int(11) NOT NULL,
  `Nights` int(11) NOT NULL,
  `Points` int(11) NOT NULL,
  `Amenities` varchar(255) DEFAULT NULL,
  `CostPerNight` double NOT NULL,
  `TotalCost` double NOT NULL,
  `HotelID` int(11) DEFAULT NULL,
  `RoomID` int(11) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Reservations`
--

INSERT INTO `Reservations` (`ReservationID`, `CheckInDate`, `CheckOutDate`, `Guests`, `Nights`, `Points`, `Amenities`, `CostPerNight`, `TotalCost`, `HotelID`, `RoomID`, `Email`) VALUES
(1000, '2023-02-02', '2023-02-12', 1, 10, 1000, 'Breakfast', 115, 1150, 1, 1, 'Celine.Layn@gmail.com'),
(1001, '2023-03-02', '2023-03-12', 2, 10, 1000, 'Parking', 115, 1150, 2, 7, 'Steve.Jenkin@gmail.com'),
(1002, '2023-04-02', '2023-04-12', 3, 10, 1000, 'Wi-Fi', 150, 1500, 3, 10, 'Tracy.Ross@gmail.com'),
(1003, '2023-01-29', '2023-01-30', 1, 1, 150, ' wifi  breakfast ', 150, 171.98, 2, 6, 'admin@admin.com'),
(1004, '2023-01-29', '2023-01-30', 1, 1, 150, ' wifi  breakfast ', 150, 171.98, 2, 6, 'admin@admin.com'),
(1005, '2023-01-31', '2023-02-07', 1, 7, 1050, ' wifi  breakfast  parking ', 1050, 1265.85, 3, 10, 'admin@admin.com'),
(1006, '2023-02-01', '2023-02-11', 1, 10, 1500, ' breakfast ', 1150, 1239.9, 1, 3, 'admin@admin.com');

-- --------------------------------------------------------

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
CREATE TABLE `Rooms` (
  `RoomID` int(11) NOT NULL,
  `Size` varchar(255) NOT NULL,
  `NumberOfGuests` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `HotelID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Rooms`
--

INSERT INTO `Rooms` (`RoomID`, `Size`, `NumberOfGuests`, `Price`, `HotelID`) VALUES
(1, 'Queen Room', 1, 115, 1),
(2, 'Double full room', 3, 150, 1),
(3, 'King Room', 2, 115, 1),
(4, 'Double Queen Room', 4, 150, 1),
(5, 'Queen Room', 1, 115, 2),
(6, 'Double Full Room', 3, 150, 2),
(7, 'King Room', 2, 115, 2),
(8, 'Double Queen Room', 4, 150, 2),
(9, 'Queen Room', 1, 115, 3),
(10, 'Double Full Room', 3, 150, 3),
(11, 'King Room', 2, 115, 3),
(12, 'Double Queen Room', 4, 150, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `LoyaltyPoints` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserID`, `Email`, `FirstName`, `LastName`, `Password`, `LoyaltyPoints`) VALUES
(1, 'Celine.Layn@gmail.com', 'Celine', 'Layn', 'Winter23', 0),
(2, 'Steve.Jenkin@gmail.com', 'Steve', 'Jenkin', 'Winter2023', 0),
(3, 'Tracy.Ross@gmail.com', 'Tracy', 'Ross', 'Winter2023!', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Amenities`
--
ALTER TABLE `Amenities`
  ADD PRIMARY KEY (`AmenityID`);

--
-- Indexes for table `Hotels`
--
ALTER TABLE `Hotels`
  ADD PRIMARY KEY (`HotelID`);

--
-- Indexes for table `Reservations`
--
ALTER TABLE `Reservations`
  ADD PRIMARY KEY (`ReservationID`);

--
-- Indexes for table `Rooms`
--
ALTER TABLE `Rooms`
  ADD PRIMARY KEY (`RoomID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Reservations`
--
ALTER TABLE `Reservations`
  MODIFY `ReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1007;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
