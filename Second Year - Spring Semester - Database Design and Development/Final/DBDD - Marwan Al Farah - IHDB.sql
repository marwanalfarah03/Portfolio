-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2023 at 02:04 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ihdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_operating_rooms` (IN `checkDatetime` DATETIME)   BEGIN
    SELECT o.room_number, o.room_type
    FROM OPERATING_ROOM o
    WHERE o.operating_room_id NOT IN (
        SELECT s.operating_room_id
        FROM SURGERY s
        WHERE s.start_time <= checkDatetime AND s.end_time > checkDatetime
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_doctor_information` (IN `patientId` INT)   BEGIN
    SELECT DISTINCT doctor_id, first_name, middle_name, last_name, specialty, phone_number
 FROM patient_doctor_information_view
    WHERE patient_id = patientId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_doctor_patient_count` ()   BEGIN
    SELECT d.doctor_id, d.first_name, d.last_name, COUNT(dp.patient_id) AS patient_count
    FROM DOCTOR d
    LEFT JOIN DOCTOR_PATIENT dp ON d.doctor_id = dp.doctor_id
    GROUP BY d.doctor_id, d.first_name, d.last_name
    HAVING patient_count > 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_doctor_surgeries` (IN `doctorId` INT)   BEGIN
    SELECT surgery_id, surgery_type, start_time, end_time, patient_first_name, patient_last_name, room_number, room_type FROM doctor_surgery_details_view
    WHERE doctor_id = doctorId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_information` (IN `patientId` INT)   BEGIN
    SELECT * FROM patient_summary_view
    WHERE patient_id = patientId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_surgeries` (IN `patientId` INT)   BEGIN
    SELECT surgery_id, surgery_type, start_time, end_time, doctor_first_name, doctor_last_name FROM patient_surgery_details_view
    WHERE patient_id = patientId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reschedule_appointment` (IN `patientId` INT, IN `doctorId` INT, IN `previousAppointmentDate` DATE, IN `newAppointmentDate` DATE, IN `newAppointmentTime` TIME)   BEGIN
    UPDATE DOCTOR_PATIENT
    SET appointment_date = newAppointmentDate, appointment_time = newAppointmentTime
    WHERE patient_id = patientId AND doctor_id = doctorId AND appointment_date = previousAppointmentDate;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_doctor_contact_info` (IN `doctorId` INT, IN `newPhoneNumber` CHAR(10))   BEGIN
    UPDATE DOCTOR
    SET phone_number = newPhoneNumber
    WHERE doctor_id = doctorId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_patient_contact_info` (IN `patientId` INT, IN `newPhoneNumber` CHAR(10), IN `newAddress` VARCHAR(150))   BEGIN
    UPDATE PATIENT
    SET phone_number = newPhoneNumber, address = newAddress
    WHERE patient_id = patientId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doctor_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `specialty` varchar(100) DEFAULT NULL,
  `phone_number` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctor_id`, `first_name`, `middle_name`, `last_name`, `specialty`, `phone_number`) VALUES
(1, 'Emily', 'M.', 'Brown', 'Cardiology', '1112223333'),
(2, 'David', NULL, 'Wilson', 'Orthopedics', '4445556666'),
(3, 'Sarah', 'L.', 'Davis', 'Pediatrics', '7778889999'),
(4, 'Matthew', 'J.', 'Smith', 'Dermatology', '2223334444'),
(5, 'Jennifer', 'A.', 'Johnson', 'Neurology', '5554443333'),
(6, 'Daniel', 'M.', 'Clark', 'Ophthalmology', '6667778888'),
(7, 'Sophia', 'R.', 'Miller', 'Oncology', '8889991111'),
(8, 'Andrew', NULL, 'Thompson', 'ENT', '3334445555'),
(9, 'Olivia', 'K.', 'Harris', 'Gastroenterology', '6667778889'),
(10, 'William', 'C.', 'Anderson', 'Urology', '9998887777');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_patient`
--

CREATE TABLE `doctor_patient` (
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_patient`
--

INSERT INTO `doctor_patient` (`patient_id`, `doctor_id`, `appointment_date`, `appointment_time`) VALUES
(1, 1, '2023-05-14', '10:00:00'),
(1, 1, '2023-05-18', '15:30:00'),
(2, 2, '2023-05-15', '14:00:00'),
(2, 3, '2023-05-16', '09:00:00'),
(2, 4, '2023-05-17', '11:30:00'),
(3, 2, '2023-05-14', '11:30:00'),
(3, 2, '2023-05-19', '09:00:00'),
(3, 5, '2023-05-18', '10:00:00'),
(4, 1, '2023-05-15', '11:00:00'),
(4, 2, '2023-05-17', '14:30:00'),
(4, 3, '2023-05-19', '10:30:00'),
(4, 5, '2023-05-19', '13:30:00'),
(5, 6, '2023-05-20', '16:00:00'),
(5, 7, '2023-05-20', '09:30:00'),
(5, 8, '2023-05-21', '09:00:00'),
(6, 7, '2023-05-20', '11:00:00'),
(6, 8, '2023-05-21', '11:30:00'),
(7, 7, '2023-05-20', '12:30:00'),
(7, 9, '2023-05-21', '13:00:00'),
(8, 9, '2023-05-22', '13:30:00'),
(8, 10, '2023-05-22', '10:00:00'),
(8, 10, '2023-05-25', '11:30:00'),
(9, 1, '2023-05-23', '14:00:00'),
(10, 2, '2023-05-24', '15:30:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctor_surgery_count_view`
-- (See below for the actual view)
--
CREATE TABLE `doctor_surgery_count_view` (
`doctor_id` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`surgery_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctor_surgery_details_view`
-- (See below for the actual view)
--
CREATE TABLE `doctor_surgery_details_view` (
`doctor_id` int(11)
,`surgery_id` int(11)
,`surgery_type` varchar(100)
,`start_time` datetime
,`end_time` datetime
,`patient_first_name` varchar(50)
,`patient_last_name` varchar(50)
,`room_number` char(4)
,`room_type` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `operating_room`
--

CREATE TABLE `operating_room` (
  `operating_room_id` int(11) NOT NULL,
  `room_number` char(4) NOT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `operating_room`
--

INSERT INTO `operating_room` (`operating_room_id`, `room_number`, `room_type`, `capacity`) VALUES
(1, '1101', 'General', 10),
(2, '1102', 'Cardiology', 8),
(3, '1103', 'Orthopedics', 6),
(4, '1104', 'Neurosurgery', 10),
(5, '1105', 'Ophthalmology', 6),
(6, '1106', 'ENT', 8),
(7, '1101', 'Gynecology', 6),
(8, '1108', 'Urology', 8),
(9, '1109', 'Plastic Surgery', 6),
(10, '1110', 'Dental', 4);

-- --------------------------------------------------------

--
-- Stand-in structure for view `operating_room_equipment_summary_view`
-- (See below for the actual view)
--
CREATE TABLE `operating_room_equipment_summary_view` (
`operating_room_id` int(11)
,`room_number` char(4)
,`room_type` varchar(50)
,`num_equipment` bigint(21)
,`equipment_list` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `or_bed`
--

CREATE TABLE `or_bed` (
  `operating_room_id` int(11) NOT NULL,
  `bed_size` enum('S','M','L') NOT NULL CHECK (`bed_size` in ('S','M','L')),
  `maximum_weight` int(11) DEFAULT 150
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `or_bed`
--

INSERT INTO `or_bed` (`operating_room_id`, `bed_size`, `maximum_weight`) VALUES
(1, 'S', 100),
(2, 'L', 200),
(3, 'L', 200),
(4, 'M', 150),
(5, 'S', 100),
(6, 'M', 150),
(7, 'L', 200),
(8, 'L', 200),
(9, 'S', 100),
(10, 'L', 200);

-- --------------------------------------------------------

--
-- Table structure for table `or_equipment`
--

CREATE TABLE `or_equipment` (
  `operating_room_id` int(11) NOT NULL,
  `equipment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `or_equipment`
--

INSERT INTO `or_equipment` (`operating_room_id`, `equipment`) VALUES
(1, 'Anesthesia Machine'),
(1, 'Electrocautery Unit'),
(1, 'Operating Table'),
(1, 'Surgical Lights'),
(2, 'Anesthesia Machine'),
(2, 'C-arm Fluoroscopy'),
(2, 'Operating Table'),
(2, 'Surgical Lights'),
(3, 'Anesthesia Machine'),
(3, 'Operating Table'),
(3, 'Orthopedic Power Tools'),
(3, 'Surgical Lights'),
(4, 'Anesthesia Machine'),
(4, 'Microscope'),
(4, 'Operating Table'),
(4, 'Surgical Lights'),
(5, 'Anesthesia Machine'),
(5, 'Operating Table'),
(5, 'Phacoemulsification Machine'),
(5, 'Surgical Lights'),
(6, 'Anesthesia Machine'),
(6, 'ENT Microscope'),
(6, 'Operating Table'),
(6, 'Surgical Lights'),
(7, 'Anesthesia Machine'),
(7, 'Hysteroscope'),
(7, 'Operating Table'),
(7, 'Surgical Lights'),
(8, 'Anesthesia Machine'),
(8, 'Operating Table'),
(8, 'Surgical Lights'),
(8, 'Urology Laser System'),
(9, 'Anesthesia Machine'),
(9, 'Liposuction Machine'),
(9, 'Operating Table'),
(9, 'Surgical Lights'),
(10, 'Anesthesia Machine'),
(10, 'Dental Chair'),
(10, 'Operating Table'),
(10, 'Surgical Lights');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('M','F') NOT NULL CHECK (`gender` in ('M','F')),
  `phone_number` char(10) NOT NULL,
  `address` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `first_name`, `middle_name`, `last_name`, `birth_date`, `gender`, `phone_number`, `address`) VALUES
(1, 'John', 'A.', 'Doe', '1990-05-12', 'M', '1234567890', '123 Main St, City'),
(2, 'Jane', NULL, 'Smith', '1985-08-20', 'F', '9876543210', '456 Elm St, Town'),
(3, 'Michael', 'B.', 'Johnson', '1982-02-28', 'M', '5551234567', '789 Oak Ave, Village'),
(4, 'Emily', NULL, 'Brown', '1978-12-03', 'F', '1112223333', '456 Pine St, City'),
(5, 'Robert', 'L.', 'Jones', '1995-07-15', 'M', '4445556666', '789 Cedar St, Town'),
(6, 'Laura', 'K.', 'Davis', '1989-04-22', 'F', '7778889999', '321 Maple Ave, Village'),
(7, 'Daniel', 'M.', 'Wilson', '1976-11-09', 'M', '9998887777', '987 Birch Ln, City'),
(8, 'Sarah', NULL, 'Clark', '1983-09-14', 'F', '5554443333', '654 Oak St, Town'),
(9, 'Jessica', 'R.', 'Lee', '1992-06-18', 'F', '2223334444', '321 Elm St, Village'),
(10, 'Michaela', 'J.', 'Taylor', '1980-03-25', 'F', '7779991111', '789 Cedar Ave, City');

-- --------------------------------------------------------

--
-- Table structure for table `patient_allergies`
--

CREATE TABLE `patient_allergies` (
  `patient_id` int(11) NOT NULL,
  `allergy` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_allergies`
--

INSERT INTO `patient_allergies` (`patient_id`, `allergy`) VALUES
(2, 'Lactose'),
(3, 'Cats'),
(3, 'Eggs'),
(3, 'Shellfish'),
(4, 'Mold'),
(4, 'Pollen'),
(6, 'Fish'),
(7, 'Latex'),
(8, 'Cats'),
(8, 'Peanuts'),
(8, 'Pollen'),
(9, 'Dust'),
(9, 'Mold'),
(10, 'Pollen'),
(10, 'Shellfish');

-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_demographics_view`
-- (See below for the actual view)
--
CREATE TABLE `patient_demographics_view` (
`gender` enum('M','F')
,`patient_count` bigint(21)
,`average_age` decimal(24,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_doctor_information_view`
-- (See below for the actual view)
--
CREATE TABLE `patient_doctor_information_view` (
`patient_id` int(11)
,`doctor_id` int(11)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`specialty` varchar(100)
,`phone_number` char(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_summary_view`
-- (See below for the actual view)
--
CREATE TABLE `patient_summary_view` (
`patient_id` int(11)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`birth_date` date
,`gender` enum('M','F')
,`phone_number` char(10)
,`address` varchar(150)
,`age` bigint(21)
,`allergies` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_surgery_details_view`
-- (See below for the actual view)
--
CREATE TABLE `patient_surgery_details_view` (
`patient_id` int(11)
,`surgery_id` int(11)
,`surgery_type` varchar(100)
,`start_time` datetime
,`end_time` datetime
,`doctor_first_name` varchar(50)
,`doctor_last_name` varchar(50)
,`room_number` char(4)
,`room_type` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `surgery`
--

CREATE TABLE `surgery` (
  `surgery_id` int(11) NOT NULL,
  `surgery_type` varchar(100) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `operating_room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surgery`
--

INSERT INTO `surgery` (`surgery_id`, `surgery_type`, `start_time`, `end_time`, `doctor_id`, `patient_id`, `operating_room_id`) VALUES
(1, 'Appendectomy', '2023-05-14 09:00:00', '2023-05-14 10:30:00', 4, 1, 1),
(2, 'Knee Replacement', '2023-05-14 11:00:00', '2023-05-14 14:00:00', 2, 2, 3),
(3, 'Cataract Surgery', '2023-05-15 10:30:00', '2023-05-15 12:00:00', 3, 3, 5),
(4, 'Gallbladder Removal', '2023-05-16 08:00:00', '2023-05-16 10:00:00', 7, 4, 2),
(5, 'Brain Tumor Surgery', '2023-05-17 13:00:00', '2023-05-17 18:00:00', 1, 5, 4),
(6, 'Hysterectomy', '2023-05-18 11:30:00', '2023-05-18 15:30:00', 5, 6, 7),
(7, 'Colonoscopy', '2023-05-19 09:00:00', '2023-05-19 10:00:00', 6, 7, 8),
(8, 'Breast Cancer Surgery', '2023-05-20 14:00:00', '2023-05-20 17:00:00', 3, 8, 4),
(9, 'Tonsillectomy', '2023-05-21 10:00:00', '2023-05-21 11:30:00', 8, 9, 6),
(10, 'Liposuction', '2023-05-22 13:30:00', '2023-05-22 15:30:00', 9, 10, 9),
(11, 'Hip Replacement', '2023-05-23 08:00:00', '2023-05-23 10:00:00', 2, 1, 3),
(12, 'Gastric Bypass', '2023-05-24 11:00:00', '2023-05-24 14:00:00', 7, 2, 5),
(13, 'LASIK Surgery', '2023-05-25 10:30:00', '2023-05-25 12:00:00', 3, 3, 7),
(14, 'Hernia Repair', '2023-05-26 08:00:00', '2023-05-26 10:00:00', 4, 4, 2),
(15, 'Spinal Fusion', '2023-05-27 13:00:00', '2023-05-27 18:00:00', 1, 5, 4),
(16, 'Cesarean Section', '2023-05-28 11:30:00', '2023-05-28 15:30:00', 5, 6, 7),
(17, 'Endoscopy', '2023-05-29 09:00:00', '2023-05-29 10:00:00', 6, 7, 8),
(18, 'Lumpectomy', '2023-05-30 14:00:00', '2023-05-30 17:00:00', 3, 8, 4),
(19, 'Adenoidectomy', '2023-05-31 10:00:00', '2023-05-31 11:30:00', 8, 9, 6),
(20, 'Rhinoplasty', '2023-06-01 13:30:00', '2023-06-01 15:30:00', 9, 10, 9),
(21, 'Gallstone Removal', '2023-06-02 09:00:00', '2023-06-02 10:30:00', 4, 1, 1),
(22, 'Rotator Cuff Repair', '2023-06-03 11:00:00', '2023-06-03 14:00:00', 2, 2, 3),
(23, 'LASIK Surgery', '2023-06-04 10:30:00', '2023-06-04 12:00:00', 3, 3, 7),
(24, 'Appendectomy', '2023-06-05 08:00:00', '2023-06-05 10:00:00', 7, 4, 2),
(25, 'Brain Tumor Surgery', '2023-06-06 13:00:00', '2023-06-06 18:00:00', 1, 5, 4),
(26, 'Hysterectomy', '2023-06-07 11:30:00', '2023-06-07 15:30:00', 5, 6, 7),
(27, 'Colonoscopy', '2023-06-08 09:00:00', '2023-06-08 10:00:00', 6, 7, 8),
(28, 'Breast Cancer Surgery', '2023-06-09 14:00:00', '2023-06-09 17:00:00', 3, 8, 4),
(29, 'Tonsillectomy', '2023-06-10 10:00:00', '2023-06-10 11:30:00', 8, 9, 6),
(30, 'Liposuction', '2023-06-11 13:30:00', '2023-06-11 15:30:00', 9, 10, 9),
(31, 'Knee Replacement', '2023-06-12 08:00:00', '2023-06-12 10:00:00', 2, 1, 3),
(32, 'Gastric Bypass', '2023-06-13 11:00:00', '2023-06-13 14:00:00', 7, 2, 5),
(33, 'LASIK Surgery', '2023-06-14 10:30:00', '2023-06-14 12:00:00', 3, 3, 7);

-- --------------------------------------------------------

--
-- Structure for view `doctor_surgery_count_view`
--
DROP TABLE IF EXISTS `doctor_surgery_count_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctor_surgery_count_view`  AS SELECT `doctor`.`doctor_id` AS `doctor_id`, `doctor`.`first_name` AS `first_name`, `doctor`.`last_name` AS `last_name`, count(0) AS `surgery_count` FROM (`surgery` join `doctor` on(`surgery`.`doctor_id` = `doctor`.`doctor_id`)) GROUP BY `doctor`.`doctor_id` ;

-- --------------------------------------------------------

--
-- Structure for view `doctor_surgery_details_view`
--
DROP TABLE IF EXISTS `doctor_surgery_details_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctor_surgery_details_view`  AS SELECT `s`.`doctor_id` AS `doctor_id`, `s`.`surgery_id` AS `surgery_id`, `s`.`surgery_type` AS `surgery_type`, `s`.`start_time` AS `start_time`, `s`.`end_time` AS `end_time`, `p`.`first_name` AS `patient_first_name`, `p`.`last_name` AS `patient_last_name`, `o`.`room_number` AS `room_number`, `o`.`room_type` AS `room_type` FROM ((`surgery` `s` join `patient` `p` on(`s`.`patient_id` = `p`.`patient_id`)) join `operating_room` `o` on(`s`.`operating_room_id` = `o`.`operating_room_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `operating_room_equipment_summary_view`
--
DROP TABLE IF EXISTS `operating_room_equipment_summary_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `operating_room_equipment_summary_view`  AS SELECT `o`.`operating_room_id` AS `operating_room_id`, `o`.`room_number` AS `room_number`, `o`.`room_type` AS `room_type`, count(`e`.`equipment`) AS `num_equipment`, group_concat(`e`.`equipment` separator ', ') AS `equipment_list` FROM (`operating_room` `o` left join `or_equipment` `e` on(`o`.`operating_room_id` = `e`.`operating_room_id`)) GROUP BY `o`.`operating_room_id` ;

-- --------------------------------------------------------

--
-- Structure for view `patient_demographics_view`
--
DROP TABLE IF EXISTS `patient_demographics_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_demographics_view`  AS SELECT `t`.`gender` AS `gender`, count(0) AS `patient_count`, avg(`t`.`age`) AS `average_age` FROM (select `patient`.`gender` AS `gender`,timestampdiff(YEAR,`patient`.`birth_date`,curdate()) AS `age` from `patient`) AS `t` GROUP BY `t`.`gender` ;

-- --------------------------------------------------------

--
-- Structure for view `patient_doctor_information_view`
--
DROP TABLE IF EXISTS `patient_doctor_information_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_doctor_information_view`  AS SELECT `dp`.`patient_id` AS `patient_id`, `d`.`doctor_id` AS `doctor_id`, `d`.`first_name` AS `first_name`, `d`.`middle_name` AS `middle_name`, `d`.`last_name` AS `last_name`, `d`.`specialty` AS `specialty`, `d`.`phone_number` AS `phone_number` FROM (`doctor_patient` `dp` join `doctor` `d` on(`dp`.`doctor_id` = `d`.`doctor_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `patient_summary_view`
--
DROP TABLE IF EXISTS `patient_summary_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_summary_view`  AS SELECT `p`.`patient_id` AS `patient_id`, `p`.`first_name` AS `first_name`, `p`.`middle_name` AS `middle_name`, `p`.`last_name` AS `last_name`, `p`.`birth_date` AS `birth_date`, `p`.`gender` AS `gender`, `p`.`phone_number` AS `phone_number`, `p`.`address` AS `address`, timestampdiff(YEAR,`p`.`birth_date`,curdate()) AS `age`, group_concat(`pa`.`allergy` separator ', ') AS `allergies` FROM (`patient` `p` left join `patient_allergies` `pa` on(`p`.`patient_id` = `pa`.`patient_id`)) GROUP BY `p`.`patient_id` ;

-- --------------------------------------------------------

--
-- Structure for view `patient_surgery_details_view`
--
DROP TABLE IF EXISTS `patient_surgery_details_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_surgery_details_view`  AS SELECT `s`.`patient_id` AS `patient_id`, `s`.`surgery_id` AS `surgery_id`, `s`.`surgery_type` AS `surgery_type`, `s`.`start_time` AS `start_time`, `s`.`end_time` AS `end_time`, `d`.`first_name` AS `doctor_first_name`, `d`.`last_name` AS `doctor_last_name`, `o`.`room_number` AS `room_number`, `o`.`room_type` AS `room_type` FROM ((`surgery` `s` join `doctor` `d` on(`s`.`doctor_id` = `d`.`doctor_id`)) join `operating_room` `o` on(`s`.`operating_room_id` = `o`.`operating_room_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `doctor_patient`
--
ALTER TABLE `doctor_patient`
  ADD PRIMARY KEY (`patient_id`,`doctor_id`,`appointment_date`),
  ADD KEY `doctor_patient_doctor_fk` (`doctor_id`);

--
-- Indexes for table `operating_room`
--
ALTER TABLE `operating_room`
  ADD PRIMARY KEY (`operating_room_id`);

--
-- Indexes for table `or_bed`
--
ALTER TABLE `or_bed`
  ADD PRIMARY KEY (`operating_room_id`);

--
-- Indexes for table `or_equipment`
--
ALTER TABLE `or_equipment`
  ADD PRIMARY KEY (`operating_room_id`,`equipment`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `patient_allergies`
--
ALTER TABLE `patient_allergies`
  ADD PRIMARY KEY (`patient_id`,`allergy`);

--
-- Indexes for table `surgery`
--
ALTER TABLE `surgery`
  ADD PRIMARY KEY (`surgery_id`),
  ADD KEY `surgery_doctor_fk` (`doctor_id`),
  ADD KEY `surgery_patient_fk` (`patient_id`),
  ADD KEY `surgery_operating_room_fk` (`operating_room_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `operating_room`
--
ALTER TABLE `operating_room`
  MODIFY `operating_room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `surgery`
--
ALTER TABLE `surgery`
  MODIFY `surgery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_patient`
--
ALTER TABLE `doctor_patient`
  ADD CONSTRAINT `doctor_patient_doctor_fk` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `doctor_patient_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `or_bed`
--
ALTER TABLE `or_bed`
  ADD CONSTRAINT `or_bed_operating_room_fk` FOREIGN KEY (`operating_room_id`) REFERENCES `operating_room` (`operating_room_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `or_equipment`
--
ALTER TABLE `or_equipment`
  ADD CONSTRAINT `or_equipment_operating_room_fk` FOREIGN KEY (`operating_room_id`) REFERENCES `operating_room` (`operating_room_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient_allergies`
--
ALTER TABLE `patient_allergies`
  ADD CONSTRAINT `patient_allergies_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `surgery`
--
ALTER TABLE `surgery`
  ADD CONSTRAINT `surgery_doctor_fk` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surgery_operating_room_fk` FOREIGN KEY (`operating_room_id`) REFERENCES `operating_room` (`operating_room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surgery_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
