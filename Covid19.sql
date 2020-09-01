-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: vergil.u.washington.edu:7771
-- Generation Time: Aug 29, 2020 at 10:42 AM
-- Server version: 5.6.39
-- PHP Version: 7.2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Covid19`
--

-- --------------------------------------------------------

--
-- Table structure for table `CaseSymptom`
--

CREATE TABLE `CaseSymptom` (
  `caseID` int(11) NOT NULL,
  `symptomCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CaseSymptom`
--

INSERT INTO `CaseSymptom` (`caseID`, `symptomCode`) VALUES
(1, 'Chest pain'),
(2, 'Chills'),
(3, 'Abdominal pain'),
(4, 'Diarrhea'),
(5, 'Headache'),
(6, 'Fever'),
(7, 'Nausea or vomiting'),
(8, 'Muscle aches (myalgia)'),
(9, 'Cough'),
(10, 'Fatigue');

-- --------------------------------------------------------

--
-- Table structure for table `CaseTable`
--

CREATE TABLE `CaseTable` (
  `occupationID` int(11) NOT NULL,
  `locationID` int(11) DEFAULT NULL,
  `deathDateID` int(11) DEFAULT NULL,
  `IllnessOnsetDate` date DEFAULT NULL,
  `HospitalizationEndDate` date DEFAULT NULL,
  `HospitalizationStartDate` date DEFAULT NULL,
  `personID` int(11) NOT NULL,
  `caseID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CaseTable`
--

INSERT INTO `CaseTable` (`occupationID`, `locationID`, `deathDateID`, `IllnessOnsetDate`, `HospitalizationEndDate`, `HospitalizationStartDate`, `personID`, `caseID`) VALUES
(7, 1, NULL, '2020-07-09', NULL, NULL, 1, 1),
(9, NULL, NULL, '2020-07-06', '2020-07-15', '2020-07-08', 2, 2),
(10, 6, NULL, '2020-08-03', '2020-08-10', '2020-08-07', 4, 3),
(3, 3, NULL, NULL, NULL, NULL, 5, 4),
(7, 8, NULL, '2020-08-08', '2020-08-12', '2020-08-11', 6, 5),
(3, 5, 3, '2020-06-27', '2020-07-08', '2020-07-01', 7, 6),
(10, 1, NULL, '2020-07-14', NULL, NULL, 9, 7),
(10, 1, 1, '2020-07-28', '2020-08-01', '2020-07-28', 10, 8),
(10, 1, NULL, NULL, NULL, NULL, 11, 9),
(7, 8, NULL, '2020-07-26', NULL, NULL, 14, 10),
(7, 1, NULL, NULL, NULL, NULL, 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `CaseUnderlyingCondition`
--

CREATE TABLE `CaseUnderlyingCondition` (
  `caseID` int(11) NOT NULL,
  `underlyingConfitionCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CaseUnderlyingCondition`
--

INSERT INTO `CaseUnderlyingCondition` (`caseID`, `underlyingConfitionCode`) VALUES
(1, 'Diabetes'),
(2, 'Liver disease'),
(3, 'Current Smoker'),
(4, 'Other'),
(5, 'Post-partum (< 6 weeks)'),
(6, 'Hypertension'),
(7, 'Malignancy'),
(8, 'Renal disease'),
(9, 'Chronic disease'),
(10, 'Disability');

-- --------------------------------------------------------

--
-- Table structure for table `ContactPeriod`
--

CREATE TABLE `ContactPeriod` (
  `locationID` int(11) DEFAULT NULL,
  `contactPeriodID` int(11) NOT NULL,
  `ContactDate` date DEFAULT NULL,
  `ContagiousFlag` bit(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ContactPeriod`
--

INSERT INTO `ContactPeriod` (`locationID`, `contactPeriodID`, `ContactDate`, `ContagiousFlag`) VALUES
(1, 1, '2020-07-13', b'1'),
(2, 2, '2020-07-13', b'0'),
(3, 3, '2020-08-03', b'1'),
(4, 4, '2020-08-03', b'0'),
(5, 5, '2020-07-06', b'1'),
(6, 6, '2020-07-06', b'0'),
(7, 7, '2020-08-01', b'1'),
(8, 8, '2020-08-01', b'0'),
(9, 9, '2020-07-22', b'1'),
(10, 10, '2020-07-22', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `ContactPerson`
--

CREATE TABLE `ContactPerson` (
  `contactPeriodID` int(11) NOT NULL,
  `personID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ContactPerson`
--

INSERT INTO `ContactPerson` (`contactPeriodID`, `personID`) VALUES
(1, 1),
(2, 2),
(3, 5),
(4, 4),
(5, 6),
(6, 7),
(7, 9),
(8, 10),
(9, 11),
(10, 14);

-- --------------------------------------------------------

--
-- Table structure for table `Country`
--

CREATE TABLE `Country` (
  `countryCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Country`
--

INSERT INTO `Country` (`countryCode`) VALUES
('CAN'),
('MEX'),
('Other'),
('US');

-- --------------------------------------------------------

--
-- Table structure for table `CovidReport`
--

CREATE TABLE `CovidReport` (
  `organizationID` int(11) NOT NULL,
  `reportID` int(11) NOT NULL,
  `ReportDate` date DEFAULT NULL,
  `caseID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CovidReport`
--

INSERT INTO `CovidReport` (`organizationID`, `reportID`, `ReportDate`, `caseID`) VALUES
(10, 1, '2020-07-16', 1),
(7, 2, '2020-07-07', 2),
(7, 3, '2020-08-10', 3),
(10, 4, NULL, 4),
(7, 5, '2020-08-10', 5),
(10, 6, '2020-07-01', 6),
(0, 7, '2020-08-16', 7),
(3, 8, '2020-07-28', 8),
(3, 9, NULL, 9),
(7, 10, '2020-08-01', 10);

-- --------------------------------------------------------

--
-- Table structure for table `CovidReportPerson`
--

CREATE TABLE `CovidReportPerson` (
  `personID` int(11) NOT NULL,
  `reportID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CovidReportPerson`
--

INSERT INTO `CovidReportPerson` (`personID`, `reportID`) VALUES
(1, 1),
(2, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(9, 7),
(10, 8),
(11, 9),
(14, 10);

-- --------------------------------------------------------

--
-- Table structure for table `CovidReportPersonRole`
--

CREATE TABLE `CovidReportPersonRole` (
  `reportID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `roleCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CovidReportPersonRole`
--

INSERT INTO `CovidReportPersonRole` (`reportID`, `personID`, `roleCode`) VALUES
(1, 1, 'Patient'),
(2, 2, 'Patient'),
(3, 3, 'Patient'),
(3, 4, 'Nurse'),
(5, 4, 'Reporter'),
(6, 6, 'Reporter'),
(7, 14, 'Clinician'),
(8, 6, 'Reporter'),
(8, 8, 'Patient'),
(10, 11, 'Nurse');

-- --------------------------------------------------------

--
-- Table structure for table `Death`
--

CREATE TABLE `Death` (
  `deathDateID` int(11) NOT NULL,
  `deathDate` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Death`
--

INSERT INTO `Death` (`deathDateID`, `deathDate`) VALUES
(1, '2020-08-01'),
(3, '2020-07-08'),
(5, '2020-06-30'),
(9, '2020-07-29'),
(8, '2020-06-11'),
(2, '2020-07-15'),
(7, '2020-07-07'),
(10, '2020-06-10'),
(4, '2020-08-20'),
(6, '2020-08-12');

-- --------------------------------------------------------

--
-- Table structure for table `Ethnicity`
--

CREATE TABLE `Ethnicity` (
  `ethnicityCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Ethnicity`
--

INSERT INTO `Ethnicity` (`ethnicityCode`) VALUES
('Hispanic/Latino'),
('Non-Hispanic/Latino'),
('Not Specified'),
('Pacific Islander'),
('Unknown');

-- --------------------------------------------------------

--
-- Table structure for table `Location`
--

CREATE TABLE `Location` (
  `countryCode` varchar(50) NOT NULL,
  `stateCode` varchar(50) NOT NULL,
  `locality` varchar(50) DEFAULT NULL,
  `locationNote` varchar(255) DEFAULT NULL,
  `locationID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Location`
--

INSERT INTO `Location` (`countryCode`, `stateCode`, `locality`, `locationNote`, `locationID`) VALUES
('US', 'WA', 'Seattle', NULL, 1),
('CAN', 'Other', 'Tacoma', NULL, 2),
('MEX', 'Other', 'Mexico City', NULL, 3),
('US', 'OR', 'Salem', NULL, 4),
('MEX', 'Other', 'Ecatepec', NULL, 5),
('US', 'WA', 'Seattle', '123rd Street, 12th Avenue', 6),
('CAN', 'Other', 'Tacoma', '66th Street, 8th Avenue', 7),
('MEX', 'Other', 'Monterrey', NULL, 8),
('MEX', 'Other', 'Zapopan', NULL, 9),
('US', 'AL', 'Anchorage', NULL, 10);

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE `Organization` (
  `organizationCode` varchar(50) NOT NULL,
  `organizationID` int(11) NOT NULL,
  `organizationName` varchar(255) DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Organization`
--

INSERT INTO `Organization` (`organizationCode`, `organizationID`, `organizationName`, `locationID`) VALUES
('Manufacturing', 1, NULL, 1),
('Education', 2, 'Childcare Daycare', 2),
('Healthcare', 3, 'Green Hospital', 5),
('Transportation', 4, 'Metro Public Bus Transportation', 5),
('Food', 5, 'Safeway', 6),
('Retail', 6, NULL, 7),
('Healthcare', 7, 'Clinic', 8),
('Construction', 8, NULL, 4),
('Healthcare', 9, 'Hospital', NULL),
('Healthcare', 10, 'Swedish Hospital', 1);

-- --------------------------------------------------------

--
-- Table structure for table `OrganizationType`
--

CREATE TABLE `OrganizationType` (
  `organizationCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OrganizationType`
--

INSERT INTO `OrganizationType` (`organizationCode`) VALUES
('Agriculture'),
('Construction'),
('Education'),
('Electronics'),
('Entertainment'),
('Food'),
('Healthcare'),
('Information Technology'),
('Manufacturing'),
('Other'),
('Retail'),
('Transportation');

-- --------------------------------------------------------

--
-- Table structure for table `Person`
--

CREATE TABLE `Person` (
  `deathDateID` int(11) DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL,
  `personID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `TelephoneNo` varchar(20) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `sexCode` varchar(50) NOT NULL,
  `organizationID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Person`
--

INSERT INTO `Person` (`deathDateID`, `locationID`, `personID`, `FirstName`, `LastName`, `DateOfBirth`, `TelephoneNo`, `Email`, `sexCode`, `organizationID`) VALUES
(NULL, 1, 1, 'Jason', 'Hunter', '2000-02-05', ' +1-202-555-0120 ', NULL, 'Male', 2),
(NULL, NULL, 2, 'Dustin', 'Lay', '1958-08-05', '+1-480-221-1745', 'DustinIBourland@jourrapide.com ', 'Male', 4),
(NULL, 3, 5, 'Simon', 'Tran', '1995-06-07', '360-878-3502', NULL, 'Female', 2),
(NULL, 6, 4, 'Thomas ', 'Nguyen', '1999-01-31', '253-754-0697', NULL, 'Male', 1),
(NULL, 1, 6, 'Natalie', 'Nguyen', '1998-09-25', '253-464-5678', NULL, 'Female', 9),
(3, 2, 7, 'Thanh', 'Pham', '1947-12-22', '360-753-2699', NULL, 'Male', 1),
(NULL, NULL, 9, 'Kevin', 'Peterson', '1998-04-19', '+1-602-870-4900', 'KevinJPeterson@teleworm.us', 'Male', NULL),
(1, 1, 10, 'Iris', 'Istanbul', '1994-09-25', '253-489-9870', NULL, 'Male', 1),
(NULL, 4, 11, 'Jessica', 'Altamirano', '1990-09-12', NULL, NULL, 'Female', 10),
(NULL, NULL, 14, 'Karen', 'McCormick', '1960-09-22', '+1-704-815-0121', 'KarenHMcCormick@rhyta.com', 'Female', 3),
(NULL, 1, 3, 'Josh', 'Sam', '1998-08-05', '425-310-2090', 'joshsam@gmail.com', 'Male', 1),
(NULL, 1, 8, 'Millie', 'Smith', '1998-11-10', '425-109-7281', 'sarahbask@gmail.com', 'Female', 2);

-- --------------------------------------------------------

--
-- Table structure for table `PersonEthnicity`
--

CREATE TABLE `PersonEthnicity` (
  `personID` int(11) NOT NULL,
  `ethnicityCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PersonEthnicity`
--

INSERT INTO `PersonEthnicity` (`personID`, `ethnicityCode`) VALUES
(1, 'Non-Hispanic/Latino'),
(2, 'Not Specified'),
(4, 'Non-Hispanic/Latino'),
(5, 'Non-Hispanic/Latino'),
(6, 'Non-Hispanic/Latino'),
(7, 'Non-Hispanic/Latino'),
(9, 'Non-Hispanic/Latino'),
(10, 'Not Specified'),
(11, 'Hispanic/Latino'),
(14, 'Non-Hispanic/Latino');

-- --------------------------------------------------------

--
-- Table structure for table `PersonRace`
--

CREATE TABLE `PersonRace` (
  `personID` int(11) NOT NULL,
  `raceCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PersonRace`
--

INSERT INTO `PersonRace` (`personID`, `raceCode`) VALUES
(1, 'White'),
(2, 'White'),
(4, 'Asian'),
(5, 'Asian'),
(6, 'Asian'),
(7, 'Asian'),
(9, 'Black'),
(10, 'Other'),
(11, 'Other'),
(14, 'White');

-- --------------------------------------------------------

--
-- Table structure for table `PersonRole`
--

CREATE TABLE `PersonRole` (
  `roleCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PersonRole`
--

INSERT INTO `PersonRole` (`roleCode`) VALUES
('Clinician'),
('Doctor'),
('ICP'),
('Nurse'),
('Other'),
('Patient'),
('Reporter');

-- --------------------------------------------------------

--
-- Table structure for table `Race`
--

CREATE TABLE `Race` (
  `raceCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Race`
--

INSERT INTO `Race` (`raceCode`) VALUES
('American Indian/Alaska Native'),
('Asian'),
('Black'),
('Native Hawaiian/Other Pacific Islander'),
('Other'),
('Unknown'),
('White');

-- --------------------------------------------------------

--
-- Table structure for table `RiskFactor`
--

CREATE TABLE `RiskFactor` (
  `riskFactorCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `RiskFactor`
--

INSERT INTO `RiskFactor` (`riskFactorCode`) VALUES
('Contact with lab-confirmed COVID-19 case (in US)'),
('Contact with lab-confirmed COVID-19 case (int\'l)'),
('Contact with person testing for COVID-19'),
('Healthcare worker'),
('History in healthcare facility (patient/visitor)'),
('None'),
('Other'),
('Recently traveled outside city of residence');

-- --------------------------------------------------------

--
-- Table structure for table `RiskFactorCase`
--

CREATE TABLE `RiskFactorCase` (
  `caseID` int(11) NOT NULL,
  `riskFactorCode` varchar(50) NOT NULL,
  `RiskFactorNote` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `RiskFactorCase`
--

INSERT INTO `RiskFactorCase` (`caseID`, `riskFactorCode`, `RiskFactorNote`) VALUES
(1, 'Recently traveled outside city of residence', NULL),
(2, 'Contact with lab-confirmed COVID-19 case (in US)', NULL),
(3, 'Contact with person testing for COVID-19', NULL),
(4, 'Contact with lab-confirmed COVID-19 case (in US)', 'Specified contact\'s results confirmed null for COVID-19'),
(5, 'Healthcare worker', 'Working in direct contact with COVID-19 patients for a week.'),
(6, 'Contact with lab-confirmed COVID-19 case (int\'l)', NULL),
(7, 'Other', NULL),
(8, 'Contact with lab-confirmed COVID-19 case (in US)', NULL),
(9, 'None', NULL),
(10, 'History in healthcare facility (patient/visitor)', 'Inpatient at a local hospital with known COVID-19 cases from July 20, 2020 to July 22, 2020 for other health-related issues.');

-- --------------------------------------------------------

--
-- Table structure for table `Sex`
--

CREATE TABLE `Sex` (
  `sexCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Sex`
--

INSERT INTO `Sex` (`sexCode`) VALUES
('Female'),
('Male'),
('Not specified'),
('Other'),
('Unknown');

-- --------------------------------------------------------

--
-- Table structure for table `State`
--

CREATE TABLE `State` (
  `stateCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `State`
--

INSERT INTO `State` (`stateCode`) VALUES
('AL'),
('OR'),
('Other'),
('WA');

-- --------------------------------------------------------

--
-- Table structure for table `Symptom`
--

CREATE TABLE `Symptom` (
  `symptomCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Symptom`
--

INSERT INTO `Symptom` (`symptomCode`) VALUES
('Abdominal pain'),
('Chest pain'),
('Chills'),
('Cough'),
('Diarrhea'),
('Difficulty breathing'),
('Fatigue'),
('Fever'),
('Headache'),
('Muscle aches (myalgia)'),
('Nausea or vomiting'),
('New loss of taste or smell'),
('Rigors'),
('Runny nose (rhinorrhea)'),
('Shortness of breath (dyspnea)'),
('Sore throat'),
('Subjective fever'),
('Wheezing');

-- --------------------------------------------------------

--
-- Table structure for table `Test`
--

CREATE TABLE `Test` (
  `caseID` int(11) NOT NULL,
  `organizationID` int(11) NOT NULL,
  `testCode` varchar(50) NOT NULL,
  `testID` int(11) NOT NULL,
  `result` bit(1) DEFAULT NULL,
  `testNote` varchar(255) DEFAULT NULL,
  `collectionDate` date DEFAULT NULL,
  `sentDate` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Test`
--

INSERT INTO `Test` (`caseID`, `organizationID`, `testCode`, `testID`, `result`, `testNote`, `collectionDate`, `sentDate`) VALUES
(1, 9, 'COVID-19', 1, b'0', NULL, '2020-07-10', '2020-07-11'),
(2, 9, 'COVID-19', 2, b'1', NULL, '2020-07-07', '2020-07-07'),
(3, 10, 'COVID-19', 3, b'1', NULL, '2020-08-05', '2020-08-07'),
(4, 3, 'Flu', 4, b'1', 'Shows minor flu symptoms not synonymous with COVID-19 symptoms', '2020-08-05', '2020-08-07'),
(5, 7, 'H.metapneumovirus', 5, b'0', NULL, '2020-07-28', '2020-07-30'),
(6, 3, 'COVID-19', 6, b'1', 'Patient already exhibiting extreme COVID-19 symptoms', '2020-07-01', '2020-07-02'),
(7, 10, 'COVID-19', 7, b'1', NULL, '2020-07-11', '2020-07-13'),
(8, 10, 'COVID-19', 8, b'1', NULL, '2020-07-27', '2020-07-28'),
(9, 10, 'Flu', 9, b'1', NULL, '2020-07-15', '2020-07-15'),
(10, 7, 'COVID-19', 10, b'0', NULL, '2020-07-29', '2020-07-30'),
(11, 7, 'Flu', 11, b'0', NULL, '2020-07-13', '2020-07-14');

-- --------------------------------------------------------

--
-- Table structure for table `TestType`
--

CREATE TABLE `TestType` (
  `testCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TestType`
--

INSERT INTO `TestType` (`testCode`) VALUES
('Adenovirus'),
('C.pneumoniae'),
('COVID-19'),
('Flu'),
('H.metapneumovirus'),
('M.pneumoniae'),
('Other');

-- --------------------------------------------------------

--
-- Table structure for table `UnderlyingConditoon`
--

CREATE TABLE `UnderlyingConditoon` (
  `underlyingConfitionCode` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UnderlyingConditoon`
--

INSERT INTO `UnderlyingConditoon` (`underlyingConfitionCode`) VALUES
('Cardiovascular disease'),
('Chronic lung disease'),
('Current Smoker'),
('Diabetes'),
('Disability'),
('Former Smoker'),
('Hypertension'),
('Immunodeficiency (including HIV)'),
('Liver disease'),
('Malignancy'),
('Other'),
('Post-partum (< 6 weeks)'),
('Pregnancy'),
('Psychological/psychiatric condition'),
('Renal disease'),
('Substance abuse or misuse');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CaseSymptom`
--
ALTER TABLE `CaseSymptom`
  ADD PRIMARY KEY (`caseID`,`symptomCode`),
  ADD KEY `Symptom_CaseSymptom_FK1` (`symptomCode`);

--
-- Indexes for table `CaseTable`
--
ALTER TABLE `CaseTable`
  ADD PRIMARY KEY (`caseID`),
  ADD KEY `Person_CaseTable_FK1` (`personID`),
  ADD KEY `Death_CaseTable_FK1` (`deathDateID`),
  ADD KEY `Location_CaseTable_FK1` (`locationID`),
  ADD KEY `Organization_CaseTable_FK1` (`occupationID`);

--
-- Indexes for table `CaseUnderlyingCondition`
--
ALTER TABLE `CaseUnderlyingCondition`
  ADD PRIMARY KEY (`caseID`,`underlyingConfitionCode`),
  ADD KEY `UnderlyingConditoon_CaseUnderlyingCondition_FK1` (`underlyingConfitionCode`);

--
-- Indexes for table `ContactPeriod`
--
ALTER TABLE `ContactPeriod`
  ADD PRIMARY KEY (`contactPeriodID`),
  ADD KEY `Location_ContactPeriod_FK1` (`locationID`);

--
-- Indexes for table `ContactPerson`
--
ALTER TABLE `ContactPerson`
  ADD PRIMARY KEY (`contactPeriodID`,`personID`),
  ADD KEY `Person_ContactPerson_FK1` (`personID`);

--
-- Indexes for table `Country`
--
ALTER TABLE `Country`
  ADD PRIMARY KEY (`countryCode`);

--
-- Indexes for table `CovidReport`
--
ALTER TABLE `CovidReport`
  ADD PRIMARY KEY (`reportID`),
  ADD KEY `CaseTable_CovidReport_FK1` (`caseID`),
  ADD KEY `Organization_CovidReport_FK1` (`organizationID`);

--
-- Indexes for table `CovidReportPerson`
--
ALTER TABLE `CovidReportPerson`
  ADD PRIMARY KEY (`personID`,`reportID`),
  ADD KEY `CovidReport_CovidReportPerson_FK1` (`reportID`);

--
-- Indexes for table `CovidReportPersonRole`
--
ALTER TABLE `CovidReportPersonRole`
  ADD PRIMARY KEY (`reportID`,`personID`,`roleCode`),
  ADD KEY `PersonRole_CovidReportPersonRole_FK1` (`roleCode`);

--
-- Indexes for table `Death`
--
ALTER TABLE `Death`
  ADD PRIMARY KEY (`deathDateID`);

--
-- Indexes for table `Ethnicity`
--
ALTER TABLE `Ethnicity`
  ADD PRIMARY KEY (`ethnicityCode`);

--
-- Indexes for table `Location`
--
ALTER TABLE `Location`
  ADD PRIMARY KEY (`locationID`),
  ADD KEY `Country_Location_FK1` (`countryCode`),
  ADD KEY `State_Location_FK1` (`stateCode`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`organizationID`),
  ADD KEY `OrganizationType_Organization_FK1` (`organizationCode`),
  ADD KEY `Location_Organization_FK1` (`locationID`);

--
-- Indexes for table `OrganizationType`
--
ALTER TABLE `OrganizationType`
  ADD PRIMARY KEY (`organizationCode`);

--
-- Indexes for table `Person`
--
ALTER TABLE `Person`
  ADD PRIMARY KEY (`personID`),
  ADD KEY `Sex_Person_FK1` (`sexCode`),
  ADD KEY `Organization_Person_FK1` (`organizationID`),
  ADD KEY `Death_Person_FK1` (`deathDateID`),
  ADD KEY `Location_Person_FK1` (`locationID`);

--
-- Indexes for table `PersonEthnicity`
--
ALTER TABLE `PersonEthnicity`
  ADD PRIMARY KEY (`personID`,`ethnicityCode`),
  ADD KEY `Ethnicity_PersonEthnicity_FK1` (`ethnicityCode`);

--
-- Indexes for table `PersonRace`
--
ALTER TABLE `PersonRace`
  ADD PRIMARY KEY (`personID`,`raceCode`),
  ADD KEY `Race_PersonRace_FK1` (`raceCode`);

--
-- Indexes for table `PersonRole`
--
ALTER TABLE `PersonRole`
  ADD PRIMARY KEY (`roleCode`);

--
-- Indexes for table `Race`
--
ALTER TABLE `Race`
  ADD PRIMARY KEY (`raceCode`);

--
-- Indexes for table `RiskFactor`
--
ALTER TABLE `RiskFactor`
  ADD PRIMARY KEY (`riskFactorCode`);

--
-- Indexes for table `RiskFactorCase`
--
ALTER TABLE `RiskFactorCase`
  ADD PRIMARY KEY (`caseID`,`riskFactorCode`),
  ADD KEY `RiskFactor_RiskFactorCase_FK1` (`riskFactorCode`);

--
-- Indexes for table `Sex`
--
ALTER TABLE `Sex`
  ADD PRIMARY KEY (`sexCode`);

--
-- Indexes for table `State`
--
ALTER TABLE `State`
  ADD PRIMARY KEY (`stateCode`);

--
-- Indexes for table `Symptom`
--
ALTER TABLE `Symptom`
  ADD PRIMARY KEY (`symptomCode`);

--
-- Indexes for table `Test`
--
ALTER TABLE `Test`
  ADD PRIMARY KEY (`testID`),
  ADD KEY `TestType_Test_FK1` (`testCode`),
  ADD KEY `Organization_Test_FK1` (`organizationID`),
  ADD KEY `CaseTable_Test_FK1` (`caseID`);

--
-- Indexes for table `TestType`
--
ALTER TABLE `TestType`
  ADD PRIMARY KEY (`testCode`);

--
-- Indexes for table `UnderlyingConditoon`
--
ALTER TABLE `UnderlyingConditoon`
  ADD PRIMARY KEY (`underlyingConfitionCode`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CaseTable`
--
ALTER TABLE `CaseTable`
  MODIFY `caseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `ContactPeriod`
--
ALTER TABLE `ContactPeriod`
  MODIFY `contactPeriodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `CovidReport`
--
ALTER TABLE `CovidReport`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Death`
--
ALTER TABLE `Death`
  MODIFY `deathDateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `Location`
--
ALTER TABLE `Location`
  MODIFY `locationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `organizationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Person`
--
ALTER TABLE `Person`
  MODIFY `personID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Test`
--
ALTER TABLE `Test`
  MODIFY `testID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
