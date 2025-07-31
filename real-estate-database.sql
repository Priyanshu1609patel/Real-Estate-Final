-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2025 at 12:17 PM
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
-- Database: `real-estate-database`
--

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL,
  `rarity` varchar(20) DEFAULT 'common',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`id`, `name`, `category`, `rarity`, `description`, `created_at`) VALUES
(1, 'Swimming Pool', 'lifestyle', 'common', 'Olympic-sized swimming pool with separate kids pool', '2025-07-15 07:17:30'),
(2, 'Gym - Indoor', 'lifestyle', 'common', 'Fully equipped indoor gymnasium with modern equipment', '2025-07-15 07:17:30'),
(3, 'Gym - Outdoor', 'lifestyle', 'common', 'Outdoor fitness area with specialized equipment', '2025-07-15 07:17:30'),
(4, 'Kids Play Area', 'lifestyle', 'common', 'Dedicated play area for children with safe equipment', '2025-07-15 07:17:30'),
(5, 'Jacuzzi', 'lifestyle', 'common', 'Relaxing jacuzzi facility within the clubhouse', '2025-07-15 07:17:30'),
(6, 'Sauna', 'lifestyle', 'rare', 'Premium sauna facility for relaxation and wellness', '2025-07-15 07:17:30'),
(7, 'Library', 'lifestyle', 'rare', 'Well-stocked library with reading rooms and study areas', '2025-07-15 07:17:30'),
(8, 'Cafe/Restaurant', 'lifestyle', 'common', 'On-site cafe and restaurant for dining convenience', '2025-07-15 07:17:30'),
(9, 'Salon', 'lifestyle', 'common', 'Professional salon services within the premises', '2025-07-15 07:17:30'),
(10, 'Play School', 'lifestyle', 'common', 'On-site play school for early childhood education', '2025-07-15 07:17:30'),
(11, 'Heated Pool', 'lifestyle', 'common', 'Temperature-controlled pool for year-round swimming', '2025-07-15 07:17:30'),
(12, 'Supermarket', 'lifestyle', 'common', 'Convenient supermarket for daily essentials', '2025-07-15 07:17:30'),
(13, 'Pharmacy/Clinic', 'lifestyle', 'common', 'Medical facility with pharmacy for healthcare needs', '2025-07-15 07:17:30'),
(14, 'Pet Park', 'lifestyle', 'rare', 'Dedicated area for pets with grooming facilities', '2025-07-15 07:17:30'),
(15, 'Amphitheatre', 'lifestyle', 'rare', 'Outdoor amphitheatre for community events and performances', '2025-07-15 07:17:30'),
(16, 'Running Track', 'sports', 'common', 'Jogging and running track around the property', '2025-07-15 07:17:30'),
(17, 'Basketball', 'sports', 'common', 'Full-size basketball court with professional markings', '2025-07-15 07:17:30'),
(18, 'Badminton', 'sports', 'rare', 'Indoor badminton courts with professional flooring', '2025-07-15 07:17:30'),
(19, 'Cricket Pitch', 'sports', 'common', 'Practice cricket pitch for sports enthusiasts', '2025-07-15 07:17:30'),
(20, 'Cricket Ground', 'sports', 'common', 'Full-size cricket ground for matches and practice', '2025-07-15 07:17:30'),
(21, 'Football Ground', 'sports', 'common', 'Football field with proper goal posts and markings', '2025-07-15 07:17:30'),
(22, 'Squash', 'sports', 'common', 'Professional squash courts with proper lighting', '2025-07-15 07:17:30'),
(23, 'Skating', 'sports', 'rare', 'Skating rink for recreational and sports activities', '2025-07-15 07:17:30'),
(24, 'Lawn Tennis', 'sports', 'common', 'Professional tennis courts with proper surfacing', '2025-07-15 07:17:30'),
(25, 'Volleyball Net', 'sports', 'common', 'Volleyball court with net and proper ground markings', '2025-07-15 07:17:30'),
(26, 'Park Area', 'natural', 'common', 'Landscaped park areas with walking paths and seating', '2025-07-15 07:17:30'),
(27, 'Lake', 'natural', 'rare', 'Natural or artificial lake within or near the property', '2025-07-15 07:17:30'),
(28, 'Forest', 'natural', 'rare', 'Forested area providing natural green cover', '2025-07-15 07:17:30'),
(29, 'Army Land', 'natural', 'rare', 'Adjacent army land ensuring no future construction', '2025-07-15 07:17:30'),
(30, 'Mountain/Hill', 'natural', 'rare', 'Scenic mountain or hill views from the property', '2025-07-15 07:17:30'),
(31, 'Golf Course', 'natural', 'rare', 'Professional golf course or driving range facility', '2025-07-15 07:17:30'),
(32, 'Swimming Pool', 'lifestyle', 'common', 'Olympic-sized swimming pool with separate kids pool', '2025-07-15 07:17:58'),
(33, 'Gym - Indoor', 'lifestyle', 'common', 'Fully equipped indoor gymnasium with modern equipment', '2025-07-15 07:17:58'),
(34, 'Gym - Outdoor', 'lifestyle', 'common', 'Outdoor fitness area with specialized equipment', '2025-07-15 07:17:58'),
(35, 'Kids Play Area', 'lifestyle', 'common', 'Dedicated play area for children with safe equipment', '2025-07-15 07:17:58'),
(36, 'Jacuzzi', 'lifestyle', 'common', 'Relaxing jacuzzi facility within the clubhouse', '2025-07-15 07:17:58'),
(37, 'Sauna', 'lifestyle', 'rare', 'Premium sauna facility for relaxation and wellness', '2025-07-15 07:17:58'),
(38, 'Library', 'lifestyle', 'rare', 'Well-stocked library with reading rooms and study areas', '2025-07-15 07:17:58'),
(39, 'Cafe/Restaurant', 'lifestyle', 'common', 'On-site cafe and restaurant for dining convenience', '2025-07-15 07:17:58'),
(40, 'Salon', 'lifestyle', 'common', 'Professional salon services within the premises', '2025-07-15 07:17:58'),
(41, 'Play School', 'lifestyle', 'common', 'On-site play school for early childhood education', '2025-07-15 07:17:58'),
(42, 'Heated Pool', 'lifestyle', 'common', 'Temperature-controlled pool for year-round swimming', '2025-07-15 07:17:58'),
(43, 'Supermarket', 'lifestyle', 'common', 'Convenient supermarket for daily essentials', '2025-07-15 07:17:58'),
(44, 'Pharmacy/Clinic', 'lifestyle', 'common', 'Medical facility with pharmacy for healthcare needs', '2025-07-15 07:17:58'),
(45, 'Pet Park', 'lifestyle', 'rare', 'Dedicated area for pets with grooming facilities', '2025-07-15 07:17:58'),
(46, 'Amphitheatre', 'lifestyle', 'rare', 'Outdoor amphitheatre for community events and performances', '2025-07-15 07:17:58'),
(47, 'Running Track', 'sports', 'common', 'Jogging and running track around the property', '2025-07-15 07:17:58'),
(48, 'Basketball', 'sports', 'common', 'Full-size basketball court with professional markings', '2025-07-15 07:17:58'),
(49, 'Badminton', 'sports', 'rare', 'Indoor badminton courts with professional flooring', '2025-07-15 07:17:58'),
(50, 'Cricket Pitch', 'sports', 'common', 'Practice cricket pitch for sports enthusiasts', '2025-07-15 07:17:58'),
(51, 'Cricket Ground', 'sports', 'common', 'Full-size cricket ground for matches and practice', '2025-07-15 07:17:58'),
(52, 'Football Ground', 'sports', 'common', 'Football field with proper goal posts and markings', '2025-07-15 07:17:58'),
(53, 'Squash', 'sports', 'common', 'Professional squash courts with proper lighting', '2025-07-15 07:17:58'),
(54, 'Skating', 'sports', 'rare', 'Skating rink for recreational and sports activities', '2025-07-15 07:17:58'),
(55, 'Lawn Tennis', 'sports', 'common', 'Professional tennis courts with proper surfacing', '2025-07-15 07:17:58'),
(56, 'Volleyball Net', 'sports', 'common', 'Volleyball court with net and proper ground markings', '2025-07-15 07:17:58'),
(57, 'Park Area', 'natural', 'common', 'Landscaped park areas with walking paths and seating', '2025-07-15 07:17:58'),
(58, 'Lake', 'natural', 'rare', 'Natural or artificial lake within or near the property', '2025-07-15 07:17:58'),
(59, 'Forest', 'natural', 'rare', 'Forested area providing natural green cover', '2025-07-15 07:17:58'),
(60, 'Army Land', 'natural', 'rare', 'Adjacent army land ensuring no future construction', '2025-07-15 07:17:58'),
(61, 'Mountain/Hill', 'natural', 'rare', 'Scenic mountain or hill views from the property', '2025-07-15 07:17:58'),
(62, 'Golf Course', 'natural', 'rare', 'Professional golf course or driving range facility', '2025-07-15 07:17:58'),
(63, 'Box Cricket', 'Outdoor', 'rare', 'bhghgn', '2025-07-15 10:23:36');

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `severity` varchar(20) DEFAULT 'medium',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`id`, `name`, `category`, `description`, `severity`, `created_at`) VALUES
(1, 'Nala / Drain', 'infrastructure', 'Presence of open drains or nalas that may cause flooding during heavy rains and hygiene issues', 'medium', '2025-07-15 07:17:30'),
(2, 'Traffic Congestion', 'connectivity', 'Heavy traffic during peak hours affecting commute times', 'medium', '2025-07-15 07:17:30'),
(3, 'Water Logging', 'infrastructure', 'Potential water logging during monsoon season', 'medium', '2025-07-15 07:17:30'),
(4, 'Construction Dust', 'environmental', 'Dust and noise from ongoing construction activities in the area', 'low', '2025-07-15 07:17:30'),
(5, 'Limited Public Transport', 'connectivity', 'Limited public transportation options affecting daily commute', 'medium', '2025-07-15 07:17:30'),
(6, 'Power Outages', 'infrastructure', 'Frequent power cuts affecting daily life', 'low', '2025-07-15 07:17:30'),
(7, 'Waste Management', 'environmental', 'Inadequate waste management systems in the locality', 'medium', '2025-07-15 07:17:30'),
(8, 'Road Conditions', 'infrastructure', 'Poor road conditions leading to property accessibility issues', 'medium', '2025-07-15 07:17:30'),
(9, 'Nala / Drain', 'infrastructure', 'Presence of open drains or nalas that may cause flooding during heavy rains and hygiene issues', 'medium', '2025-07-15 07:17:58'),
(10, 'Traffic Congestion', 'connectivity', 'Heavy traffic during peak hours affecting commute times', 'medium', '2025-07-15 07:17:58'),
(11, 'Water Logging', 'infrastructure', 'Potential water logging during monsoon season', 'medium', '2025-07-15 07:17:58'),
(12, 'Construction Dust', 'environmental', 'Dust and noise from ongoing construction activities in the area', 'low', '2025-07-15 07:17:58'),
(13, 'Limited Public Transport', 'connectivity', 'Limited public transportation options affecting daily commute', 'medium', '2025-07-15 07:17:58'),
(14, 'Power Outages', 'infrastructure', 'Frequent power cuts affecting daily life', 'low', '2025-07-15 07:17:58'),
(15, 'Waste Management', 'environmental', 'Inadequate waste management systems in the locality', 'medium', '2025-07-15 07:17:58'),
(16, 'Road Conditions', 'infrastructure', 'Poor road conditions leading to property accessibility issues', 'medium', '2025-07-15 07:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `developers`
--

CREATE TABLE `developers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `established_year` int(11) DEFAULT NULL,
  `completed_projects` int(11) DEFAULT NULL,
  `total_sqft_delivered` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `developers`
--

INSERT INTO `developers` (`id`, `name`, `established_year`, `completed_projects`, `total_sqft_delivered`, `description`, `specialization`, `website_url`, `created_at`, `updated_at`) VALUES
(1, 'Lodha Developers', 1980, 95, '95 million sq. ft.', 'Founded in 1980, Lodha Developers is synonymous with luxury and innovation in real estate. With over 95 million sq. ft. delivered, the company has consistently delivered high-quality developments across residential, commercial, and hospitality sectors. Flagship projects like Lodha Park, Lodha Amara, and Lodha Venezia reflect their focus on premium living spaces. The company emphasizes sustainability through energy-efficient construction, water recycling, and green building certifications. With a legacy of excellence, Lodha Developers remains a trusted name in India\'s real estate landscape.', 'Luxury residential and commercial developments', 'https://www.lodhagroup.com', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(2, 'Assetz Property', 2006, 20, '10 million sq. ft.', 'Founded in 2006, Assetz Property Group is known for its unique design philosophy and sustainable developments. With over 20 projects and 10 million sq. ft. of space developed, the company specializes in premium residential and mixed-use spaces.', 'Premium residential and mixed-use developments', 'https://www.assetzproperty.com', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(3, 'Ranka Group', 1984, NULL, '10 million sq. ft.', 'Established in 1984, Ranka Group is a legacy developer renowned for its landmark residential and commercial projects. With over 10 million sq. ft. delivered, the company has redefined luxury and innovation in real estate.', 'Community-focused integrated spaces', 'https://www.rankagroup.com', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(4, 'Ganesh Glory', 2024, 2, '10K sq. ft.', 'hhjkhjk', 'commercial', 'ganeshglory.com', '2025-07-15 09:48:55', '2025-07-17 10:43:35');

-- --------------------------------------------------------

--
-- Table structure for table `financial_details`
--

CREATE TABLE `financial_details` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `base_price_per_sqft` decimal(10,2) DEFAULT NULL,
  `premium_charges_per_sqft` decimal(10,2) DEFAULT NULL,
  `total_charges_per_sqft` decimal(10,2) DEFAULT NULL,
  `registration_percentage` decimal(5,2) DEFAULT NULL,
  `gst_percentage` decimal(5,2) DEFAULT NULL,
  `maintenance_per_sqft` decimal(8,2) DEFAULT NULL,
  `corpus_fund_per_sqft` decimal(8,2) DEFAULT NULL,
  `parking_charges` decimal(10,2) DEFAULT NULL,
  `total_other_charges` decimal(12,2) DEFAULT NULL,
  `loan_eligibility_percentage` decimal(5,2) DEFAULT NULL,
  `preferred_banks` text DEFAULT NULL,
  `emi_example_tenure` int(11) DEFAULT NULL,
  `emi_example_amount` decimal(10,2) DEFAULT NULL,
  `roi_potential_percentage` decimal(5,2) DEFAULT NULL,
  `rental_yield_percentage` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `financial_details`
--

INSERT INTO `financial_details` (`id`, `property_id`, `base_price_per_sqft`, `premium_charges_per_sqft`, `total_charges_per_sqft`, `registration_percentage`, `gst_percentage`, `maintenance_per_sqft`, `corpus_fund_per_sqft`, `parking_charges`, `total_other_charges`, `loan_eligibility_percentage`, `preferred_banks`, `emi_example_tenure`, `emi_example_amount`, `roi_potential_percentage`, `rental_yield_percentage`, `created_at`, `updated_at`) VALUES
(1, 1, 5800.00, 500.00, 6300.00, 7.00, 5.00, 4.50, 2.00, 250000.00, 450000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 20, 45000.00, 12.00, 4.20, '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(2, 2, 4800.00, 400.00, 5200.00, 7.00, 5.00, 3.80, 1.50, 200000.00, 380000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank', 20, 35000.00, 10.00, 3.80, '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(3, 3, 3600.00, 300.00, 3900.00, 7.00, 5.00, 3.20, 1.20, 150000.00, 280000.00, 80.00, 'SBI, HDFC, ICICI, Canara Bank', 20, 25000.00, 8.00, 3.50, '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(4, 1, 5800.00, 500.00, 6300.00, 7.00, 5.00, 4.50, 2.00, 250000.00, 450000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 20, 45000.00, 12.00, 4.20, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(5, 2, 4800.00, 400.00, 5200.00, 7.00, 5.00, 3.80, 1.50, 200000.00, 380000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank', 20, 35000.00, 10.00, 3.80, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(6, 3, 3600.00, 300.00, 3900.00, 7.00, 5.00, 3.20, 1.20, 150000.00, 280000.00, 80.00, 'SBI, HDFC, ICICI, Canara Bank', 20, 25000.00, 8.00, 3.50, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(7, 1, 5800.00, 500.00, 6300.00, 7.00, 5.00, 4.50, 2.00, 250000.00, 450000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 20, 45000.00, 12.00, 4.20, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(8, 2, 4800.00, 400.00, 5200.00, 7.00, 5.00, 3.80, 1.50, 200000.00, 380000.00, 80.00, 'SBI, HDFC, ICICI, Axis Bank', 20, 35000.00, 10.00, 3.80, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(9, 3, 3600.00, 300.00, 3900.00, 7.00, 5.00, 3.20, 1.20, 150000.00, 280000.00, 80.00, 'SBI, HDFC, ICICI, Canara Bank', 20, 25000.00, 8.00, 3.50, '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `investment_analysis`
--

CREATE TABLE `investment_analysis` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `investment_type` varchar(50) DEFAULT NULL,
  `entry_cost` decimal(12,2) DEFAULT NULL,
  `annual_rental_income` decimal(12,2) DEFAULT NULL,
  `annual_appreciation` decimal(12,2) DEFAULT NULL,
  `maintenance_cost` decimal(12,2) DEFAULT NULL,
  `total_returns_5year` decimal(12,2) DEFAULT NULL,
  `irr_percentage` decimal(5,2) DEFAULT NULL,
  `payback_period_years` int(11) DEFAULT NULL,
  `risk_assessment` varchar(50) DEFAULT NULL,
  `liquidity_rating` varchar(20) DEFAULT NULL,
  `tax_benefits` text DEFAULT NULL,
  `investment_grade` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `investment_analysis`
--

INSERT INTO `investment_analysis` (`id`, `property_id`, `investment_type`, `entry_cost`, `annual_rental_income`, `annual_appreciation`, `maintenance_cost`, `total_returns_5year`, `irr_percentage`, `payback_period_years`, `risk_assessment`, `liquidity_rating`, `tax_benefits`, `investment_grade`, `created_at`, `updated_at`) VALUES
(1, 1, 'Premium Residential', 8500000.00, 360000.00, 510000.00, 135000.00, 14500000.00, 14.20, 12, 'Low-Medium', 'High', 'Section 80C, Section 24', 'A', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(2, 2, 'Mid-Premium Residential', 6500000.00, 280000.00, 390000.00, 110000.00, 10200000.00, 12.80, 14, 'Medium', 'Medium-High', 'Section 80C, Section 24', 'B+', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(3, 3, 'Affordable Premium', 4200000.00, 180000.00, 210000.00, 75000.00, 6800000.00, 10.50, 16, 'Medium', 'Medium', 'Section 80C, Section 24', 'B', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(4, 1, 'Premium Residential', 8500000.00, 360000.00, 510000.00, 135000.00, 14500000.00, 14.20, 12, 'Low-Medium', 'High', 'Section 80C, Section 24', 'A', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(5, 2, 'Mid-Premium Residential', 6500000.00, 280000.00, 390000.00, 110000.00, 10200000.00, 12.80, 14, 'Medium', 'Medium-High', 'Section 80C, Section 24', 'B+', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(6, 3, 'Affordable Premium', 4200000.00, 180000.00, 210000.00, 75000.00, 6800000.00, 10.50, 16, 'Medium', 'Medium', 'Section 80C, Section 24', 'B', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(7, 1, 'Premium Residential', 8500000.00, 360000.00, 510000.00, 135000.00, 14500000.00, 14.20, 12, 'Low-Medium', 'High', 'Section 80C, Section 24', 'A', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(8, 2, 'Mid-Premium Residential', 6500000.00, 280000.00, 390000.00, 110000.00, 10200000.00, 12.80, 14, 'Medium', 'Medium-High', 'Section 80C, Section 24', 'B+', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(9, 3, 'Affordable Premium', 4200000.00, 180000.00, 210000.00, 75000.00, 6800000.00, 10.50, 16, 'Medium', 'Medium', 'Section 80C, Section 24', 'B', '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `legal_details`
--

CREATE TABLE `legal_details` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `rera_registration` varchar(100) DEFAULT NULL,
  `commencement_certificate` varchar(50) DEFAULT NULL,
  `occupancy_certificate` varchar(50) DEFAULT NULL,
  `approved_plan` varchar(100) DEFAULT NULL,
  `deviation_status` varchar(50) DEFAULT NULL,
  `litigation_status` varchar(50) DEFAULT NULL,
  `title_verification` varchar(50) DEFAULT NULL,
  `bank_approvals` text DEFAULT NULL,
  `insurance_coverage` varchar(100) DEFAULT NULL,
  `compliance_status` varchar(50) DEFAULT NULL,
  `legal_opinion` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `legal_details`
--

INSERT INTO `legal_details` (`id`, `property_id`, `rera_registration`, `commencement_certificate`, `occupancy_certificate`, `approved_plan`, `deviation_status`, `litigation_status`, `title_verification`, `bank_approvals`, `insurance_coverage`, `compliance_status`, `legal_opinion`, `created_at`, `updated_at`) VALUES
(1, 1, 'PRM/KA/RERA/1251/309/PR/010819/002429', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 'Comprehensive Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(2, 2, 'PRM/KA/RERA/1251/309/PR/171018/001756', 'Approved', 'Pending', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank', 'Comprehensive Insurance', 'Compliant', 'Legally Clear', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(3, 3, 'PRM/KA/RERA/1251/309/PR/180619/002156', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Canara Bank', 'Basic Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(4, 1, 'PRM/KA/RERA/1251/309/PR/010819/002429', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 'Comprehensive Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(5, 2, 'PRM/KA/RERA/1251/309/PR/171018/001756', 'Approved', 'Pending', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank', 'Comprehensive Insurance', 'Compliant', 'Legally Clear', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(6, 3, 'PRM/KA/RERA/1251/309/PR/180619/002156', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Canara Bank', 'Basic Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(7, 1, 'PRM/KA/RERA/1251/309/PR/010819/002429', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 'Comprehensive Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(8, 2, 'PRM/KA/RERA/1251/309/PR/171018/001756', 'Approved', 'Pending', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank', 'Comprehensive Insurance', 'Compliant', 'Legally Clear', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(9, 3, 'PRM/KA/RERA/1251/309/PR/180619/002156', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Canara Bank', 'Basic Insurance', 'Fully Compliant', 'Legally Clear', '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `area_name` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `market_average_price_per_sqft` decimal(10,2) DEFAULT NULL,
  `market_average_clubhouse_factor` decimal(5,2) DEFAULT NULL,
  `coordinates_lat` decimal(10,8) DEFAULT NULL,
  `coordinates_lng` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `area_name`, `city`, `state`, `pincode`, `description`, `market_average_price_per_sqft`, `market_average_clubhouse_factor`, `coordinates_lat`, `coordinates_lng`, `created_at`) VALUES
(1, 'Thanisandra Road', 'Bengaluru', 'Karnataka', '560064', 'Thanisandra Road, situated in North Bengaluru, is a key residential and commercial corridor. The area has witnessed significant development in recent years, making it a popular choice for both homebuyers and investors. Close to Manyata Tech Park and with excellent connectivity to ORR. The area is developing rapidly with new infrastructure projects and is becoming a preferred residential destination.', 11967.00, 44.45, 13.04950000, 77.60510000, '2025-07-15 07:17:12'),
(2, 'Jakkur', 'Bengaluru', 'Karnataka', '560064', 'Jakkur, located in North Bengaluru, is a peaceful locality known for its expansive green spaces, lakes, and residential properties. The area is attracting more homebuyers due to its proximity to tech parks and schools.', 12000.00, 45.00, 13.08270000, 77.59460000, '2025-07-15 07:17:12'),
(3, 'Manyata Tech Park', 'Bengaluru', 'Karnataka', '560045', 'Manyata Tech Park is one of the largest IT parks in India, housing major tech companies and serving as a major employment hub in North Bengaluru.', 13500.00, 40.00, 13.04950000, 77.60510000, '2025-07-15 07:17:12'),
(4, 'Jagatpur', 'Ahmedabad', 'Gujarat', '382415', 'hhjkhjk', 12000.00, 45.00, 2.00000000, 3.00000000, '2025-07-15 09:55:04');

-- --------------------------------------------------------

--
-- Table structure for table `market_analysis`
--

CREATE TABLE `market_analysis` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `current_avg_price_per_sqft` decimal(10,2) DEFAULT NULL,
  `price_appreciation_1year` decimal(5,2) DEFAULT NULL,
  `price_appreciation_3year` decimal(5,2) DEFAULT NULL,
  `price_appreciation_5year` decimal(5,2) DEFAULT NULL,
  `demand_supply_ratio` decimal(5,2) DEFAULT NULL,
  `inventory_months` int(11) DEFAULT NULL,
  `similar_properties_count` int(11) DEFAULT NULL,
  `market_segment` varchar(50) DEFAULT NULL,
  `buyer_profile` text DEFAULT NULL,
  `resale_potential` varchar(20) DEFAULT NULL,
  `rental_demand` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `market_analysis`
--

INSERT INTO `market_analysis` (`id`, `property_id`, `current_avg_price_per_sqft`, `price_appreciation_1year`, `price_appreciation_3year`, `price_appreciation_5year`, `demand_supply_ratio`, `inventory_months`, `similar_properties_count`, `market_segment`, `buyer_profile`, `resale_potential`, `rental_demand`, `created_at`, `updated_at`) VALUES
(1, 1, 6300.00, 8.50, 25.00, 60.00, 1.80, 8, 12, 'Premium', 'IT Professionals, Business Owners, Investors', 'High', 'High', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(2, 2, 5200.00, 6.50, 18.00, 45.00, 1.50, 10, 8, 'Mid-Premium', 'IT Professionals, Young Families', 'Medium-High', 'Medium-High', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(3, 3, 3900.00, 5.00, 15.00, 35.00, 1.20, 12, 15, 'Affordable Premium', 'First-time Buyers, Young Professionals', 'Medium', 'Medium', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(4, 1, 6300.00, 8.50, 25.00, 60.00, 1.80, 8, 12, 'Premium', 'IT Professionals, Business Owners, Investors', 'High', 'High', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(5, 2, 5200.00, 6.50, 18.00, 45.00, 1.50, 10, 8, 'Mid-Premium', 'IT Professionals, Young Families', 'Medium-High', 'Medium-High', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(6, 3, 3900.00, 5.00, 15.00, 35.00, 1.20, 12, 15, 'Affordable Premium', 'First-time Buyers, Young Professionals', 'Medium', 'Medium', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(7, 1, 6300.00, 8.50, 25.00, 60.00, 1.80, 8, 12, 'Premium', 'IT Professionals, Business Owners, Investors', 'High', 'High', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(8, 2, 5200.00, 6.50, 18.00, 45.00, 1.50, 10, 8, 'Mid-Premium', 'IT Professionals, Young Families', 'Medium-High', 'Medium-High', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(9, 3, 3900.00, 5.00, 15.00, 35.00, 1.20, 12, 15, 'Affordable Premium', 'First-time Buyers, Young Professionals', 'Medium', 'Medium', '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `developer_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `property_type` varchar(50) NOT NULL,
  `land_area_acres` decimal(10,2) DEFAULT NULL,
  `land_area_sqft` bigint(20) DEFAULT NULL,
  `total_units` int(11) DEFAULT NULL,
  `total_towers` int(11) DEFAULT NULL,
  `floors_per_tower` int(11) DEFAULT NULL,
  `open_area_percentage` decimal(5,2) DEFAULT NULL,
  `clubhouse_area_sqft` int(11) DEFAULT NULL,
  `clubhouse_factor` int(11) DEFAULT NULL,
  `park_area_acres` decimal(10,2) DEFAULT NULL,
  `unit_density_per_acre` int(11) DEFAULT NULL,
  `closest_metro_distance_km` decimal(5,2) DEFAULT NULL,
  `airport_distance_km` decimal(5,2) DEFAULT NULL,
  `approach_road_width_meters` int(11) DEFAULT NULL,
  `possession_date` date DEFAULT NULL,
  `rera_approved` tinyint(1) DEFAULT 0,
  `rera_registration_number` varchar(255) DEFAULT NULL,
  `rera_approvals_count` int(11) DEFAULT NULL,
  `total_rera_approvals` int(11) DEFAULT NULL,
  `price_per_sqft` decimal(10,2) DEFAULT NULL,
  `min_price` decimal(12,2) DEFAULT NULL,
  `max_price` decimal(12,2) DEFAULT NULL,
  `min_unit_size_sqft` int(11) DEFAULT NULL,
  `max_unit_size_sqft` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Under Construction',
  `propsoch_id` int(11) DEFAULT NULL,
  `project_highlights` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `name`, `developer_id`, `location_id`, `property_type`, `land_area_acres`, `land_area_sqft`, `total_units`, `total_towers`, `floors_per_tower`, `open_area_percentage`, `clubhouse_area_sqft`, `clubhouse_factor`, `park_area_acres`, `unit_density_per_acre`, `closest_metro_distance_km`, `airport_distance_km`, `approach_road_width_meters`, `possession_date`, `rera_approved`, `rera_registration_number`, `rera_approvals_count`, `total_rera_approvals`, `price_per_sqft`, `min_price`, `max_price`, `min_unit_size_sqft`, `max_unit_size_sqft`, `status`, `propsoch_id`, `project_highlights`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Lodha Mirabelle', 1, 1, 'Apartment', 16.00, 696960, 1100, 2, 28, 85.00, 50000, 46, 1.56, 69, 1.32, 28.97, 25, '2028-06-01', 1, 'PRM/KA/RERA/1251/309/PR/131023/006321', 7, 7, 14634.00, 24100000.00, 34700000.00, 1646, 2373, 'Under Construction', 274, 'An urban paradise set across a breathtaking 16-acre ecosystem. Club Luxuria - 50,000 sq. ft. fitness and recreation complex. Located within the developing IT and manufacturing corridor in North Bengaluru. Over 35 indoor and outdoor amenities. Thoughtful architectural design with 85% open area.', 'Placed 28.97km away from the Kempegowda International Airport, Lodha Mirabelle is a fine example of thoughtful architectural design by Lodha Developers. Nestled close to the developing IT and manufacturing corridor in North Bengaluru, Lodha Mirabelle is a tasteful blend of function and aesthetics. Offering an open area of 85%, Lodha Mirabelle has a well designed layout with ample green and open spaces that house the outdoor amenities promoting a healthier lifestyle. The clubhouse factor at Lodha Mirabelle is 46 in comparison to the market average of 44.45 within Thanisandra Road. Slated for possession in 2028, Lodha Mirabelle is set to become a landmark within Thanisandra Road.', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(2, 'Assetz Soho and Sky', 2, 2, 'Apartment', 4.30, 187308, 234, 5, 13, 77.44, 16382, 70, 0.00, 54, 2.77, 27.99, 20, '2026-09-01', 1, 'PRM/KA/RERA/1251/309/PR/131023/006322', 7, 7, 13019.00, 26200000.00, 36400000.00, 2015, 2799, 'Under Construction', 218, 'Modern residential complex with premium amenities and excellent connectivity to tech parks.', 'Modern residential complex with premium amenities and excellent connectivity to tech parks.', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(3, 'Ranka Ankura', 3, 1, 'Apartment', 4.72, 205603, 410, 4, 21, 81.00, 12850, 31, 0.30, 87, 4.53, 22.28, 25, '2029-12-01', 1, 'PRM/KA/RERA/1251/309/PR/131023/006323', 7, 7, 9300.00, 12000000.00, 19300000.00, 1285, 2075, 'Under Construction', 427, 'Community-focused development with integrated amenities and green spaces.', 'Community-focused development with integrated amenities and green spaces.', '2025-07-15 07:17:12', '2025-07-15 07:17:12'),
(4, 'PRIYANSHU', 3, 2, 'flat', 200.00, 2500, 4, 3, 2, 80.00, 10, 1, 12.00, 12, 4.00, 9.00, 130, '2025-07-03', 1, 'ffvsgvresg', 3, 5, 15000.00, 12000.00, 180000.00, 100, 230, 'under_construction', 2, 'ghgj', 'jjhjh', '2025-07-15 10:39:01', '2025-07-15 10:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `property_amenities`
--

CREATE TABLE `property_amenities` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `amenity_id` int(11) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1,
  `area_sqft` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `location_within_property` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_amenities`
--

INSERT INTO `property_amenities` (`id`, `property_id`, `amenity_id`, `available`, `area_sqft`, `capacity`, `location_within_property`, `created_at`) VALUES
(1, 1, 1, 1, 2500, 50, 'Club Luxuria - Main Clubhouse', '2025-07-15 07:17:30'),
(2, 1, 2, 1, 1800, 30, 'Club Luxuria - Ground Floor', '2025-07-15 07:17:30'),
(3, 1, 3, 1, 1200, 20, 'Open Area - Fitness Zone', '2025-07-15 07:17:30'),
(4, 1, 4, 1, 1500, 40, 'Park Area - Central Location', '2025-07-15 07:17:30'),
(5, 1, 5, 1, 200, 8, 'Club Luxuria - Wellness Center', '2025-07-15 07:17:30'),
(6, 1, 6, 1, 300, 10, 'Club Luxuria - Wellness Center', '2025-07-15 07:17:30'),
(7, 1, 7, 1, 800, 25, 'Club Luxuria - Second Floor', '2025-07-15 07:17:30'),
(8, 1, 8, 1, 1200, 60, 'Club Luxuria - Ground Floor', '2025-07-15 07:17:30'),
(9, 1, 9, 1, 400, 10, 'Club Luxuria - Beauty Center', '2025-07-15 07:17:30'),
(10, 1, 10, 1, 1000, 30, 'Residential Block - Ground Floor', '2025-07-15 07:17:30'),
(11, 1, 11, 1, 1500, 30, 'Club Luxuria - Pool Area', '2025-07-15 07:17:30'),
(12, 1, 12, 1, 2000, 100, 'Ground Floor - Retail Area', '2025-07-15 07:17:30'),
(13, 1, 13, 1, 500, 15, 'Ground Floor - Medical Center', '2025-07-15 07:17:30'),
(14, 1, 14, 1, 800, 20, 'Park Area - Designated Zone', '2025-07-15 07:17:30'),
(15, 1, 15, 1, 2000, 200, 'Open Area - Central Location', '2025-07-15 07:17:30'),
(16, 1, 16, 1, 1800, 50, 'Open Area - Perimeter Track', '2025-07-15 07:17:30'),
(17, 1, 17, 1, 500, 10, 'Sports Complex - Court 1', '2025-07-15 07:17:30'),
(18, 1, 18, 1, 400, 8, 'Sports Complex - Indoor Courts', '2025-07-15 07:17:30'),
(19, 1, 19, 1, 300, 20, 'Sports Complex - Practice Area', '2025-07-15 07:17:30'),
(20, 1, 20, 1, 8000, 40, 'Open Area - Sports Ground', '2025-07-15 07:17:30'),
(21, 1, 21, 1, 6000, 30, 'Open Area - Sports Ground', '2025-07-15 07:17:30'),
(22, 1, 22, 1, 200, 4, 'Sports Complex - Court 2', '2025-07-15 07:17:30'),
(23, 1, 23, 1, 1000, 30, 'Sports Complex - Skating Area', '2025-07-15 07:17:30'),
(24, 1, 24, 1, 800, 8, 'Sports Complex - Tennis Courts', '2025-07-15 07:17:30'),
(25, 1, 25, 1, 400, 12, 'Sports Complex - Volleyball Court', '2025-07-15 07:17:30'),
(26, 1, 26, 1, 68000, 500, 'Central Park and Garden Areas', '2025-07-15 07:17:30'),
(27, 1, 27, 1, 20000, 100, 'Adjacent Natural Lake', '2025-07-15 07:17:30'),
(28, 1, 28, 1, 50000, 200, 'Nearby Forest Area', '2025-07-15 07:17:30'),
(29, 1, 29, 1, 100000, 0, 'Adjacent Army Land', '2025-07-15 07:17:30'),
(30, 1, 30, 0, 0, 0, 'Not Available', '2025-07-15 07:17:30'),
(31, 1, 31, 0, 0, 0, 'Not Available', '2025-07-15 07:17:30'),
(32, 2, 1, 1, 1500, 30, 'Main Clubhouse', '2025-07-15 07:17:30'),
(33, 2, 2, 1, 1200, 25, 'Clubhouse - Ground Floor', '2025-07-15 07:17:30'),
(34, 2, 4, 1, 1000, 30, 'Central Garden Area', '2025-07-15 07:17:30'),
(35, 2, 16, 1, 1200, 40, 'Perimeter Track', '2025-07-15 07:17:30'),
(36, 2, 17, 1, 400, 8, 'Sports Area', '2025-07-15 07:17:30'),
(37, 2, 26, 1, 25000, 200, 'Landscaped Gardens', '2025-07-15 07:17:30'),
(38, 3, 1, 1, 1200, 25, 'Community Clubhouse', '2025-07-15 07:17:30'),
(39, 3, 2, 1, 800, 20, 'Clubhouse - Fitness Center', '2025-07-15 07:17:30'),
(40, 3, 4, 1, 800, 25, 'Childrens Play Area', '2025-07-15 07:17:30'),
(41, 3, 16, 1, 800, 30, 'Jogging Track', '2025-07-15 07:17:30'),
(42, 3, 26, 1, 13000, 150, 'Park and Garden Areas', '2025-07-15 07:17:30'),
(43, 1, 1, 1, 2500, 50, 'Club Luxuria - Main Clubhouse', '2025-07-15 07:17:58'),
(44, 1, 2, 1, 1800, 30, 'Club Luxuria - Ground Floor', '2025-07-15 07:17:58'),
(45, 1, 3, 1, 1200, 20, 'Open Area - Fitness Zone', '2025-07-15 07:17:58'),
(46, 1, 4, 1, 1500, 40, 'Park Area - Central Location', '2025-07-15 07:17:58'),
(47, 1, 5, 1, 200, 8, 'Club Luxuria - Wellness Center', '2025-07-15 07:17:58'),
(48, 1, 6, 1, 300, 10, 'Club Luxuria - Wellness Center', '2025-07-15 07:17:58'),
(49, 1, 7, 1, 800, 25, 'Club Luxuria - Second Floor', '2025-07-15 07:17:58'),
(50, 1, 8, 1, 1200, 60, 'Club Luxuria - Ground Floor', '2025-07-15 07:17:58'),
(51, 1, 9, 1, 400, 10, 'Club Luxuria - Beauty Center', '2025-07-15 07:17:58'),
(52, 1, 10, 1, 1000, 30, 'Residential Block - Ground Floor', '2025-07-15 07:17:58'),
(53, 1, 11, 1, 1500, 30, 'Club Luxuria - Pool Area', '2025-07-15 07:17:58'),
(54, 1, 12, 1, 2000, 100, 'Ground Floor - Retail Area', '2025-07-15 07:17:58'),
(55, 1, 13, 1, 500, 15, 'Ground Floor - Medical Center', '2025-07-15 07:17:58'),
(56, 1, 14, 1, 800, 20, 'Park Area - Designated Zone', '2025-07-15 07:17:58'),
(57, 1, 15, 1, 2000, 200, 'Open Area - Central Location', '2025-07-15 07:17:58'),
(58, 1, 16, 1, 1800, 50, 'Open Area - Perimeter Track', '2025-07-15 07:17:58'),
(59, 1, 17, 1, 500, 10, 'Sports Complex - Court 1', '2025-07-15 07:17:58'),
(60, 1, 18, 1, 400, 8, 'Sports Complex - Indoor Courts', '2025-07-15 07:17:58'),
(61, 1, 19, 1, 300, 20, 'Sports Complex - Practice Area', '2025-07-15 07:17:58'),
(62, 1, 20, 1, 8000, 40, 'Open Area - Sports Ground', '2025-07-15 07:17:58'),
(63, 1, 21, 1, 6000, 30, 'Open Area - Sports Ground', '2025-07-15 07:17:58'),
(64, 1, 22, 1, 200, 4, 'Sports Complex - Court 2', '2025-07-15 07:17:58'),
(65, 1, 23, 1, 1000, 30, 'Sports Complex - Skating Area', '2025-07-15 07:17:58'),
(66, 1, 24, 1, 800, 8, 'Sports Complex - Tennis Courts', '2025-07-15 07:17:58'),
(67, 1, 25, 1, 400, 12, 'Sports Complex - Volleyball Court', '2025-07-15 07:17:58'),
(68, 1, 26, 1, 68000, 500, 'Central Park and Garden Areas', '2025-07-15 07:17:58'),
(69, 1, 27, 1, 20000, 100, 'Adjacent Natural Lake', '2025-07-15 07:17:58'),
(70, 1, 28, 1, 50000, 200, 'Nearby Forest Area', '2025-07-15 07:17:58'),
(71, 1, 29, 1, 100000, 0, 'Adjacent Army Land', '2025-07-15 07:17:58'),
(72, 1, 30, 0, 0, 0, 'Not Available', '2025-07-15 07:17:58'),
(73, 1, 31, 0, 0, 0, 'Not Available', '2025-07-15 07:17:58'),
(74, 2, 1, 1, 1500, 30, 'Main Clubhouse', '2025-07-15 07:17:58'),
(75, 2, 2, 1, 1200, 25, 'Clubhouse - Ground Floor', '2025-07-15 07:17:58'),
(76, 2, 4, 1, 1000, 30, 'Central Garden Area', '2025-07-15 07:17:58'),
(77, 2, 16, 1, 1200, 40, 'Perimeter Track', '2025-07-15 07:17:58'),
(78, 2, 17, 1, 400, 8, 'Sports Area', '2025-07-15 07:17:58'),
(79, 2, 26, 1, 25000, 200, 'Landscaped Gardens', '2025-07-15 07:17:58'),
(80, 3, 1, 1, 1200, 25, 'Community Clubhouse', '2025-07-15 07:17:58'),
(81, 3, 2, 1, 800, 20, 'Clubhouse - Fitness Center', '2025-07-15 07:17:58'),
(82, 3, 4, 1, 800, 25, 'Childrens Play Area', '2025-07-15 07:17:58'),
(83, 3, 16, 1, 800, 30, 'Jogging Track', '2025-07-15 07:17:58'),
(84, 3, 26, 1, 13000, 150, 'Park and Garden Areas', '2025-07-15 07:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `property_challenges`
--

CREATE TABLE `property_challenges` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `impact_level` varchar(20) DEFAULT 'medium',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_challenges`
--

INSERT INTO `property_challenges` (`id`, `property_id`, `challenge_id`, `impact_level`, `notes`, `created_at`) VALUES
(1, 1, 1, 'medium', 'Property may be affected by nearby nala/drain during heavy rainfall season', '2025-07-15 07:17:30'),
(2, 1, 2, 'low', 'Thanisandra Road experiences moderate traffic during peak hours', '2025-07-15 07:17:30'),
(3, 1, 4, 'low', 'Temporary issue due to ongoing development in North Bengaluru', '2025-07-15 07:17:30'),
(4, 2, 2, 'medium', 'Jakkur area has increasing traffic due to development', '2025-07-15 07:17:30'),
(5, 2, 5, 'medium', 'Limited metro connectivity in Jakkur area', '2025-07-15 07:17:30'),
(6, 3, 2, 'medium', 'Thanisandra Road traffic affects property accessibility', '2025-07-15 07:17:30'),
(7, 3, 7, 'low', 'General waste management concerns in developing areas', '2025-07-15 07:17:30'),
(8, 1, 1, 'medium', 'Property may be affected by nearby nala/drain during heavy rainfall season', '2025-07-15 07:17:58'),
(9, 1, 2, 'low', 'Thanisandra Road experiences moderate traffic during peak hours', '2025-07-15 07:17:58'),
(10, 1, 4, 'low', 'Temporary issue due to ongoing development in North Bengaluru', '2025-07-15 07:17:58'),
(11, 2, 2, 'medium', 'Jakkur area has increasing traffic due to development', '2025-07-15 07:17:58'),
(12, 2, 5, 'medium', 'Limited metro connectivity in Jakkur area', '2025-07-15 07:17:58'),
(13, 3, 2, 'medium', 'Thanisandra Road traffic affects property accessibility', '2025-07-15 07:17:58'),
(14, 3, 7, 'low', 'General waste management concerns in developing areas', '2025-07-15 07:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `property_connectivity`
--

CREATE TABLE `property_connectivity` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `landmark_type` varchar(50) NOT NULL,
  `landmark_name` varchar(255) DEFAULT NULL,
  `distance_km` decimal(5,2) DEFAULT NULL,
  `travel_time_minutes` int(11) DEFAULT NULL,
  `transport_mode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_connectivity`
--

INSERT INTO `property_connectivity` (`id`, `property_id`, `landmark_type`, `landmark_name`, `distance_km`, `travel_time_minutes`, `transport_mode`, `created_at`) VALUES
(1, 1, 'metro', 'Nagasandra Metro Station', 4.50, 12, 'car', '2025-07-15 07:17:30'),
(2, 1, 'metro', 'Dasarahalli Metro Station', 6.20, 18, 'car', '2025-07-15 07:17:30'),
(3, 1, 'airport', 'Kempegowda International Airport', 28.50, 45, 'car', '2025-07-15 07:17:30'),
(4, 1, 'it_park', 'Manyata Tech Park', 8.50, 25, 'car', '2025-07-15 07:17:30'),
(5, 1, 'it_park', 'Kirloskar Business Park', 12.00, 35, 'car', '2025-07-15 07:17:30'),
(6, 1, 'hospital', 'Columbia Asia Hospital - Hebbal', 7.50, 20, 'car', '2025-07-15 07:17:30'),
(7, 1, 'hospital', 'Manipal Hospital - Hebbal', 8.00, 22, 'car', '2025-07-15 07:17:30'),
(8, 1, 'school', 'Deens Academy', 3.20, 8, 'car', '2025-07-15 07:17:30'),
(9, 1, 'school', 'Vibgyor High School', 4.00, 10, 'car', '2025-07-15 07:17:30'),
(10, 1, 'mall', 'Orion Mall', 12.50, 35, 'car', '2025-07-15 07:17:30'),
(11, 1, 'mall', 'Forum Neighbourhood Mall', 15.00, 40, 'car', '2025-07-15 07:17:30'),
(12, 1, 'market', 'Thanisandra Market', 2.00, 5, 'car', '2025-07-15 07:17:30'),
(13, 1, 'bus_stop', 'Thanisandra Main Road', 0.50, 2, 'walk', '2025-07-15 07:17:30'),
(14, 1, 'railway', 'Hebbal Railway Station', 9.00, 25, 'car', '2025-07-15 07:17:30'),
(15, 1, 'city_center', 'MG Road', 18.50, 50, 'car', '2025-07-15 07:17:30'),
(16, 2, 'metro', 'Nagasandra Metro Station', 8.20, 20, 'car', '2025-07-15 07:17:30'),
(17, 2, 'metro', 'Dasarahalli Metro Station', 10.50, 25, 'car', '2025-07-15 07:17:30'),
(18, 2, 'airport', 'Kempegowda International Airport', 22.00, 35, 'car', '2025-07-15 07:17:30'),
(19, 2, 'it_park', 'Manyata Tech Park', 12.50, 30, 'car', '2025-07-15 07:17:30'),
(20, 2, 'it_park', 'Bagmane Tech Park', 15.00, 35, 'car', '2025-07-15 07:17:30'),
(21, 2, 'hospital', 'Columbia Asia Hospital - Hebbal', 11.00, 25, 'car', '2025-07-15 07:17:30'),
(22, 2, 'hospital', 'Sakra World Hospital', 8.50, 20, 'car', '2025-07-15 07:17:30'),
(23, 2, 'school', 'Deens Academy', 7.00, 15, 'car', '2025-07-15 07:17:30'),
(24, 2, 'school', 'Canadian International School', 5.50, 12, 'car', '2025-07-15 07:17:30'),
(25, 2, 'mall', 'Orion Mall', 16.00, 40, 'car', '2025-07-15 07:17:30'),
(26, 2, 'mall', 'Elements Mall', 18.50, 45, 'car', '2025-07-15 07:17:30'),
(27, 2, 'market', 'Jakkur Market', 3.00, 8, 'car', '2025-07-15 07:17:30'),
(28, 2, 'bus_stop', 'Jakkur Main Road', 1.00, 3, 'walk', '2025-07-15 07:17:30'),
(29, 2, 'railway', 'Hebbal Railway Station', 12.00, 30, 'car', '2025-07-15 07:17:30'),
(30, 2, 'city_center', 'MG Road', 22.00, 55, 'car', '2025-07-15 07:17:30'),
(31, 3, 'metro', 'Nagasandra Metro Station', 5.00, 15, 'car', '2025-07-15 07:17:30'),
(32, 3, 'metro', 'Dasarahalli Metro Station', 7.20, 20, 'car', '2025-07-15 07:17:30'),
(33, 3, 'airport', 'Kempegowda International Airport', 30.00, 50, 'car', '2025-07-15 07:17:30'),
(34, 3, 'it_park', 'Manyata Tech Park', 9.00, 25, 'car', '2025-07-15 07:17:30'),
(35, 3, 'it_park', 'Kirloskar Business Park', 13.50, 40, 'car', '2025-07-15 07:17:30'),
(36, 3, 'hospital', 'Columbia Asia Hospital - Hebbal', 8.00, 22, 'car', '2025-07-15 07:17:30'),
(37, 3, 'hospital', 'Manipal Hospital - Hebbal', 8.50, 25, 'car', '2025-07-15 07:17:30'),
(38, 3, 'school', 'Deens Academy', 4.00, 10, 'car', '2025-07-15 07:17:30'),
(39, 3, 'school', 'Vibgyor High School', 5.00, 12, 'car', '2025-07-15 07:17:30'),
(40, 3, 'mall', 'Orion Mall', 13.00, 38, 'car', '2025-07-15 07:17:30'),
(41, 3, 'mall', 'Forum Neighbourhood Mall', 16.00, 45, 'car', '2025-07-15 07:17:30'),
(42, 3, 'market', 'Thanisandra Market', 2.50, 6, 'car', '2025-07-15 07:17:30'),
(43, 3, 'bus_stop', 'Thanisandra Main Road', 0.80, 3, 'walk', '2025-07-15 07:17:30'),
(44, 3, 'railway', 'Hebbal Railway Station', 9.50, 28, 'car', '2025-07-15 07:17:30'),
(45, 3, 'city_center', 'MG Road', 19.00, 52, 'car', '2025-07-15 07:17:30'),
(46, 1, 'metro', 'Nagasandra Metro Station', 4.50, 12, 'car', '2025-07-15 07:17:58'),
(47, 1, 'metro', 'Dasarahalli Metro Station', 6.20, 18, 'car', '2025-07-15 07:17:58'),
(48, 1, 'airport', 'Kempegowda International Airport', 28.50, 45, 'car', '2025-07-15 07:17:58'),
(49, 1, 'it_park', 'Manyata Tech Park', 8.50, 25, 'car', '2025-07-15 07:17:58'),
(50, 1, 'it_park', 'Kirloskar Business Park', 12.00, 35, 'car', '2025-07-15 07:17:58'),
(51, 1, 'hospital', 'Columbia Asia Hospital - Hebbal', 7.50, 20, 'car', '2025-07-15 07:17:58'),
(52, 1, 'hospital', 'Manipal Hospital - Hebbal', 8.00, 22, 'car', '2025-07-15 07:17:58'),
(53, 1, 'school', 'Deens Academy', 3.20, 8, 'car', '2025-07-15 07:17:58'),
(54, 1, 'school', 'Vibgyor High School', 4.00, 10, 'car', '2025-07-15 07:17:58'),
(55, 1, 'mall', 'Orion Mall', 12.50, 35, 'car', '2025-07-15 07:17:58'),
(56, 1, 'mall', 'Forum Neighbourhood Mall', 15.00, 40, 'car', '2025-07-15 07:17:58'),
(57, 1, 'market', 'Thanisandra Market', 2.00, 5, 'car', '2025-07-15 07:17:58'),
(58, 1, 'bus_stop', 'Thanisandra Main Road', 0.50, 2, 'walk', '2025-07-15 07:17:58'),
(59, 1, 'railway', 'Hebbal Railway Station', 9.00, 25, 'car', '2025-07-15 07:17:58'),
(60, 1, 'city_center', 'MG Road', 18.50, 50, 'car', '2025-07-15 07:17:58'),
(61, 2, 'metro', 'Nagasandra Metro Station', 8.20, 20, 'car', '2025-07-15 07:17:58'),
(62, 2, 'metro', 'Dasarahalli Metro Station', 10.50, 25, 'car', '2025-07-15 07:17:58'),
(63, 2, 'airport', 'Kempegowda International Airport', 22.00, 35, 'car', '2025-07-15 07:17:58'),
(64, 2, 'it_park', 'Manyata Tech Park', 12.50, 30, 'car', '2025-07-15 07:17:58'),
(65, 2, 'it_park', 'Bagmane Tech Park', 15.00, 35, 'car', '2025-07-15 07:17:58'),
(66, 2, 'hospital', 'Columbia Asia Hospital - Hebbal', 11.00, 25, 'car', '2025-07-15 07:17:58'),
(67, 2, 'hospital', 'Sakra World Hospital', 8.50, 20, 'car', '2025-07-15 07:17:58'),
(68, 2, 'school', 'Deens Academy', 7.00, 15, 'car', '2025-07-15 07:17:58'),
(69, 2, 'school', 'Canadian International School', 5.50, 12, 'car', '2025-07-15 07:17:58'),
(70, 2, 'mall', 'Orion Mall', 16.00, 40, 'car', '2025-07-15 07:17:58'),
(71, 2, 'mall', 'Elements Mall', 18.50, 45, 'car', '2025-07-15 07:17:58'),
(72, 2, 'market', 'Jakkur Market', 3.00, 8, 'car', '2025-07-15 07:17:58'),
(73, 2, 'bus_stop', 'Jakkur Main Road', 1.00, 3, 'walk', '2025-07-15 07:17:58'),
(74, 2, 'railway', 'Hebbal Railway Station', 12.00, 30, 'car', '2025-07-15 07:17:58'),
(75, 2, 'city_center', 'MG Road', 22.00, 55, 'car', '2025-07-15 07:17:58'),
(76, 3, 'metro', 'Nagasandra Metro Station', 5.00, 15, 'car', '2025-07-15 07:17:58'),
(77, 3, 'metro', 'Dasarahalli Metro Station', 7.20, 20, 'car', '2025-07-15 07:17:58'),
(78, 3, 'airport', 'Kempegowda International Airport', 30.00, 50, 'car', '2025-07-15 07:17:58'),
(79, 3, 'it_park', 'Manyata Tech Park', 9.00, 25, 'car', '2025-07-15 07:17:58'),
(80, 3, 'it_park', 'Kirloskar Business Park', 13.50, 40, 'car', '2025-07-15 07:17:58'),
(81, 3, 'hospital', 'Columbia Asia Hospital - Hebbal', 8.00, 22, 'car', '2025-07-15 07:17:58'),
(82, 3, 'hospital', 'Manipal Hospital - Hebbal', 8.50, 25, 'car', '2025-07-15 07:17:58'),
(83, 3, 'school', 'Deens Academy', 4.00, 10, 'car', '2025-07-15 07:17:58'),
(84, 3, 'school', 'Vibgyor High School', 5.00, 12, 'car', '2025-07-15 07:17:58'),
(85, 3, 'mall', 'Orion Mall', 13.00, 38, 'car', '2025-07-15 07:17:58'),
(86, 3, 'mall', 'Forum Neighbourhood Mall', 16.00, 45, 'car', '2025-07-15 07:17:58'),
(87, 3, 'market', 'Thanisandra Market', 2.50, 6, 'car', '2025-07-15 07:17:58'),
(88, 3, 'bus_stop', 'Thanisandra Main Road', 0.80, 3, 'walk', '2025-07-15 07:17:58'),
(89, 3, 'railway', 'Hebbal Railway Station', 9.50, 28, 'car', '2025-07-15 07:17:58'),
(90, 3, 'city_center', 'MG Road', 19.00, 52, 'car', '2025-07-15 07:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `property_documents`
--

CREATE TABLE `property_documents` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_url` varchar(500) DEFAULT NULL,
  `upload_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_documents`
--

INSERT INTO `property_documents` (`id`, `property_id`, `document_type`, `document_name`, `document_url`, `upload_date`, `created_at`) VALUES
(1, 1, 'brochure', 'Prestige Lakeside Habitat - Project Brochure', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F274-lodha-mirabelle-thanisandra-road%2Fviews-2.png&w=3840&q=75', '0000-00-00', '2024-01-15 05:00:00'),
(2, 1, 'floor_plan', 'Prestige Lakeside - 2BHK Floor Plan', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F274-lodha-mirabelle-thanisandra-road%2Fviews-2.png&w=3840&q=75', '0000-00-00', '2024-01-15 05:30:00'),
(3, 1, 'floor_plan', 'Prestige Lakeside - 3BHK Floor Plan', 'https://example.com/docs/prestige-lakeside-3bhk-floor.pdf', '2024-01-15', '2024-01-15 05:45:00'),
(4, 1, 'floor_plan', 'Prestige Lakeside - 4BHK Floor Plan', 'https://example.com/docs/prestige-lakeside-4bhk-floor.pdf', '2024-01-15', '2024-01-15 06:00:00'),
(5, 1, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/prestige-lakeside-rera.pdf', '2024-01-10', '2024-01-10 03:30:00'),
(6, 1, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/prestige-lakeside-bbmp-approval.pdf', '2024-01-10', '2024-01-10 04:00:00'),
(7, 1, 'noc', 'Fire Safety NOC', 'https://example.com/docs/prestige-lakeside-fire-noc.pdf', '2024-01-12', '2024-01-12 08:45:00'),
(8, 1, 'noc', 'Pollution Control Board NOC', 'https://example.com/docs/prestige-lakeside-pcb-noc.pdf', '2024-01-12', '2024-01-12 09:15:00'),
(9, 1, 'specification', 'Technical Specifications Document', 'https://example.com/docs/prestige-lakeside-specifications.pdf', '2024-01-18', '2024-01-18 10:50:00'),
(10, 1, 'price_list', 'Current Price List', 'https://example.com/docs/prestige-lakeside-price-list.pdf', '2024-03-01', '2024-03-01 04:30:00'),
(11, 2, 'brochure', 'Brigade Cornerstone Utopia - Project Brochure', 'https://example.com/docs/brigade-utopia-brochure.pdf', '2024-02-01', '2024-02-01 04:00:00'),
(12, 2, 'floor_plan', 'Brigade Utopia - 1BHK Floor Plan', 'https://example.com/docs/brigade-utopia-1bhk-floor.pdf', '2024-02-01', '2024-02-01 04:30:00'),
(13, 2, 'floor_plan', 'Brigade Utopia - 2BHK Floor Plan', 'https://example.com/docs/brigade-utopia-2bhk-floor.pdf', '2024-02-01', '2024-02-01 04:45:00'),
(14, 2, 'floor_plan', 'Brigade Utopia - 3BHK Floor Plan', 'https://example.com/docs/brigade-utopia-3bhk-floor.pdf', '2024-02-01', '2024-02-01 05:00:00'),
(15, 2, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/brigade-utopia-rera.pdf', '2024-01-25', '2024-01-25 05:30:00'),
(16, 2, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/brigade-utopia-bbmp-approval.pdf', '2024-01-25', '2024-01-25 06:00:00'),
(17, 2, 'noc', 'Environment Clearance NOC', 'https://example.com/docs/brigade-utopia-env-noc.pdf', '2024-01-28', '2024-01-28 08:15:00'),
(18, 2, 'specification', 'Technical Specifications Document', 'https://example.com/docs/brigade-utopia-specifications.pdf', '2024-02-05', '2024-02-05 10:00:00'),
(19, 2, 'price_list', 'Current Price List', 'https://example.com/docs/brigade-utopia-price-list.pdf', '2024-04-01', '2024-04-01 03:30:00'),
(20, 3, 'brochure', 'Sobha Neopolis - Project Brochure', 'https://example.com/docs/sobha-neopolis-brochure.pdf', '2024-03-01', '2024-03-01 05:15:00'),
(21, 3, 'floor_plan', 'Sobha Neopolis - 2BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-2bhk-floor.pdf', '2024-03-01', '2024-03-01 05:30:00'),
(22, 3, 'floor_plan', 'Sobha Neopolis - 3BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-3bhk-floor.pdf', '2024-03-01', '2024-03-01 05:45:00'),
(23, 3, 'floor_plan', 'Sobha Neopolis - 4BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-4bhk-floor.pdf', '2024-03-01', '2024-03-01 06:00:00'),
(24, 3, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/sobha-neopolis-rera.pdf', '2024-02-25', '2024-02-25 08:50:00'),
(25, 3, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/sobha-neopolis-bbmp-approval.pdf', '2024-02-25', '2024-02-25 09:15:00'),
(26, 3, 'noc', 'Fire Safety NOC', 'https://example.com/docs/sobha-neopolis-fire-noc.pdf', '2024-02-28', '2024-02-28 10:40:00'),
(27, 3, 'noc', 'Water Board NOC', 'https://example.com/docs/sobha-neopolis-water-noc.pdf', '2024-02-28', '2024-02-28 11:00:00'),
(28, 3, 'specification', 'Technical Specifications Document', 'https://example.com/docs/sobha-neopolis-specifications.pdf', '2024-03-05', '2024-03-05 06:45:00'),
(29, 3, 'price_list', 'Current Price List', 'https://example.com/docs/sobha-neopolis-price-list.pdf', '2024-05-01', '2024-05-01 04:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `property_gallery`
--

CREATE TABLE `property_gallery` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `image_type` varchar(50) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `image_title` varchar(255) DEFAULT NULL,
  `image_description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_gallery`
--

INSERT INTO `property_gallery` (`id`, `property_id`, `image_type`, `image_url`, `image_title`, `image_description`, `display_order`, `created_at`) VALUES
(1, 1, 'exterior', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F274-lodha-mirabelle-thanisandra-road%2Fviews-2.png&w=3840&q=75', 'Main Entrance View', 'Impressive main entrance with landscaped gardens', 1, '2024-01-20 03:30:00'),
(2, 1, 'exterior', 'https://example.com/gallery/prestige-lakeside-towers.jpg', 'Tower View', 'Modern high-rise towers with premium architecture', 2, '2024-01-20 03:45:00'),
(3, 1, 'exterior', 'https://example.com/gallery/prestige-lakeside-gardens.jpg', 'Landscaped Gardens', 'Beautiful landscaped gardens and walking paths', 3, '2024-01-20 04:00:00'),
(4, 1, 'amenity', 'https://example.com/gallery/prestige-lakeside-pool.jpg', 'Swimming Pool', 'Olympic-size swimming pool with deck area', 4, '2024-01-20 04:30:00'),
(5, 1, 'amenity', 'https://example.com/gallery/prestige-lakeside-clubhouse.jpg', 'Clubhouse Interior', 'Luxurious clubhouse with modern interiors', 5, '2024-01-20 04:45:00'),
(6, 1, 'amenity', 'https://example.com/gallery/prestige-lakeside-gym.jpg', 'Gymnasium', 'Fully equipped modern gymnasium', 6, '2024-01-20 05:00:00'),
(7, 1, 'amenity', 'https://example.com/gallery/prestige-lakeside-play-area.jpg', 'Children Play Area', 'Safe and fun children play area', 7, '2024-01-20 05:15:00'),
(8, 1, 'interior', 'https://example.com/gallery/prestige-lakeside-2bhk-living.jpg', '2BHK Living Room', 'Spacious 2BHK living room with premium finishes', 8, '2024-01-20 05:30:00'),
(9, 1, 'interior', 'https://example.com/gallery/prestige-lakeside-3bhk-master.jpg', '3BHK Master Bedroom', 'Elegant master bedroom with attached bathroom', 9, '2024-01-20 05:45:00'),
(10, 1, 'interior', 'https://example.com/gallery/prestige-lakeside-kitchen.jpg', 'Modern Kitchen', 'Modular kitchen with premium appliances', 10, '2024-01-20 06:00:00'),
(11, 1, 'location', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F218-assetz-soho-and-sky-jakkur%2Fviews-2.jpg&w=3840&q=75', 'Manyata Tech Park View', 'Close proximity to Manyata Tech Park', 11, '2024-01-20 06:15:00'),
(12, 1, 'construction', 'https://example.com/gallery/prestige-lakeside-construction.jpg', 'Construction Progress', 'Latest construction progress photos', 12, '2024-01-20 06:30:00'),
(13, 2, 'exterior', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F218-assetz-soho-and-sky-jakkur%2Fviews-2.jpg&w=3840&q=75', 'Project Facade', 'Modern project facade with contemporary design', 1, '2024-02-10 04:00:00'),
(14, 2, 'exterior', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F218-assetz-soho-and-sky-jakkur%2Fviews-2.jpg&w=3840&q=75', 'Building Complex', 'Well-planned building complex layout', 2, '2024-02-10 04:15:00'),
(15, 2, 'exterior', 'https://example.com/gallery/brigade-utopia-gate.jpg', 'Entrance Gate', 'Secure entrance gate with modern design', 3, '2024-02-10 04:30:00'),
(16, 2, 'amenity', 'https://example.com/gallery/brigade-utopia-pool.jpg', 'Swimming Pool', 'Resort-style swimming pool', 4, '2024-02-10 04:45:00'),
(17, 2, 'amenity', 'https://example.com/gallery/brigade-utopia-clubhouse.jpg', 'Clubhouse', 'Multi-purpose clubhouse facility', 5, '2024-02-10 05:00:00'),
(18, 2, 'amenity', 'https://example.com/gallery/brigade-utopia-sports.jpg', 'Sports Complex', 'Indoor sports complex with multiple courts', 6, '2024-02-10 05:15:00'),
(19, 2, 'amenity', 'https://example.com/gallery/brigade-utopia-kids.jpg', 'Kids Zone', 'Dedicated kids play zone', 7, '2024-02-10 05:30:00'),
(20, 2, 'interior', 'https://example.com/gallery/brigade-utopia-1bhk-sample.jpg', '1BHK Sample Flat', 'Furnished 1BHK sample apartment', 8, '2024-02-10 05:45:00'),
(21, 2, 'interior', 'https://example.com/gallery/brigade-utopia-2bhk-living.jpg', '2BHK Living Area', 'Spacious 2BHK living area', 9, '2024-02-10 06:00:00'),
(22, 2, 'interior', 'https://example.com/gallery/brigade-utopia-bedroom.jpg', 'Bedroom Interior', 'Comfortable bedroom with modern amenities', 10, '2024-02-10 06:15:00'),
(23, 2, 'location', 'https://example.com/gallery/brigade-utopia-neighborhood.jpg', 'Neighborhood View', 'Developing neighborhood with good connectivity', 11, '2024-02-10 06:30:00'),
(24, 2, 'construction', 'https://example.com/gallery/brigade-utopia-status.jpg', 'Current Status', 'Current construction status - 85% complete', 12, '2024-02-10 06:45:00'),
(25, 3, 'exterior', 'https://www.propsoch.com/_next/image?url=https%3A%2F%2Fd1zk2x7mtoyb2b.cloudfront.net%2FProjectImages%2F427-ranka-ankura-thanisandra-road%2Fviews-2.png&w=3840&q=75', 'Project Overview', 'Complete project overview with all towers', 1, '2024-03-10 04:30:00'),
(26, 3, 'exterior', 'https://example.com/gallery/sobha-neopolis-main-tower.jpg', 'Main Tower', 'Main residential tower with premium architecture', 2, '2024-03-10 04:45:00'),
(27, 3, 'exterior', 'https://example.com/gallery/sobha-neopolis-landscape.jpg', 'Landscaping', 'Beautiful landscaping and garden areas', 3, '2024-03-10 05:00:00'),
(28, 3, 'amenity', 'https://example.com/gallery/sobha-neopolis-pool.jpg', 'Swimming Pool', 'Large swimming pool with kids pool', 4, '2024-03-10 05:15:00'),
(29, 3, 'amenity', 'https://example.com/gallery/sobha-neopolis-clubhouse-ext.jpg', 'Clubhouse Exterior', 'Clubhouse exterior with modern design', 5, '2024-03-10 05:30:00'),
(30, 3, 'amenity', 'https://example.com/gallery/sobha-neopolis-fitness.jpg', 'Fitness Center', 'Well-equipped fitness center', 6, '2024-03-10 05:45:00'),
(31, 3, 'amenity', 'https://example.com/gallery/sobha-neopolis-hall.jpg', 'Community Hall', 'Community hall for events and gatherings', 7, '2024-03-10 06:00:00'),
(32, 3, 'interior', 'https://example.com/gallery/sobha-neopolis-2bhk-model.jpg', '2BHK Model Home', 'Fully furnished 2BHK model home', 8, '2024-03-10 06:15:00'),
(33, 3, 'interior', 'https://example.com/gallery/sobha-neopolis-3bhk-dining.jpg', '3BHK Dining Area', 'Spacious 3BHK dining area', 9, '2024-03-10 06:30:00'),
(34, 3, 'interior', 'https://example.com/gallery/sobha-neopolis-kitchen.jpg', 'Premium Kitchen', 'Premium modular kitchen design', 10, '2024-03-10 06:45:00'),
(35, 3, 'location', 'https://example.com/gallery/sobha-neopolis-connectivity.jpg', 'Connectivity Map', 'Location connectivity and transport links', 11, '2024-03-10 07:00:00'),
(36, 3, 'construction', 'https://example.com/gallery/sobha-neopolis-ready.jpg', 'Ready to Move', 'Ready to move - possession available', 12, '2024-03-10 07:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `reviewer_name` varchar(100) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL CHECK (`rating` >= 1.0 and `rating` <= 5.0),
  `review_text` text DEFAULT NULL,
  `pros` text DEFAULT NULL,
  `cons` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL,
  `purchase_status` varchar(50) DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `helpful_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `property_id`, `reviewer_name`, `rating`, `review_text`, `pros`, `cons`, `recommendation`, `purchase_status`, `review_date`, `is_verified`, `helpful_count`, `created_at`, `updated_at`) VALUES
(1, 1, 'Rajesh Kumar', 4.50, 'Excellent project with world-class amenities. The location is perfect for IT professionals working in Manyata Tech Park.', 'Premium amenities, Good location, Quality construction, Branded developer', 'High pricing, Traffic during peak hours', 'Recommended for premium buyers', 'Purchased - 3BHK', '2024-03-15', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(2, 1, 'Priya Sharma', 4.00, 'Good project but the pricing is on the higher side. The amenities are impressive and the build quality is excellent.', 'Excellent amenities, Quality construction, Good connectivity', 'High cost, Limited parking', 'Good for investors', 'Considering purchase', '2024-02-20', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(3, 1, 'Amit Patel', 4.20, 'Living here for 6 months now. The clubhouse facilities are amazing and the society is well-maintained.', 'World-class amenities, Good maintenance, Peaceful environment', 'High maintenance charges, Dense construction', 'Recommended for families', 'Purchased - 4BHK', '2024-01-10', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(4, 2, 'Venkatesh Reddy', 3.80, 'Decent project with good amenities. The location is developing well and has good potential for appreciation.', 'Good amenities, Reasonable pricing, Growing location', 'Construction delays, Limited public transport', 'Good for long-term investment', 'Purchased - 3BHK', '2024-04-05', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(5, 2, 'Sneha Iyer', 3.50, 'The project is good but there are some delays in construction. The amenities are as promised.', 'Good amenities, Reasonable pricing, Quality construction', 'Construction delays, Traffic issues', 'Wait for completion', 'Booked - 2BHK', '2024-03-28', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(6, 3, 'Manoj Singh', 4.10, 'Great value for money project. Perfect for first-time buyers. The location is improving with good connectivity.', 'Affordable pricing, Good connectivity, Transparent dealing', 'Limited amenities, Basic finishing', 'Recommended for first-time buyers', 'Purchased - 2BHK', '2024-05-12', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(7, 3, 'Kavitha Nair', 3.90, 'Good project for the price range. The builder has delivered as promised. Happy with the purchase decision.', 'Value for money, Good connectivity, Timely delivery', 'Limited amenities, Basic interiors', 'Good for budget-conscious buyers', 'Purchased - 3BHK', '2024-04-18', 0, 0, '2025-07-15 07:34:50', '2025-07-15 07:34:50'),
(8, 1, 'Rajesh Kumar', 4.50, 'Excellent project with world-class amenities. The location is perfect for IT professionals working in Manyata Tech Park.', 'Premium amenities, Good location, Quality construction, Branded developer', 'High pricing, Traffic during peak hours', 'Recommended for premium buyers', 'Purchased - 3BHK', '2024-03-15', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(9, 1, 'Priya Sharma', 4.00, 'Good project but the pricing is on the higher side. The amenities are impressive and the build quality is excellent.', 'Excellent amenities, Quality construction, Good connectivity', 'High cost, Limited parking', 'Good for investors', 'Considering purchase', '2024-02-20', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(10, 1, 'Amit Patel', 4.20, 'Living here for 6 months now. The clubhouse facilities are amazing and the society is well-maintained.', 'World-class amenities, Good maintenance, Peaceful environment', 'High maintenance charges, Dense construction', 'Recommended for families', 'Purchased - 4BHK', '2024-01-10', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(11, 2, 'Venkatesh Reddy', 3.80, 'Decent project with good amenities. The location is developing well and has good potential for appreciation.', 'Good amenities, Reasonable pricing, Growing location', 'Construction delays, Limited public transport', 'Good for long-term investment', 'Purchased - 3BHK', '2024-04-05', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(12, 2, 'Sneha Iyer', 3.50, 'The project is good but there are some delays in construction. The amenities are as promised.', 'Good amenities, Reasonable pricing, Quality construction', 'Construction delays, Traffic issues', 'Wait for completion', 'Booked - 2BHK', '2024-03-28', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(13, 3, 'Manoj Singh', 4.10, 'Great value for money project. Perfect for first-time buyers. The location is improving with good connectivity.', 'Affordable pricing, Good connectivity, Transparent dealing', 'Limited amenities, Basic finishing', 'Recommended for first-time buyers', 'Purchased - 2BHK', '2024-05-12', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(14, 3, 'Kavitha Nair', 3.90, 'Good project for the price range. The builder has delivered as promised. Happy with the purchase decision.', 'Value for money, Good connectivity, Timely delivery', 'Limited amenities, Basic interiors', 'Good for budget-conscious buyers', 'Purchased - 3BHK', '2024-04-18', 0, 0, '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(15, 1, 'Rajesh Kumar', 4.50, 'Excellent project with world-class amenities. The location is perfect for IT professionals working in Manyata Tech Park.', 'Premium amenities, Good location, Quality construction, Branded developer', 'High pricing, Traffic during peak hours', 'Recommended for premium buyers', 'Purchased - 3BHK', '2024-03-15', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(16, 1, 'Priya Sharma', 4.00, 'Good project but the pricing is on the higher side. The amenities are impressive and the build quality is excellent.', 'Excellent amenities, Quality construction, Good connectivity', 'High cost, Limited parking', 'Good for investors', 'Considering purchase', '2024-02-20', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(17, 1, 'Amit Patel', 4.20, 'Living here for 6 months now. The clubhouse facilities are amazing and the society is well-maintained.', 'World-class amenities, Good maintenance, Peaceful environment', 'High maintenance charges, Dense construction', 'Recommended for families', 'Purchased - 4BHK', '2024-01-10', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(18, 2, 'Venkatesh Reddy', 3.80, 'Decent project with good amenities. The location is developing well and has good potential for appreciation.', 'Good amenities, Reasonable pricing, Growing location', 'Construction delays, Limited public transport', 'Good for long-term investment', 'Purchased - 3BHK', '2024-04-05', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(19, 2, 'Sneha Iyer', 3.50, 'The project is good but there are some delays in construction. The amenities are as promised.', 'Good amenities, Reasonable pricing, Quality construction', 'Construction delays, Traffic issues', 'Wait for completion', 'Booked - 2BHK', '2024-03-28', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(20, 3, 'Manoj Singh', 4.10, 'Great value for money project. Perfect for first-time buyers. The location is improving with good connectivity.', 'Affordable pricing, Good connectivity, Transparent dealing', 'Limited amenities, Basic finishing', 'Recommended for first-time buyers', 'Purchased - 2BHK', '2024-05-12', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(21, 3, 'Kavitha Nair', 3.90, 'Good project for the price range. The builder has delivered as promised. Happy with the purchase decision.', 'Value for money, Good connectivity, Timely delivery', 'Limited amenities, Basic interiors', 'Good for budget-conscious buyers', 'Purchased - 3BHK', '2024-04-18', 0, 0, '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `room_details`
--

CREATE TABLE `room_details` (
  `id` int(11) NOT NULL,
  `unit_type_id` int(11) DEFAULT NULL,
  `room_type` varchar(50) NOT NULL,
  `length_ft` decimal(5,2) DEFAULT NULL,
  `breadth_ft` decimal(5,2) DEFAULT NULL,
  `area_sqft` decimal(8,2) DEFAULT NULL,
  `room_category` varchar(20) NOT NULL,
  `room_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_details`
--

INSERT INTO `room_details` (`id`, `unit_type_id`, `room_type`, `length_ft`, `breadth_ft`, `area_sqft`, `room_category`, `room_description`, `created_at`) VALUES
(1, 1, 'Master Bedroom', 12.00, 14.00, 168.00, 'bedroom', 'Spacious master bedroom with attached bathroom and wardrobe space', '2025-07-15 07:17:12'),
(2, 1, 'Living Room', 16.00, 18.00, 288.00, 'living', 'Open plan living area with large windows and balcony access', '2025-07-15 07:17:12'),
(3, 1, 'Child Bedroom', 10.00, 12.00, 120.00, 'bedroom', 'Secondary bedroom suitable for children or guests', '2025-07-15 07:17:12'),
(4, 1, 'Kitchen', 8.00, 12.00, 96.00, 'utility', 'Modern kitchen with granite countertops and premium fittings', '2025-07-15 07:17:12'),
(5, 1, 'Dining Area', 10.00, 12.00, 120.00, 'living', 'Dedicated dining space adjacent to living room', '2025-07-15 07:17:12'),
(6, 1, 'Master Bathroom', 6.00, 8.00, 48.00, 'bathroom', 'Attached master bathroom with premium fixtures', '2025-07-15 07:17:12'),
(7, 1, 'Common Bathroom', 5.00, 6.00, 30.00, 'bathroom', 'Common bathroom with modern amenities', '2025-07-15 07:17:12'),
(8, 1, 'Balcony', 8.00, 25.00, 200.00, 'utility', 'Large balcony with garden views and utility space', '2025-07-15 07:17:12'),
(9, 1, 'Foyer', 6.00, 8.00, 48.00, 'utility', 'Entrance foyer with shoe storage', '2025-07-15 07:17:12'),
(10, 1, 'Utility Area', 4.00, 6.00, 24.00, 'utility', 'Utility area for washing machine and storage', '2025-07-15 07:17:12'),
(11, 2, 'Master Bedroom', 12.00, 15.00, 180.00, 'bedroom', 'Spacious master bedroom with attached bathroom and walk-in closet', '2025-07-15 07:17:12'),
(12, 2, 'Living Room', 16.00, 20.00, 320.00, 'living', 'Large living room with premium flooring and balcony access', '2025-07-15 07:17:12'),
(13, 2, 'Child Bedroom 1', 10.00, 12.00, 120.00, 'bedroom', 'Well-ventilated bedroom with built-in storage', '2025-07-15 07:17:12'),
(14, 2, 'Child Bedroom 2', 10.00, 11.00, 110.00, 'bedroom', 'Comfortable bedroom with natural light', '2025-07-15 07:17:12'),
(15, 2, 'Kitchen', 8.00, 14.00, 112.00, 'utility', 'Modular kitchen with granite countertops and premium appliances', '2025-07-15 07:17:12'),
(16, 2, 'Dining Area', 10.00, 14.00, 140.00, 'living', 'Spacious dining area with elegant lighting', '2025-07-15 07:17:12'),
(17, 2, 'Master Bathroom', 6.00, 8.00, 48.00, 'bathroom', 'Luxurious master bathroom with separate shower and bathtub', '2025-07-15 07:17:12'),
(18, 2, 'Common Bathroom', 5.00, 6.00, 30.00, 'bathroom', 'Well-designed common bathroom with modern fixtures', '2025-07-15 07:17:12'),
(19, 2, 'Balcony', 10.00, 25.00, 250.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 07:17:12'),
(20, 2, 'Foyer', 6.00, 10.00, 60.00, 'utility', 'Elegant entrance foyer with decorative elements', '2025-07-15 07:17:12'),
(21, 2, 'Utility Area', 4.00, 8.00, 32.00, 'utility', 'Dedicated utility area with storage solutions', '2025-07-15 07:17:12'),
(22, 3, 'Master Bedroom', 13.00, 16.00, 208.00, 'bedroom', 'Premium master bedroom with en-suite bathroom and dressing area', '2025-07-15 07:17:12'),
(23, 3, 'Living Room', 18.00, 22.00, 396.00, 'living', 'Expansive living room with high ceilings and premium finishes', '2025-07-15 07:17:12'),
(24, 3, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Comfortable bedroom with study nook', '2025-07-15 07:17:12'),
(25, 3, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Well-appointed bedroom with built-in wardrobe', '2025-07-15 07:17:12'),
(26, 3, 'Study Room', 8.00, 10.00, 80.00, 'utility', 'Dedicated study/home office space', '2025-07-15 07:17:12'),
(27, 3, 'Kitchen', 9.00, 14.00, 126.00, 'utility', 'Large modular kitchen with island and premium appliances', '2025-07-15 07:17:12'),
(28, 3, 'Dining Area', 12.00, 14.00, 168.00, 'living', 'Formal dining area with chandelier and elegant décor', '2025-07-15 07:17:12'),
(29, 3, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Luxury master bathroom with jacuzzi and separate shower', '2025-07-15 07:17:12'),
(30, 3, 'Common Bathroom', 5.00, 6.00, 30.00, 'bathroom', 'Modern common bathroom with premium fittings', '2025-07-15 07:17:12'),
(31, 3, 'Balcony', 12.00, 23.30, 280.00, 'utility', 'Large balcony with landscaped garden views', '2025-07-15 07:17:12'),
(32, 3, 'Foyer', 8.00, 10.00, 80.00, 'utility', 'Grand entrance foyer with marble flooring', '2025-07-15 07:17:12'),
(33, 3, 'Utility Area', 5.00, 8.00, 40.00, 'utility', 'Spacious utility area with storage and laundry facilities', '2025-07-15 07:17:12'),
(34, 4, 'Master Bedroom', 13.00, 16.00, 208.00, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom', '2025-07-15 07:17:12'),
(35, 4, 'Living Room', 18.00, 24.00, 432.00, 'living', 'Grand living room with double-height ceilings and panoramic views', '2025-07-15 07:17:12'),
(36, 4, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(37, 4, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(38, 4, 'Child Bedroom 3', 10.00, 11.00, 110.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(39, 4, 'Kitchen', 9.00, 15.00, 135.00, 'utility', 'Premium modular kitchen with breakfast counter', '2025-07-15 07:17:12'),
(40, 4, 'Dining Area', 12.00, 16.00, 192.00, 'living', 'Elegant dining area with crystal chandelier', '2025-07-15 07:17:12'),
(41, 4, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Opulent master bathroom with premium fixtures', '2025-07-15 07:17:12'),
(42, 4, 'Common Bathroom 1', 5.00, 6.00, 30.00, 'bathroom', 'Well-appointed common bathroom', '2025-07-15 07:17:12'),
(43, 4, 'Common Bathroom 2', 5.00, 6.00, 30.00, 'bathroom', 'Additional bathroom for guests', '2025-07-15 07:17:12'),
(44, 4, 'Balcony', 12.00, 25.00, 300.00, 'utility', 'Expansive balcony with outdoor seating area', '2025-07-15 07:17:12'),
(45, 4, 'Foyer', 8.00, 12.00, 96.00, 'utility', 'Impressive entrance foyer with decorative ceiling', '2025-07-15 07:17:12'),
(46, 4, 'Utility Area', 6.00, 8.00, 48.00, 'utility', 'Large utility room with storage and laundry facilities', '2025-07-15 07:17:12'),
(47, 4, 'Guest Powder Room', 4.00, 5.00, 20.00, 'bathroom', 'Convenient powder room for guests', '2025-07-15 07:17:12'),
(48, 5, 'Master Bedroom', 13.50, 16.00, 216.00, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom', '2025-07-15 07:17:12'),
(49, 5, 'Living Room', 18.00, 24.00, 432.00, 'living', 'Grand living room with double-height ceilings and panoramic views', '2025-07-15 07:17:12'),
(50, 5, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(51, 5, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(52, 5, 'Child Bedroom 3', 10.00, 11.00, 110.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(53, 5, 'Kitchen', 9.00, 15.00, 135.00, 'utility', 'Premium modular kitchen with breakfast counter', '2025-07-15 07:17:12'),
(54, 5, 'Dining Area', 12.00, 16.00, 192.00, 'living', 'Elegant dining area with crystal chandelier', '2025-07-15 07:17:12'),
(55, 5, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Opulent master bathroom with premium fixtures', '2025-07-15 07:17:12'),
(56, 5, 'Common Bathroom 1', 5.00, 6.00, 30.00, 'bathroom', 'Well-appointed common bathroom', '2025-07-15 07:17:12'),
(57, 5, 'Common Bathroom 2', 5.00, 6.00, 30.00, 'bathroom', 'Additional bathroom for guests', '2025-07-15 07:17:12'),
(58, 5, 'Balcony', 12.00, 25.80, 310.00, 'utility', 'Expansive balcony with outdoor seating area', '2025-07-15 07:17:12'),
(59, 5, 'Foyer', 8.00, 12.00, 96.00, 'utility', 'Impressive entrance foyer with decorative ceiling', '2025-07-15 07:17:12'),
(60, 5, 'Utility Area', 6.00, 8.00, 48.00, 'utility', 'Large utility room with storage and laundry facilities', '2025-07-15 07:17:12'),
(61, 5, 'Guest Powder Room', 4.00, 5.00, 20.00, 'bathroom', 'Convenient powder room for guests', '2025-07-15 07:17:12'),
(62, 6, 'Master Bedroom', 13.50, 16.00, 216.00, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom', '2025-07-15 07:17:12'),
(63, 6, 'Living Room', 18.00, 24.00, 432.00, 'living', 'Grand living room with double-height ceilings and panoramic views', '2025-07-15 07:17:12'),
(64, 6, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(65, 6, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(66, 6, 'Child Bedroom 3', 10.00, 11.00, 110.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(67, 6, 'Kitchen', 9.00, 15.00, 135.00, 'utility', 'Premium modular kitchen with breakfast counter', '2025-07-15 07:17:12'),
(68, 6, 'Dining Area', 12.00, 16.00, 192.00, 'living', 'Elegant dining area with crystal chandelier', '2025-07-15 07:17:12'),
(69, 6, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Opulent master bathroom with premium fixtures', '2025-07-15 07:17:12'),
(70, 6, 'Common Bathroom 1', 5.00, 6.00, 30.00, 'bathroom', 'Well-appointed common bathroom', '2025-07-15 07:17:12'),
(71, 6, 'Common Bathroom 2', 5.00, 6.00, 30.00, 'bathroom', 'Additional bathroom for guests', '2025-07-15 07:17:12'),
(72, 6, 'Balcony', 12.00, 26.25, 315.00, 'utility', 'Expansive balcony with outdoor seating area', '2025-07-15 07:17:12'),
(73, 6, 'Foyer', 8.00, 12.00, 96.00, 'utility', 'Impressive entrance foyer with decorative ceiling', '2025-07-15 07:17:12'),
(74, 6, 'Utility Area', 6.00, 8.00, 48.00, 'utility', 'Large utility room with storage and laundry facilities', '2025-07-15 07:17:12'),
(75, 6, 'Guest Powder Room', 4.00, 5.00, 20.00, 'bathroom', 'Convenient powder room for guests', '2025-07-15 07:17:12'),
(76, 7, 'Master Bedroom', 12.00, 14.00, 168.00, 'bedroom', 'Spacious master bedroom with attached bathroom', '2025-07-15 07:17:12'),
(77, 7, 'Living Room', 16.00, 20.00, 320.00, 'living', 'Open concept living area with modern design', '2025-07-15 07:17:12'),
(78, 7, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Well-ventilated bedroom with built-in storage', '2025-07-15 07:17:12'),
(79, 7, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study nook', '2025-07-15 07:17:12'),
(80, 7, 'Kitchen', 8.00, 14.00, 112.00, 'utility', 'Modern kitchen with island and premium appliances', '2025-07-15 07:17:12'),
(81, 7, 'Dining Area', 12.00, 14.00, 168.00, 'living', 'Spacious dining area with elegant lighting', '2025-07-15 07:17:12'),
(82, 7, 'Master Bathroom', 6.00, 8.00, 48.00, 'bathroom', 'Luxurious master bathroom with modern fixtures', '2025-07-15 07:17:12'),
(83, 7, 'Common Bathroom', 5.00, 6.00, 30.00, 'bathroom', 'Well-designed common bathroom', '2025-07-15 07:17:12'),
(84, 7, 'Balcony', 10.00, 28.00, 280.00, 'utility', 'Large balcony with city views', '2025-07-15 07:17:12'),
(85, 7, 'Foyer', 6.00, 8.00, 48.00, 'utility', 'Entrance foyer with storage', '2025-07-15 07:17:12'),
(86, 7, 'Utility Area', 4.00, 6.00, 24.00, 'utility', 'Utility space for laundry and storage', '2025-07-15 07:17:12'),
(87, 8, 'Master Bedroom', 13.00, 15.00, 195.00, 'bedroom', 'Luxurious master suite with walk-in closet', '2025-07-15 07:17:12'),
(88, 8, 'Living Room', 18.00, 22.00, 396.00, 'living', 'Expansive living room with high ceilings', '2025-07-15 07:17:12'),
(89, 8, 'Child Bedroom 1', 11.00, 13.00, 143.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(90, 8, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with built-in wardrobe', '2025-07-15 07:17:12'),
(91, 8, 'Kitchen', 9.00, 15.00, 135.00, 'utility', 'Premium modular kitchen with breakfast counter', '2025-07-15 07:17:12'),
(92, 8, 'Dining Area', 12.00, 16.00, 192.00, 'living', 'Formal dining area with chandelier', '2025-07-15 07:17:12'),
(93, 8, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Opulent master bathroom with jacuzzi', '2025-07-15 07:17:12'),
(94, 8, 'Common Bathroom', 5.00, 6.00, 30.00, 'bathroom', 'Modern common bathroom', '2025-07-15 07:17:12'),
(95, 8, 'Balcony', 12.00, 26.67, 320.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 07:17:12'),
(96, 8, 'Foyer', 8.00, 10.00, 80.00, 'utility', 'Grand entrance foyer', '2025-07-15 07:17:12'),
(97, 8, 'Utility Area', 5.00, 8.00, 40.00, 'utility', 'Spacious utility area with storage', '2025-07-15 07:17:12'),
(98, 9, 'Master Bedroom', 13.00, 16.00, 208.00, 'bedroom', 'Luxurious master suite with dressing area', '2025-07-15 07:17:12'),
(99, 9, 'Living Room', 18.00, 24.00, 432.00, 'living', 'Grand living room with double-height ceilings', '2025-07-15 07:17:12'),
(100, 9, 'Child Bedroom 1', 11.00, 13.00, 143.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(101, 9, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(102, 9, 'Child Bedroom 3', 10.00, 11.00, 110.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(103, 9, 'Kitchen', 9.00, 16.00, 144.00, 'utility', 'Premium kitchen with island and premium appliances', '2025-07-15 07:17:12'),
(104, 9, 'Dining Area', 12.00, 18.00, 216.00, 'living', 'Elegant dining area with crystal chandelier', '2025-07-15 07:17:12'),
(105, 9, 'Master Bathroom', 6.00, 9.00, 54.00, 'bathroom', 'Luxury master bathroom with premium fixtures', '2025-07-15 07:17:12'),
(106, 9, 'Common Bathroom 1', 5.00, 6.00, 30.00, 'bathroom', 'Well-appointed common bathroom', '2025-07-15 07:17:12'),
(107, 9, 'Common Bathroom 2', 5.00, 6.00, 30.00, 'bathroom', 'Additional bathroom for guests', '2025-07-15 07:17:12'),
(108, 9, 'Balcony', 12.00, 29.17, 350.00, 'utility', 'Expansive balcony with outdoor seating', '2025-07-15 07:17:12'),
(109, 9, 'Foyer', 8.00, 12.00, 96.00, 'utility', 'Impressive entrance foyer', '2025-07-15 07:17:12'),
(110, 9, 'Utility Area', 6.00, 8.00, 48.00, 'utility', 'Large utility room with storage facilities', '2025-07-15 07:17:12'),
(111, 10, 'Master Bedroom', 11.00, 13.00, 143.00, 'bedroom', 'Spacious master bedroom with attached bathroom', '2025-07-15 07:17:12'),
(112, 10, 'Living Room', 14.00, 18.00, 252.00, 'living', 'Open living area with modern design', '2025-07-15 07:17:12'),
(113, 10, 'Child Bedroom', 10.00, 11.00, 110.00, 'bedroom', 'Comfortable bedroom with built-in storage', '2025-07-15 07:17:12'),
(114, 10, 'Kitchen', 7.00, 12.00, 84.00, 'utility', 'Efficient kitchen with modern appliances', '2025-07-15 07:17:12'),
(115, 10, 'Dining Area', 10.00, 12.00, 120.00, 'living', 'Dining area adjacent to living room', '2025-07-15 07:17:12'),
(116, 10, 'Master Bathroom', 5.00, 7.00, 35.00, 'bathroom', 'Attached master bathroom', '2025-07-15 07:17:12'),
(117, 10, 'Common Bathroom', 4.00, 5.00, 20.00, 'bathroom', 'Common bathroom with modern fixtures', '2025-07-15 07:17:12'),
(118, 10, 'Balcony', 8.00, 22.50, 180.00, 'utility', 'Balcony with garden views', '2025-07-15 07:17:12'),
(119, 10, 'Foyer', 5.00, 7.00, 35.00, 'utility', 'Entrance foyer', '2025-07-15 07:17:12'),
(120, 10, 'Utility Area', 3.00, 5.00, 15.00, 'utility', 'Utility space for storage', '2025-07-15 07:17:12'),
(121, 11, 'Master Bedroom', 11.00, 13.00, 143.00, 'bedroom', 'Spacious master bedroom with attached bathroom', '2025-07-15 07:17:12'),
(122, 11, 'Living Room', 15.00, 18.00, 270.00, 'living', 'Open living area with balcony access', '2025-07-15 07:17:12'),
(123, 11, 'Child Bedroom 1', 10.00, 11.00, 110.00, 'bedroom', 'Well-ventilated bedroom', '2025-07-15 07:17:12'),
(124, 11, 'Child Bedroom 2', 9.00, 11.00, 99.00, 'bedroom', 'Comfortable bedroom with storage', '2025-07-15 07:17:12'),
(125, 11, 'Kitchen', 7.00, 12.00, 84.00, 'utility', 'Modern kitchen with granite countertops', '2025-07-15 07:17:12'),
(126, 11, 'Dining Area', 10.00, 12.00, 120.00, 'living', 'Dining area with elegant lighting', '2025-07-15 07:17:12'),
(127, 11, 'Master Bathroom', 5.00, 7.00, 35.00, 'bathroom', 'Attached master bathroom', '2025-07-15 07:17:12'),
(128, 11, 'Common Bathroom', 4.00, 5.00, 20.00, 'bathroom', 'Common bathroom with modern fixtures', '2025-07-15 07:17:12'),
(129, 11, 'Balcony', 8.00, 27.50, 220.00, 'utility', 'Large balcony with city views', '2025-07-15 07:17:12'),
(130, 11, 'Foyer', 5.00, 7.00, 35.00, 'utility', 'Entrance foyer with storage', '2025-07-15 07:17:12'),
(131, 11, 'Utility Area', 3.00, 6.00, 18.00, 'utility', 'Utility area for laundry', '2025-07-15 07:17:12'),
(132, 12, 'Master Bedroom', 11.00, 13.00, 143.00, 'bedroom', 'Spacious master bedroom with attached bathroom', '2025-07-15 07:17:12'),
(133, 12, 'Living Room', 15.00, 19.00, 285.00, 'living', 'Open living area with modern design', '2025-07-15 07:17:12'),
(134, 12, 'Child Bedroom 1', 10.00, 11.00, 110.00, 'bedroom', 'Well-ventilated bedroom with storage', '2025-07-15 07:17:12'),
(135, 12, 'Child Bedroom 2', 9.00, 11.00, 99.00, 'bedroom', 'Comfortable bedroom with study nook', '2025-07-15 07:17:12'),
(136, 12, 'Kitchen', 7.00, 13.00, 91.00, 'utility', 'Modern kitchen with premium fittings', '2025-07-15 07:17:12'),
(137, 12, 'Dining Area', 10.00, 13.00, 130.00, 'living', 'Spacious dining area', '2025-07-15 07:17:12'),
(138, 12, 'Master Bathroom', 5.00, 7.00, 35.00, 'bathroom', 'Attached master bathroom', '2025-07-15 07:17:12'),
(139, 12, 'Common Bathroom', 4.00, 5.00, 20.00, 'bathroom', 'Common bathroom with modern fixtures', '2025-07-15 07:17:12'),
(140, 12, 'Balcony', 8.00, 28.75, 230.00, 'utility', 'Large balcony with garden views', '2025-07-15 07:17:12'),
(141, 12, 'Foyer', 5.00, 7.00, 35.00, 'utility', 'Entrance foyer', '2025-07-15 07:17:12'),
(142, 12, 'Utility Area', 3.00, 6.00, 18.00, 'utility', 'Utility area for storage', '2025-07-15 07:17:12'),
(143, 13, 'Master Bedroom', 12.00, 13.00, 156.00, 'bedroom', 'Spacious master bedroom with walk-in closet', '2025-07-15 07:17:12'),
(144, 13, 'Living Room', 16.00, 19.00, 304.00, 'living', 'Expansive living area with high ceilings', '2025-07-15 07:17:12'),
(145, 13, 'Child Bedroom 1', 10.00, 12.00, 120.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(146, 13, 'Child Bedroom 2', 9.00, 11.00, 99.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(147, 13, 'Kitchen', 8.00, 13.00, 104.00, 'utility', 'Modern kitchen with breakfast counter', '2025-07-15 07:17:12'),
(148, 13, 'Dining Area', 10.00, 14.00, 140.00, 'living', 'Formal dining area with chandelier', '2025-07-15 07:17:12'),
(149, 13, 'Master Bathroom', 5.00, 8.00, 40.00, 'bathroom', 'Luxurious master bathroom', '2025-07-15 07:17:12'),
(150, 13, 'Common Bathroom', 4.00, 5.00, 20.00, 'bathroom', 'Common bathroom with premium fixtures', '2025-07-15 07:17:12'),
(151, 13, 'Balcony', 8.00, 30.00, 240.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 07:17:12'),
(152, 13, 'Foyer', 6.00, 7.00, 42.00, 'utility', 'Grand entrance foyer', '2025-07-15 07:17:12'),
(153, 13, 'Utility Area', 4.00, 6.00, 24.00, 'utility', 'Spacious utility area', '2025-07-15 07:17:12'),
(154, 14, 'Master Bedroom', 12.00, 15.00, 180.00, 'bedroom', 'Luxurious master suite with dressing area', '2025-07-15 07:17:12'),
(155, 14, 'Living Room', 16.00, 22.00, 352.00, 'living', 'Grand living room with double-height ceilings', '2025-07-15 07:17:12'),
(156, 14, 'Child Bedroom 1', 11.00, 12.00, 132.00, 'bedroom', 'Spacious bedroom with en-suite bathroom', '2025-07-15 07:17:12'),
(157, 14, 'Child Bedroom 2', 10.00, 12.00, 120.00, 'bedroom', 'Comfortable bedroom with study area', '2025-07-15 07:17:12'),
(158, 14, 'Child Bedroom 3', 9.00, 11.00, 99.00, 'bedroom', 'Well-designed bedroom with built-in storage', '2025-07-15 07:17:12'),
(159, 14, 'Kitchen', 8.00, 14.00, 112.00, 'utility', 'Premium kitchen with island and appliances', '2025-07-15 07:17:12'),
(160, 14, 'Dining Area', 12.00, 14.00, 168.00, 'living', 'Elegant dining area with crystal chandelier', '2025-07-15 07:17:12'),
(161, 14, 'Master Bathroom', 6.00, 8.00, 48.00, 'bathroom', 'Opulent master bathroom with jacuzzi', '2025-07-15 07:17:12'),
(162, 14, 'Common Bathroom 1', 4.00, 5.00, 20.00, 'bathroom', 'Well-appointed common bathroom', '2025-07-15 07:17:12'),
(163, 14, 'Common Bathroom 2', 4.00, 5.00, 20.00, 'bathroom', 'Additional bathroom for guests', '2025-07-15 07:17:12'),
(164, 14, 'Balcony', 10.00, 30.00, 300.00, 'utility', 'Expansive balcony with outdoor seating', '2025-07-15 07:17:12'),
(165, 14, 'Foyer', 6.00, 8.00, 48.00, 'utility', 'Impressive entrance foyer', '2025-07-15 07:17:12'),
(166, 14, 'Utility Area', 4.00, 7.00, 28.00, 'utility', 'Large utility room with storage facilities', '2025-07-15 07:17:12'),
(167, 4, 'Balcony', 11.00, 22.00, 123.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 10:11:50'),
(168, 4, 'Balcony', 11.00, 22.00, 123.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 10:15:27'),
(169, 4, 'Balcony', 11.00, 22.00, 123.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 10:18:32'),
(170, 4, 'Balcony', 11.00, 22.00, 123.00, 'utility', 'Expansive balcony with panoramic views', '2025-07-15 10:22:18');

-- --------------------------------------------------------

--
-- Table structure for table `timeline`
--

CREATE TABLE `timeline` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `phase` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `completion_percentage` decimal(5,2) DEFAULT 0.00,
  `status` enum('planned','in_progress','completed','delayed','cancelled') DEFAULT 'planned',
  `milestone_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timeline`
--

INSERT INTO `timeline` (`id`, `property_id`, `phase`, `start_date`, `end_date`, `completion_percentage`, `status`, `milestone_description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Foundation & Structure', '2020-01-15', '2021-12-31', 100.00, 'completed', 'Foundation work and structural framework completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(2, 1, 'Internal Works', '2022-01-01', '2023-06-30', 100.00, 'completed', 'Internal plumbing, electrical, and finishing works completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(3, 1, 'Amenities & Landscaping', '2023-01-01', '2023-12-31', 100.00, 'completed', 'Clubhouse amenities and landscaping completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(4, 1, 'Final Finishing', '2023-07-01', '2024-03-31', 100.00, 'completed', 'Final touches and quality checks completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(5, 1, 'Possession', '2024-04-01', '2024-06-30', 100.00, 'completed', 'Ready for possession - units being handed over', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(6, 2, 'Foundation & Structure', '2021-03-01', '2022-12-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(7, 2, 'Internal Works', '2022-06-01', '2024-03-31', 85.00, 'in_progress', 'Internal works 85% complete', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(8, 2, 'Amenities & Landscaping', '2023-01-01', '2024-12-31', 60.00, 'in_progress', 'Amenities construction 60% complete', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(9, 2, 'Final Finishing', '2024-01-01', '2025-06-30', 40.00, 'in_progress', 'Final finishing work in progress', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(10, 2, 'Possession', '2025-07-01', '2025-12-31', 0.00, 'planned', 'Expected possession by end of 2025', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(11, 3, 'Foundation & Structure', '2020-06-01', '2022-03-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(12, 3, 'Internal Works', '2021-12-01', '2023-09-30', 100.00, 'completed', 'Internal works completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(13, 3, 'Amenities & Landscaping', '2022-06-01', '2024-03-31', 100.00, 'completed', 'Amenities and landscaping completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(14, 3, 'Final Finishing', '2023-06-01', '2024-06-30', 100.00, 'completed', 'Final finishing work completed', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(15, 3, 'Possession', '2024-07-01', '2024-12-31', 100.00, 'completed', 'Ready for possession', '2025-07-15 07:34:49', '2025-07-15 07:34:49'),
(16, 1, 'Foundation & Structure', '2020-01-15', '2021-12-31', 100.00, 'completed', 'Foundation work and structural framework completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(17, 1, 'Internal Works', '2022-01-01', '2023-06-30', 100.00, 'completed', 'Internal plumbing, electrical, and finishing works completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(18, 1, 'Amenities & Landscaping', '2023-01-01', '2023-12-31', 100.00, 'completed', 'Clubhouse amenities and landscaping completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(19, 1, 'Final Finishing', '2023-07-01', '2024-03-31', 100.00, 'completed', 'Final touches and quality checks completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(20, 1, 'Possession', '2024-04-01', '2024-06-30', 100.00, 'completed', 'Ready for possession - units being handed over', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(21, 2, 'Foundation & Structure', '2021-03-01', '2022-12-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(22, 2, 'Internal Works', '2022-06-01', '2024-03-31', 85.00, 'in_progress', 'Internal works 85% complete', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(23, 2, 'Amenities & Landscaping', '2023-01-01', '2024-12-31', 60.00, 'in_progress', 'Amenities construction 60% complete', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(24, 2, 'Final Finishing', '2024-01-01', '2025-06-30', 40.00, 'in_progress', 'Final finishing work in progress', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(25, 2, 'Possession', '2025-07-01', '2025-12-31', 0.00, 'planned', 'Expected possession by end of 2025', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(26, 3, 'Foundation & Structure', '2020-06-01', '2022-03-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(27, 3, 'Internal Works', '2021-12-01', '2023-09-30', 100.00, 'completed', 'Internal works completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(28, 3, 'Amenities & Landscaping', '2022-06-01', '2024-03-31', 100.00, 'completed', 'Amenities and landscaping completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(29, 3, 'Final Finishing', '2023-06-01', '2024-06-30', 100.00, 'completed', 'Final finishing work completed', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(30, 3, 'Possession', '2024-07-01', '2024-12-31', 100.00, 'completed', 'Ready for possession', '2025-07-15 07:35:19', '2025-07-15 07:35:19'),
(31, 1, 'Foundation & Structure', '2020-01-15', '2021-12-31', 100.00, 'completed', 'Foundation work and structural framework completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(32, 1, 'Internal Works', '2022-01-01', '2023-06-30', 100.00, 'completed', 'Internal plumbing, electrical, and finishing works completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(33, 1, 'Amenities & Landscaping', '2023-01-01', '2023-12-31', 100.00, 'completed', 'Clubhouse amenities and landscaping completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(34, 1, 'Final Finishing', '2023-07-01', '2024-03-31', 100.00, 'completed', 'Final touches and quality checks completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(35, 1, 'Possession', '2024-04-01', '2024-06-30', 100.00, 'completed', 'Ready for possession - units being handed over', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(36, 2, 'Foundation & Structure', '2021-03-01', '2022-12-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(37, 2, 'Internal Works', '2022-06-01', '2024-03-31', 85.00, 'in_progress', 'Internal works 85% complete', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(38, 2, 'Amenities & Landscaping', '2023-01-01', '2024-12-31', 60.00, 'in_progress', 'Amenities construction 60% complete', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(39, 2, 'Final Finishing', '2024-01-01', '2025-06-30', 40.00, 'in_progress', 'Final finishing work in progress', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(40, 2, 'Possession', '2025-07-01', '2025-12-31', 0.00, 'planned', 'Expected possession by end of 2025', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(41, 3, 'Foundation & Structure', '2020-06-01', '2022-03-31', 100.00, 'completed', 'Foundation and structural work completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(42, 3, 'Internal Works', '2021-12-01', '2023-09-30', 100.00, 'completed', 'Internal works completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(43, 3, 'Amenities & Landscaping', '2022-06-01', '2024-03-31', 100.00, 'completed', 'Amenities and landscaping completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(44, 3, 'Final Finishing', '2023-06-01', '2024-06-30', 100.00, 'completed', 'Final finishing work completed', '2025-07-15 07:35:37', '2025-07-15 07:35:37'),
(45, 3, 'Possession', '2024-07-01', '2024-12-31', 100.00, 'completed', 'Ready for possession', '2025-07-15 07:35:37', '2025-07-15 07:35:37');

-- --------------------------------------------------------

--
-- Table structure for table `unit_specifications`  
--

CREATE TABLE `unit_specifications` (
  `id` int(11) NOT NULL,
  `unit_type_id` int(11) DEFAULT NULL,
  `efficiency_percentage` decimal(5,2) DEFAULT NULL,
  `most_misused_bedrooms` text DEFAULT NULL,
  `balcony_area_ratio` decimal(5,2) DEFAULT NULL,
  `common_walls_count` int(11) DEFAULT NULL,
  `common_walls_percentage` decimal(5,2) DEFAULT NULL,
  `floor_height_meters` decimal(4,2) DEFAULT NULL,
  `carpet_area_average_price` decimal(10,2) DEFAULT NULL,
  `elevator_count` int(11) DEFAULT NULL,
  `elevator_ratio` varchar(20) DEFAULT NULL,
  `typologies` varchar(100) DEFAULT NULL,
  `vastu_compliant` tinyint(1) DEFAULT 0,
  `ventilation_rating` varchar(20) DEFAULT NULL,
  `natural_light_rating` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unit_specifications`
--

INSERT INTO `unit_specifications` (`id`, `unit_type_id`, `efficiency_percentage`, `most_misused_bedrooms`, `balcony_area_ratio`, `common_walls_count`, `common_walls_percentage`, `floor_height_meters`, `carpet_area_average_price`, `elevator_count`, `elevator_ratio`, `typologies`, `vastu_compliant`, `ventilation_rating`, `natural_light_rating`, `created_at`) VALUES
(1, 1, 62.70, 'None - well-planned layout', 12.15, 2, 40.00, 3.05, 23339.00, 4, '1:275', '2.5BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(2, 2, 62.70, 'Third bedroom can be small', 13.05, 3, 50.00, 3.05, 23355.00, 4, '1:275', '3BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(3, 3, 64.30, 'Study room might be misused as bedroom', 13.33, 3, 42.90, 3.05, 22764.00, 4, '1:275', '3.5BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(4, 4, 64.00, 'Fourth bedroom can be compact', 13.07, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(5, 5, 64.00, 'Fourth bedroom can be compact', 13.14, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(6, 6, 64.10, 'Fourth bedroom can be compact', 13.28, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:30'),
(7, 7, 66.70, 'None - well-planned layout', 13.90, 2, 40.00, 3.10, 19494.00, 3, '1:78', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(8, 8, 66.70, 'Third bedroom can be small', 12.85, 3, 50.00, 3.10, 19518.00, 3, '1:78', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(9, 9, 64.30, 'Fourth bedroom can be compact', 12.51, 4, 57.10, 3.10, 20222.00, 3, '1:78', '4BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(10, 10, 64.40, 'None - well-planned layout', 14.01, 2, 40.00, 3.15, 14493.00, 2, '1:205', '2BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(11, 11, 64.00, 'Third bedroom can be small', 14.81, 3, 50.00, 3.15, 14526.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(12, 12, 63.80, 'Third bedroom can be small', 14.98, 3, 50.00, 3.15, 14592.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(13, 13, 64.00, 'Third bedroom can be small', 14.77, 3, 50.00, 3.15, 14519.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(14, 14, 64.10, 'Fourth bedroom can be compact', 14.46, 4, 57.10, 3.15, 14511.00, 2, '1:205', '4BHK', 1, 'Good', 'Good', '2025-07-15 07:17:30'),
(15, 1, 62.70, 'None - well-planned layout', 12.15, 2, 40.00, 3.05, 23339.00, 4, '1:275', '2.5BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(16, 2, 62.70, 'Third bedroom can be small', 13.05, 3, 50.00, 3.05, 23355.00, 4, '1:275', '3BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(17, 3, 64.30, 'Study room might be misused as bedroom', 13.33, 3, 42.90, 3.05, 22764.00, 4, '1:275', '3.5BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(18, 4, 64.00, 'Fourth bedroom can be compact', 13.07, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(19, 5, 64.00, 'Fourth bedroom can be compact', 13.14, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(20, 6, 64.10, 'Fourth bedroom can be compact', 13.28, 4, 57.10, 3.05, 22857.00, 4, '1:275', '4BHK', 1, 'Excellent', 'Excellent', '2025-07-15 07:17:58'),
(21, 7, 66.70, 'None - well-planned layout', 13.90, 2, 40.00, 3.10, 19494.00, 3, '1:78', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(22, 8, 66.70, 'Third bedroom can be small', 12.85, 3, 50.00, 3.10, 19518.00, 3, '1:78', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(23, 9, 64.30, 'Fourth bedroom can be compact', 12.51, 4, 57.10, 3.10, 20222.00, 3, '1:78', '4BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(24, 10, 64.40, 'None - well-planned layout', 14.01, 2, 40.00, 3.15, 14493.00, 2, '1:205', '2BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(25, 11, 64.00, 'Third bedroom can be small', 14.81, 3, 50.00, 3.15, 14526.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(26, 12, 63.80, 'Third bedroom can be small', 14.98, 3, 50.00, 3.15, 14592.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(27, 13, 64.00, 'Third bedroom can be small', 14.77, 3, 50.00, 3.15, 14519.00, 2, '1:205', '3BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58'),
(28, 14, 64.10, 'Fourth bedroom can be compact', 14.46, 4, 57.10, 3.15, 14511.00, 2, '1:205', '4BHK', 1, 'Good', 'Good', '2025-07-15 07:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `unit_types`
--

CREATE TABLE `unit_types` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `bhk_type` varchar(10) NOT NULL,
  `configuration_name` varchar(50) DEFAULT NULL,
  `area_sqft` int(11) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `carpet_area_sqft` int(11) DEFAULT NULL,
  `carpet_area_percentage` decimal(5,2) DEFAULT NULL,
  `balcony_area_sqft` int(11) DEFAULT NULL,
  `ceiling_height_meters` decimal(4,2) DEFAULT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `unit_count` int(11) DEFAULT NULL,
  `floor_count` int(11) DEFAULT NULL,
  `price_per_sqft` decimal(10,2) DEFAULT NULL,
  `configuration_details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unit_types`
--

INSERT INTO `unit_types` (`id`, `property_id`, `bhk_type`, `configuration_name`, `area_sqft`, `price`, `carpet_area_sqft`, `carpet_area_percentage`, `balcony_area_sqft`, `ceiling_height_meters`, `bedrooms`, `bathrooms`, `unit_count`, `floor_count`, `price_per_sqft`, `configuration_details`, `created_at`) VALUES
(1, 1, '2.5BHK', 'Type A', 1646, 24087564.00, 1032, 62.70, 200, 3.05, 2, 1, 220, 28, 14634.00, '2.5BHK configuration with 1646 sq.ft area, 1032 sq.ft carpet area (62.7% efficiency), 3.05m ceiling height, two bedrooms and one bathroom', '2025-07-15 07:17:12'),
(2, 1, '3BHK', 'Type B', 1915, 28026010.00, 1200, 62.70, 250, 3.05, 3, 2, 440, 28, 14634.00, '3BHK configuration with 1915 sq.ft area, 1200 sq.ft carpet area (62.7% efficiency), 3.05m ceiling height, three bedrooms and two bathrooms', '2025-07-15 07:17:12'),
(3, 1, '3.5BHK', 'Type C', 2100, 30731400.00, 1350, 64.30, 280, 3.05, 3, 2, 200, 28, 14634.00, '3.5BHK configuration with 2100 sq.ft area, 1350 sq.ft carpet area (64.3% efficiency), 3.05m ceiling height, three bedrooms and two bathrooms with additional utility room', '2025-07-15 07:17:12'),
(4, 1, '4BHK', 'Type D1', 2296, 33600064.00, 1470, 64.00, 300, 3.05, 4, 3, 120, 28, 14634.00, '4BHK configuration D1 with 2296 sq.ft area, 1470 sq.ft carpet area (64.0% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms', '2025-07-15 07:17:12'),
(5, 1, '4BHK', 'Type D2', 2359, 34526006.00, 1510, 64.00, 310, 3.05, 4, 3, 120, 28, 14634.00, '4BHK configuration D2 with 2359 sq.ft area, 1510 sq.ft carpet area (64.0% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms', '2025-07-15 07:17:12'),
(6, 1, '4BHK', 'Type D3', 2373, 34726482.00, 1520, 64.10, 315, 3.05, 4, 3, 100, 28, 14634.00, '4BHK configuration D3 with 2373 sq.ft area, 1520 sq.ft carpet area (64.1% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms', '2025-07-15 07:17:12'),
(7, 2, '3BHK', 'Type A', 2015, 26200000.00, 1344, 66.70, 280, 3.10, 3, 2, 120, 13, 13019.00, '3BHK Type A configuration with premium layout', '2025-07-15 07:17:12'),
(8, 2, '3BHK', 'Type B', 2489, 32400000.00, 1660, 66.70, 320, 3.10, 3, 2, 84, 13, 13019.00, '3BHK Type B configuration with larger area', '2025-07-15 07:17:12'),
(9, 2, '4BHK', 'Type C', 2799, 36400000.00, 1800, 64.30, 350, 3.10, 4, 3, 30, 13, 13019.00, '4BHK Type C configuration with premium amenities', '2025-07-15 07:17:12'),
(10, 3, '2BHK', 'Type A', 1285, 12000000.00, 828, 64.40, 180, 3.15, 2, 2, 120, 21, 9300.00, '2BHK Type A configuration with optimal layout', '2025-07-15 07:17:12'),
(11, 3, '3BHK', 'Type B1', 1485, 13800000.00, 950, 64.00, 220, 3.15, 3, 2, 80, 21, 9300.00, '3BHK Type B1 configuration', '2025-07-15 07:17:12'),
(12, 3, '3BHK', 'Type B2', 1535, 14300000.00, 980, 63.80, 230, 3.15, 3, 2, 75, 21, 9300.00, '3BHK Type B2 configuration', '2025-07-15 07:17:12'),
(13, 3, '3BHK', 'Type B3', 1625, 15100000.00, 1040, 64.00, 240, 3.15, 3, 2, 70, 21, 9300.00, '3BHK Type B3 configuration', '2025-07-15 07:17:12'),
(14, 3, '4BHK', 'Type C', 2075, 19300000.00, 1330, 64.10, 300, 3.15, 4, 3, 40, 21, 9300.00, '4BHK Type C configuration with premium features', '2025-07-15 07:17:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `developers`
--
ALTER TABLE `developers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_details`
--
ALTER TABLE `financial_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `investment_analysis`
--
ALTER TABLE `investment_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `legal_details`
--
ALTER TABLE `legal_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `market_analysis`
--
ALTER TABLE `market_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `propsoch_id` (`propsoch_id`),
  ADD KEY `developer_id` (`developer_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `amenity_id` (`amenity_id`);

--
-- Indexes for table `property_challenges`
--
ALTER TABLE `property_challenges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `challenge_id` (`challenge_id`);

--
-- Indexes for table `property_connectivity`
--
ALTER TABLE `property_connectivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `property_documents`
--
ALTER TABLE `property_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `property_gallery`
--
ALTER TABLE `property_gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `room_details`
--
ALTER TABLE `room_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_type_id` (`unit_type_id`);

--
-- Indexes for table `timeline`
--
ALTER TABLE `timeline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `unit_specifications`
--
ALTER TABLE `unit_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_type_id` (`unit_type_id`);

--
-- Indexes for table `unit_types`
--
ALTER TABLE `unit_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `developers`
--
ALTER TABLE `developers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `financial_details`
--
ALTER TABLE `financial_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `investment_analysis`
--
ALTER TABLE `investment_analysis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `legal_details`
--
ALTER TABLE `legal_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `market_analysis`
--
ALTER TABLE `market_analysis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `property_amenities`
--
ALTER TABLE `property_amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `property_challenges`
--
ALTER TABLE `property_challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `property_connectivity`
--
ALTER TABLE `property_connectivity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `property_documents`
--
ALTER TABLE `property_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `property_gallery`
--
ALTER TABLE `property_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `room_details`
--
ALTER TABLE `room_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `timeline`
--
ALTER TABLE `timeline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `unit_specifications`
--
ALTER TABLE `unit_specifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `unit_types`
--
ALTER TABLE `unit_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `financial_details`
--
ALTER TABLE `financial_details`
  ADD CONSTRAINT `financial_details_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `investment_analysis`
--
ALTER TABLE `investment_analysis`
  ADD CONSTRAINT `investment_analysis_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_details`
--
ALTER TABLE `legal_details`
  ADD CONSTRAINT `legal_details_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `market_analysis`
--
ALTER TABLE `market_analysis`
  ADD CONSTRAINT `market_analysis_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`developer_id`) REFERENCES `developers` (`id`),
  ADD CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD CONSTRAINT `property_amenities_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  ADD CONSTRAINT `property_amenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`id`);

--
-- Constraints for table `property_challenges`
--
ALTER TABLE `property_challenges`
  ADD CONSTRAINT `property_challenges_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  ADD CONSTRAINT `property_challenges_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`);

--
-- Constraints for table `property_connectivity`
--
ALTER TABLE `property_connectivity`
  ADD CONSTRAINT `property_connectivity_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`);

--
-- Constraints for table `property_documents`
--
ALTER TABLE `property_documents`
  ADD CONSTRAINT `property_documents_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`);

--
-- Constraints for table `property_gallery`
--
ALTER TABLE `property_gallery`
  ADD CONSTRAINT `property_gallery_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `room_details`
--
ALTER TABLE `room_details`
  ADD CONSTRAINT `room_details_ibfk_1` FOREIGN KEY (`unit_type_id`) REFERENCES `unit_types` (`id`);

--
-- Constraints for table `timeline`
--
ALTER TABLE `timeline`
  ADD CONSTRAINT `timeline_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `unit_specifications`
--
ALTER TABLE `unit_specifications`
  ADD CONSTRAINT `unit_specifications_ibfk_1` FOREIGN KEY (`unit_type_id`) REFERENCES `unit_types` (`id`);

--
-- Constraints for table `unit_types`
--
ALTER TABLE `unit_types`
  ADD CONSTRAINT `unit_types_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
