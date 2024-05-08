-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2024 at 08:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookish-treasures`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(11) NOT NULL,
  `Username` varchar(40) DEFAULT NULL,
  `Password` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminID`, `Username`, `Password`) VALUES
(1, 'khizar', 'm.khizar133');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `book_isbn` varchar(14) NOT NULL,
  `title` varchar(40) DEFAULT NULL,
  `author` varchar(40) DEFAULT NULL,
  `genre` varchar(40) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `image_source` varchar(2000) DEFAULT NULL,
  `ebook_source` varchar(2000) DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`book_isbn`, `title`, `author`, `genre`, `price`, `quantity`, `image_source`, `ebook_source`, `publication_date`, `publisher_id`) VALUES
('9781853262447', 'The Old Curiosity Shop', 'Charles Dickens', 'Adventure', 1200, 5, 'https://covers.openlibrary.org/b/isbn/9781853262449-M.jpg', 'https://drive.google.com/file/d/13hVbxlPW272TUc2CpQuihzH_MgWEeeKu/view?usp=drive_link', '2014-04-02', 2),
('9781853262448', 'The Old Curiosity Shop', 'Charles Dickens', 'Adventure', 1200, 1, 'https://covers.openlibrary.org/b/isbn/9781853262449-M.jpg', 'https://drive.google.com/file/d/13hVbxlPW272TUc2CpQuihzH_MgWEeeKu/view?usp=drive_link', '2014-04-02', 2),
('9781853262449', 'The Old Curiosity Shop', 'Charles Dickens', 'Adventure', 1200, 23, 'https://covers.openlibrary.org/b/isbn/9781853262449-M.jpg', 'https://drive.google.com/file/d/13hVbxlPW272TUc2CpQuihzH_MgWEeeKu/view?usp=drive_link', '2014-04-02', 2);

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `order_id` int(11) NOT NULL,
  `order_date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `book_isbn` varchar(14) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`order_id`, `order_date`, `quantity`, `status`, `username`, `payment_id`, `book_isbn`, `type_id`) VALUES
(1, '2024-04-25', 2, 'P', 'm.khizar133', 1, '9781853262449', 1),
(2, '2024-04-26', 0, 'F', 'fareed2001', 1, '9781853262449', 2);

-- --------------------------------------------------------

--
-- Table structure for table `book_type`
--

CREATE TABLE `book_type` (
  `type_id` int(11) NOT NULL,
  `type` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_type`
--

INSERT INTO `book_type` (`type_id`, `type`) VALUES
(1, 'P'),
(2, 'E');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `sender` varchar(40) DEFAULT NULL,
  `receiver` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `read_flag` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `message`, `sender`, `receiver`, `timestamp`, `read_flag`) VALUES
(18, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(19, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(20, 'hello', 'admin', 'm.khizar133', '2024-05-01 14:32:24', 1),
(21, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(22, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(23, 'hhh', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(24, '..', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(25, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(26, 'hello', 'admin', 'm.khizar133', '2024-05-01 14:37:29', 1),
(27, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(28, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(29, '..', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(30, 'hh', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(31, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(32, 'hello', 'admin', 'm.khizar133', '2024-05-01 14:46:18', 1),
(33, 'bhai teray tk kiun nhi aarha msg', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(34, '..', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(35, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(36, 'hey', 'admin', 'm.khizar133', '2024-05-01 14:59:23', 1),
(37, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(38, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(39, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(40, 'kk', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(41, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(42, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(43, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(44, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(45, '..', 'm.khizar133', 'admin', '2024-05-01 17:03:41', 1),
(46, 'hello', 'admin', 'm.khizar133', '2024-05-01 15:33:29', 1),
(47, 'hey', 'Fareed2001', 'admin', '2024-05-01 17:03:50', 1),
(48, '.....', 'Fareed2001', 'admin', '2024-05-01 17:03:50', 1),
(49, 'kkkkk', 'Fareed2001', 'admin', '2024-05-01 17:03:50', 1),
(50, 'khizar', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(51, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(52, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(53, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(54, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(55, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(56, 'hey', 'Hatim Murtaza', 'admin', '2024-05-01 16:20:43', 1),
(57, 'khizar', 'Hatim Murtaza', 'admin', '2024-05-01 16:23:02', 1),
(58, 'khizar', 'admin', 'Hatim Murtaza', '2024-05-01 16:22:10', 1),
(59, '//', 'Hatim Murtaza', 'admin', '2024-05-01 16:23:02', 1),
(60, 'khizar', 'Hatim Murtaza', 'admin', '2024-05-01 16:25:15', 1),
(61, 'hey', 'admin', 'Hatim Murtaza', '2024-05-01 16:25:21', 1),
(62, 'Nasir', 'Nasir', 'admin', '2024-05-01 16:27:02', 1),
(63, 'hey', 'Nasir', 'admin', '2024-05-01 16:27:02', 1),
(64, 'han bhai', 'admin', 'Nasir', '2024-05-01 16:27:07', 1),
(65, 'khizar bhai mera', 'Ali Naqi', 'admin', '2024-05-01 17:05:13', 1),
(66, 'okay you are here', 'admin', 'Ali Naqi', '2024-05-01 16:40:38', 1),
(67, 'hey', 'Ali Naqi', 'admin', '2024-05-01 17:05:13', 1),
(68, 'men idhr hn', 'Ali Naqi', 'admin', '2024-05-01 17:05:13', 1),
(69, 'hey admin', 'm.khizar133', 'admin', '2024-05-01 17:09:07', 1),
(70, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:15:47', 1),
(71, 'men khizar', 'm.khizar133', 'admin', '2024-05-01 17:16:26', 1),
(72, 'hey customer support', 'm.khizar133', 'admin', '2024-05-01 17:18:03', 1),
(73, 'I need help', 'm.khizar133', 'admin', '2024-05-01 17:18:03', 1),
(74, 'okay whats the problem', 'admin', 'm.khizar133', '2024-05-01 17:18:18', 1),
(75, 'we will get back to you', 'admin', 'm.khizar133', '2024-05-01 17:18:40', 1),
(76, 'hey', 'm.khizar133', 'admin', '2024-05-01 17:23:06', 1),
(77, 'hello', 'm.khizar133', 'admin', '2024-05-01 17:23:06', 1),
(78, 'bhai jawab dedo', 'm.khizar133', 'admin', '2024-05-01 17:23:06', 1),
(79, 'khziar', 'admin', 'm.khizar133', '2024-05-01 17:23:12', 1),
(80, 'we will get back to you', 'admin', 'm.khizar133', '2024-05-01 17:23:29', 1),
(81, 'hey customer support', 'shahmir', 'admin', '2024-05-01 17:24:23', 1),
(82, 'hello admin', 'm.khizar133', 'admin', '2024-05-02 07:09:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `payment_method` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `payment_method`) VALUES
(1, 'COD'),
(2, 'VISA');

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `publisher_id` int(11) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `phone_num` varchar(13) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`publisher_id`, `name`, `phone_num`, `email`) VALUES
(1, 'Khizar', '0311-3135704', 'muhammadkhizr45@gmail.com'),
(2, 'books and co', '0333-1234567', 'books@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `description` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `book_isbn` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `rating`, `description`, `username`, `book_isbn`) VALUES
(1, 5, 'good book', 'm.khizar133', '9781853262449'),
(2, 2, 'badd story', 'fareed2001', '9781853262449'),
(3, 3, 'very good book', 'm.khizar133', '9781853262449'),
(4, 3, 'very good book', 'm.khizar133', '9781853262449'),
(5, 3, 'very good book', 'm.khizar133', '9781853262449');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(40) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone_num` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `name`, `email`, `password`, `address`, `phone_num`) VALUES
('fareed2001', 'Muhammad Fareed', 'fareed@gmail.com', 'fareed2001', 'street 12', '0333-1234567'),
('m.khizar133', 'khizar', 'muhammadkhizr45@gmail.com', 'm.khizar133', 'street 12', '0311-3135704'),
('shahmir', 'shahmir', 'shahmir@gmail.com', 'shahmir1', 'street 22', '0333-3333333');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`book_isbn`),
  ADD KEY `publisher_id` (`publisher_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `username` (`username`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `book_isbn` (`book_isbn`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `book_type`
--
ALTER TABLE `book_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`publisher_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `username` (`username`),
  ADD KEY `book_isbn` (`book_isbn`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `book_type`
--
ALTER TABLE `book_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`);

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`book_isbn`) REFERENCES `book` (`book_isbn`),
  ADD CONSTRAINT `booking_ibfk_4` FOREIGN KEY (`type_id`) REFERENCES `book_type` (`type_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`book_isbn`) REFERENCES `book` (`book_isbn`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
