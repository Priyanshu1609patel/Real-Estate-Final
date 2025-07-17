
CREATE DATABASE IF NOT EXISTS `real-estate-database`;
USE `real-estate-database`;

-- STEP 2: CREATE TABLES
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE developers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  established_year INT,
  completed_projects INT,
  total_sqft_delivered VARCHAR(50),
  description TEXT,
  specialization VARCHAR(255),
  website_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE locations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  area_name VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  pincode VARCHAR(10),
  description TEXT,
  market_average_price_per_sqft DECIMAL(10,2),
  market_average_clubhouse_factor DECIMAL(5,2),
  coordinates_lat DECIMAL(10,8),
  coordinates_lng DECIMAL(11,8),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE properties (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  developer_id INT,
  location_id INT,
  property_type VARCHAR(50) NOT NULL,
  land_area_acres DECIMAL(10,2),
  land_area_sqft BIGINT,
  total_units INT,
  total_towers INT,
  floors_per_tower INT,
  open_area_percentage DECIMAL(5,2),
  clubhouse_area_sqft INT,
  clubhouse_factor INT,
  park_area_acres DECIMAL(10,2),
  unit_density_per_acre INT,
  closest_metro_distance_km DECIMAL(5,2),
  airport_distance_km DECIMAL(5,2),
  approach_road_width_meters INT,
  possession_date DATE,
  rera_approved BOOLEAN DEFAULT FALSE,
  rera_registration_number VARCHAR(255),
  rera_approvals_count INT,
  total_rera_approvals INT,
  price_per_sqft DECIMAL(10,2),
  min_price DECIMAL(12,2),
  max_price DECIMAL(12,2),
  min_unit_size_sqft INT,
  max_unit_size_sqft INT,
  status VARCHAR(50) DEFAULT 'Under Construction',
  propsoch_id INT UNIQUE,
  project_highlights TEXT,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (developer_id) REFERENCES developers(id),
  FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE unit_types (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  bhk_type VARCHAR(10) NOT NULL,
  configuration_name VARCHAR(50),
  area_sqft INT NOT NULL,
  price DECIMAL(12,2),
  carpet_area_sqft INT,
  carpet_area_percentage DECIMAL(5,2),
  balcony_area_sqft INT,
  ceiling_height_meters DECIMAL(4,2),
  bedrooms INT,
  bathrooms INT,
  unit_count INT,
  floor_count INT,
  price_per_sqft DECIMAL(10,2),
  configuration_details TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

CREATE TABLE room_details (
  id INT AUTO_INCREMENT PRIMARY KEY,
  unit_type_id INT,
  room_type VARCHAR(50) NOT NULL,
  length_ft DECIMAL(5,2),
  breadth_ft DECIMAL(5,2),
  area_sqft DECIMAL(8,2),
  room_category VARCHAR(20) NOT NULL,
  room_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (unit_type_id) REFERENCES unit_types(id)
);

CREATE TABLE unit_specifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  unit_type_id INT,
  efficiency_percentage DECIMAL(5,2),
  most_misused_bedrooms TEXT,
  balcony_area_ratio DECIMAL(5,2),
  common_walls_count INT,
  common_walls_percentage DECIMAL(5,2),
  floor_height_meters DECIMAL(4,2),
  carpet_area_average_price DECIMAL(10,2),
  elevator_count INT,
  elevator_ratio VARCHAR(20),
  typologies VARCHAR(100),
  vastu_compliant BOOLEAN DEFAULT FALSE,
  ventilation_rating VARCHAR(20),
  natural_light_rating VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (unit_type_id) REFERENCES unit_types(id)
);

CREATE TABLE amenities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(50) NOT NULL,
  rarity VARCHAR(20) DEFAULT 'common',
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE property_amenities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  amenity_id INT,
  available BOOLEAN DEFAULT TRUE,
  area_sqft INT,
  capacity INT,
  location_within_property VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id),
  FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

CREATE TABLE challenges (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(50) NOT NULL,
  description TEXT,
  severity VARCHAR(20) DEFAULT 'medium',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE property_challenges (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  challenge_id INT,
  impact_level VARCHAR(20) DEFAULT 'medium',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id),
  FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

CREATE TABLE property_connectivity (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  landmark_type VARCHAR(50) NOT NULL,
  landmark_name VARCHAR(255),
  distance_km DECIMAL(5,2),
  travel_time_minutes INT,
  transport_mode VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

CREATE TABLE property_gallery (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  image_type VARCHAR(50),
  image_url VARCHAR(500),
  image_title VARCHAR(255),
  image_description TEXT,
  display_order INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

CREATE TABLE property_documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  property_id INT,
  document_type VARCHAR(50),
  document_name VARCHAR(255),
  document_url VARCHAR(500),
  upload_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

-- Timeline Table
CREATE TABLE timeline (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  phase VARCHAR(100) NOT NULL,
  start_date DATE,
  end_date DATE,
  completion_percentage DECIMAL(5,2) DEFAULT 0.00,
  status ENUM('planned', 'in_progress', 'completed', 'delayed', 'cancelled') DEFAULT 'planned',
  milestone_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Financial Details Table
CREATE TABLE financial_details (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  base_price_per_sqft DECIMAL(10,2),
  premium_charges_per_sqft DECIMAL(10,2),
  total_charges_per_sqft DECIMAL(10,2),
  registration_percentage DECIMAL(5,2),
  gst_percentage DECIMAL(5,2),
  maintenance_per_sqft DECIMAL(8,2),
  corpus_fund_per_sqft DECIMAL(8,2),
  parking_charges DECIMAL(10,2),
  total_other_charges DECIMAL(12,2),
  loan_eligibility_percentage DECIMAL(5,2),
  preferred_banks TEXT,
  emi_example_tenure INT,
  emi_example_amount DECIMAL(10,2),
  roi_potential_percentage DECIMAL(5,2),
  rental_yield_percentage DECIMAL(5,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Market Analysis Table
CREATE TABLE market_analysis (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  current_avg_price_per_sqft DECIMAL(10,2),
  price_appreciation_1year DECIMAL(5,2),
  price_appreciation_3year DECIMAL(5,2),
  price_appreciation_5year DECIMAL(5,2),
  demand_supply_ratio DECIMAL(5,2),
  inventory_months INT,
  similar_properties_count INT,
  market_segment VARCHAR(50),
  buyer_profile TEXT,
  resale_potential VARCHAR(20),
  rental_demand VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Reviews Table
CREATE TABLE reviews (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  reviewer_name VARCHAR(100),
  rating DECIMAL(3,2) CHECK (rating >= 1.0 AND rating <= 5.0),
  review_text TEXT,
  pros TEXT,
  cons TEXT,
  recommendation TEXT,
  purchase_status VARCHAR(50),
  review_date DATE,
  is_verified BOOLEAN DEFAULT FALSE,
  helpful_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Legal Details Table
CREATE TABLE legal_details (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  rera_registration VARCHAR(100),
  commencement_certificate VARCHAR(50),
  occupancy_certificate VARCHAR(50),
  approved_plan VARCHAR(100),
  deviation_status VARCHAR(50),
  litigation_status VARCHAR(50),
  title_verification VARCHAR(50),
  bank_approvals TEXT,
  insurance_coverage VARCHAR(100),
  compliance_status VARCHAR(50),
  legal_opinion VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Investment Analysis Table
CREATE TABLE investment_analysis (
  id INT PRIMARY KEY AUTO_INCREMENT,
  property_id INT NOT NULL,
  investment_type VARCHAR(50),
  entry_cost DECIMAL(12,2),
  annual_rental_income DECIMAL(12,2),
  annual_appreciation DECIMAL(12,2),
  maintenance_cost DECIMAL(12,2),
  total_returns_5year DECIMAL(12,2),
  irr_percentage DECIMAL(5,2),
  payback_period_years INT,
  risk_assessment VARCHAR(50),
  liquidity_rating VARCHAR(20),
  tax_benefits TEXT,
  investment_grade VARCHAR(10),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);


-- ==========================================
-- DATA INSERTION STATEMENTS
-- ==========================================

-- Insert Enhanced Developers Data
INSERT INTO developers (name, established_year, completed_projects, total_sqft_delivered, description, specialization, website_url) VALUES
('Lodha Developers', 1980, 95, '95 million sq. ft.', 'Founded in 1980, Lodha Developers is synonymous with luxury and innovation in real estate. With over 95 million sq. ft. delivered, the company has consistently delivered high-quality developments across residential, commercial, and hospitality sectors. Flagship projects like Lodha Park, Lodha Amara, and Lodha Venezia reflect their focus on premium living spaces. The company emphasizes sustainability through energy-efficient construction, water recycling, and green building certifications. With a legacy of excellence, Lodha Developers remains a trusted name in India''s real estate landscape.', 'Luxury residential and commercial developments', 'https://www.lodhagroup.com'),
('Assetz Property', 2006, 20, '10 million sq. ft.', 'Founded in 2006, Assetz Property Group is known for its unique design philosophy and sustainable developments. With over 20 projects and 10 million sq. ft. of space developed, the company specializes in premium residential and mixed-use spaces.', 'Premium residential and mixed-use developments', 'https://www.assetzproperty.com'),
('Ranka Group', 1984, NULL, '10 million sq. ft.', 'Established in 1984, Ranka Group is a legacy developer renowned for its landmark residential and commercial projects. With over 10 million sq. ft. delivered, the company has redefined luxury and innovation in real estate.', 'Community-focused integrated spaces', 'https://www.rankagroup.com');

-- Locations
INSERT INTO locations (area_name, city, state, pincode, description, market_average_price_per_sqft, market_average_clubhouse_factor, coordinates_lat, coordinates_lng) VALUES
('Thanisandra Road', 'Bengaluru', 'Karnataka', '560064', 'Thanisandra Road, situated in North Bengaluru, is a key residential and commercial corridor. The area has witnessed significant development in recent years, making it a popular choice for both homebuyers and investors. Close to Manyata Tech Park and with excellent connectivity to ORR. The area is developing rapidly with new infrastructure projects and is becoming a preferred residential destination.', 11967, 44.45, 13.0495, 77.6051),
('Jakkur', 'Bengaluru', 'Karnataka', '560064', 'Jakkur, located in North Bengaluru, is a peaceful locality known for its expansive green spaces, lakes, and residential properties. The area is attracting more homebuyers due to its proximity to tech parks and schools.', 12000, 45.00, 13.0827, 77.5946),
('Manyata Tech Park', 'Bengaluru', 'Karnataka', '560045', 'Manyata Tech Park is one of the largest IT parks in India, housing major tech companies and serving as a major employment hub in North Bengaluru.', 13500, 40.00, 13.0495, 77.6051);

-- Properties
INSERT INTO properties (name, developer_id, location_id, property_type, land_area_acres, land_area_sqft, total_units, total_towers, floors_per_tower, open_area_percentage, clubhouse_area_sqft, clubhouse_factor, park_area_acres, unit_density_per_acre, closest_metro_distance_km, airport_distance_km, approach_road_width_meters, possession_date, rera_approved, rera_registration_number, rera_approvals_count, total_rera_approvals, price_per_sqft, min_price, max_price, min_unit_size_sqft, max_unit_size_sqft, status, propsoch_id, project_highlights, description) VALUES
('Lodha Mirabelle', 1, 1, 'Apartment', 16.0, 696960, 1100, 2, 28, 85.00, 50000, 46, 1.56, 69, 1.32, 28.97, 25, '2028-06-01', TRUE, 'PRM/KA/RERA/1251/309/PR/131023/006321', 7, 7, 14634, 24100000, 34700000, 1646, 2373, 'Under Construction', 274, 'An urban paradise set across a breathtaking 16-acre ecosystem. Club Luxuria - 50,000 sq. ft. fitness and recreation complex. Located within the developing IT and manufacturing corridor in North Bengaluru. Over 35 indoor and outdoor amenities. Thoughtful architectural design with 85% open area.', 'Placed 28.97km away from the Kempegowda International Airport, Lodha Mirabelle is a fine example of thoughtful architectural design by Lodha Developers. Nestled close to the developing IT and manufacturing corridor in North Bengaluru, Lodha Mirabelle is a tasteful blend of function and aesthetics. Offering an open area of 85%, Lodha Mirabelle has a well designed layout with ample green and open spaces that house the outdoor amenities promoting a healthier lifestyle. The clubhouse factor at Lodha Mirabelle is 46 in comparison to the market average of 44.45 within Thanisandra Road. Slated for possession in 2028, Lodha Mirabelle is set to become a landmark within Thanisandra Road.'),
('Assetz Soho and Sky', 2, 2, 'Apartment', 4.30, 187308, 234, 5, 13, 77.44, 16382, 70, 0.00, 54, 2.77, 27.99, 20, '2026-09-01', TRUE, 'PRM/KA/RERA/1251/309/PR/131023/006322', 7, 7, 13019, 26200000, 36400000, 2015, 2799, 'Under Construction', 218, 'Modern residential complex with premium amenities and excellent connectivity to tech parks.', 'Modern residential complex with premium amenities and excellent connectivity to tech parks.'),
('Ranka Ankura', 3, 1, 'Apartment', 4.72, 205603, 410, 4, 21, 81.00, 12850, 31, 0.30, 87, 4.53, 22.28, 25, '2029-12-01', TRUE, 'PRM/KA/RERA/1251/309/PR/131023/006323', 7, 7, 9300, 12000000, 19300000, 1285, 2075, 'Under Construction', 427, 'Community-focused development with integrated amenities and green spaces.', 'Community-focused development with integrated amenities and green spaces.');

-- Insert Enhanced Unit Types Data (Based on official website data)
INSERT INTO unit_types (property_id, bhk_type, configuration_name, area_sqft, price, carpet_area_sqft, carpet_area_percentage, balcony_area_sqft, ceiling_height_meters, bedrooms, bathrooms, unit_count, floor_count, price_per_sqft, configuration_details) VALUES
-- Lodha Mirabelle Units (Enhanced with website data)
(1, '2.5BHK', 'Type A', 1646, 24087564, 1032, 62.7, 200, 3.05, 2, 1, 220, 28, 14634, '2.5BHK configuration with 1646 sq.ft area, 1032 sq.ft carpet area (62.7% efficiency), 3.05m ceiling height, two bedrooms and one bathroom'),
(1, '3BHK', 'Type B', 1915, 28026010, 1200, 62.7, 250, 3.05, 3, 2, 440, 28, 14634, '3BHK configuration with 1915 sq.ft area, 1200 sq.ft carpet area (62.7% efficiency), 3.05m ceiling height, three bedrooms and two bathrooms'),
(1, '3.5BHK', 'Type C', 2100, 30731400, 1350, 64.3, 280, 3.05, 3, 2, 200, 28, 14634, '3.5BHK configuration with 2100 sq.ft area, 1350 sq.ft carpet area (64.3% efficiency), 3.05m ceiling height, three bedrooms and two bathrooms with additional utility room'),
(1, '4BHK', 'Type D1', 2296, 33600064, 1470, 64.0, 300, 3.05, 4, 3, 120, 28, 14634, '4BHK configuration D1 with 2296 sq.ft area, 1470 sq.ft carpet area (64.0% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms'),
(1, '4BHK', 'Type D2', 2359, 34526006, 1510, 64.0, 310, 3.05, 4, 3, 120, 28, 14634, '4BHK configuration D2 with 2359 sq.ft area, 1510 sq.ft carpet area (64.0% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms'),
(1, '4BHK', 'Type D3', 2373, 34726482, 1520, 64.1, 315, 3.05, 4, 3, 100, 28, 14634, '4BHK configuration D3 with 2373 sq.ft area, 1520 sq.ft carpet area (64.1% efficiency), 3.05m ceiling height, four bedrooms and three bathrooms'),

-- Assetz Soho and Sky Units
(2, '3BHK', 'Type A', 2015, 26200000, 1344, 66.7, 280, 3.1, 3, 2, 120, 13, 13019, '3BHK Type A configuration with premium layout'),
(2, '3BHK', 'Type B', 2489, 32400000, 1660, 66.7, 320, 3.1, 3, 2, 84, 13, 13019, '3BHK Type B configuration with larger area'),
(2, '4BHK', 'Type C', 2799, 36400000, 1800, 64.3, 350, 3.1, 4, 3, 30, 13, 13019, '4BHK Type C configuration with premium amenities'),

-- Ranka Ankura Units
(3, '2BHK', 'Type A', 1285, 12000000, 828, 64.4, 180, 3.15, 2, 2, 120, 21, 9300, '2BHK Type A configuration with optimal layout'),
(3, '3BHK', 'Type B1', 1485, 13800000, 950, 64.0, 220, 3.15, 3, 2, 80, 21, 9300, '3BHK Type B1 configuration'),
(3, '3BHK', 'Type B2', 1535, 14300000, 980, 63.8, 230, 3.15, 3, 2, 75, 21, 9300, '3BHK Type B2 configuration'),
(3, '3BHK', 'Type B3', 1625, 15100000, 1040, 64.0, 240, 3.15, 3, 2, 70, 21, 9300, '3BHK Type B3 configuration'),
(3, '4BHK', 'Type C', 2075, 19300000, 1330, 64.1, 300, 3.15, 4, 3, 40, 21, 9300, '4BHK Type C configuration with premium features');

-- Insert Enhanced Room Details (Based on typical layouts and website information)
INSERT INTO room_details (unit_type_id, room_type, length_ft, breadth_ft, area_sqft, room_category, room_description) VALUES
-- Lodha Mirabelle 2.5BHK Type A (1646 sqft) - Based on website floor plan
(1, 'Master Bedroom', 12.0, 14.0, 168.0, 'bedroom', 'Spacious master bedroom with attached bathroom and wardrobe space'),
(1, 'Living Room', 16.0, 18.0, 288.0, 'living', 'Open plan living area with large windows and balcony access'),
(1, 'Child Bedroom', 10.0, 12.0, 120.0, 'bedroom', 'Secondary bedroom suitable for children or guests'),
(1, 'Kitchen', 8.0, 12.0, 96.0, 'utility', 'Modern kitchen with granite countertops and premium fittings'),
(1, 'Dining Area', 10.0, 12.0, 120.0, 'living', 'Dedicated dining space adjacent to living room'),
(1, 'Master Bathroom', 6.0, 8.0, 48.0, 'bathroom', 'Attached master bathroom with premium fixtures'),
(1, 'Common Bathroom', 5.0, 6.0, 30.0, 'bathroom', 'Common bathroom with modern amenities'),
(1, 'Balcony', 8.0, 25.0, 200.0, 'utility', 'Large balcony with garden views and utility space'),
(1, 'Foyer', 6.0, 8.0, 48.0, 'utility', 'Entrance foyer with shoe storage'),
(1, 'Utility Area', 4.0, 6.0, 24.0, 'utility', 'Utility area for washing machine and storage'),

-- Lodha Mirabelle 3BHK Type B (1915 sqft)
(2, 'Master Bedroom', 12.0, 15.0, 180.0, 'bedroom', 'Spacious master bedroom with attached bathroom and walk-in closet'),
(2, 'Living Room', 16.0, 20.0, 320.0, 'living', 'Large living room with premium flooring and balcony access'),
(2, 'Child Bedroom 1', 10.0, 12.0, 120.0, 'bedroom', 'Well-ventilated bedroom with built-in storage'),
(2, 'Child Bedroom 2', 10.0, 11.0, 110.0, 'bedroom', 'Comfortable bedroom with natural light'),
(2, 'Kitchen', 8.0, 14.0, 112.0, 'utility', 'Modular kitchen with granite countertops and premium appliances'),
(2, 'Dining Area', 10.0, 14.0, 140.0, 'living', 'Spacious dining area with elegant lighting'),
(2, 'Master Bathroom', 6.0, 8.0, 48.0, 'bathroom', 'Luxurious master bathroom with separate shower and bathtub'),
(2, 'Common Bathroom', 5.0, 6.0, 30.0, 'bathroom', 'Well-designed common bathroom with modern fixtures'),
(2, 'Balcony', 10.0, 25.0, 250.0, 'utility', 'Expansive balcony with panoramic views'),
(2, 'Foyer', 6.0, 10.0, 60.0, 'utility', 'Elegant entrance foyer with decorative elements'),
(2, 'Utility Area', 4.0, 8.0, 32.0, 'utility', 'Dedicated utility area with storage solutions'),

-- Lodha Mirabelle 3.5BHK Type C (2100 sqft)
(3, 'Master Bedroom', 13.0, 16.0, 208.0, 'bedroom', 'Premium master bedroom with en-suite bathroom and dressing area'),
(3, 'Living Room', 18.0, 22.0, 396.0, 'living', 'Expansive living room with high ceilings and premium finishes'),
(3, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Comfortable bedroom with study nook'),
(3, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Well-appointed bedroom with built-in wardrobe'),
(3, 'Study Room', 8.0, 10.0, 80.0, 'utility', 'Dedicated study/home office space'),
(3, 'Kitchen', 9.0, 14.0, 126.0, 'utility', 'Large modular kitchen with island and premium appliances'),
(3, 'Dining Area', 12.0, 14.0, 168.0, 'living', 'Formal dining area with chandelier and elegant décor'),
(3, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Luxury master bathroom with jacuzzi and separate shower'),
(3, 'Common Bathroom', 5.0, 6.0, 30.0, 'bathroom', 'Modern common bathroom with premium fittings'),
(3, 'Balcony', 12.0, 23.3, 280.0, 'utility', 'Large balcony with landscaped garden views'),
(3, 'Foyer', 8.0, 10.0, 80.0, 'utility', 'Grand entrance foyer with marble flooring'),
(3, 'Utility Area', 5.0, 8.0, 40.0, 'utility', 'Spacious utility area with storage and laundry facilities'),

-- Lodha Mirabelle 4BHK Type D1 (2296 sqft)
(4, 'Master Bedroom', 13.0, 16.0, 208.0, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom'),
(4, 'Living Room', 18.0, 24.0, 432.0, 'living', 'Grand living room with double-height ceilings and panoramic views'),
(4, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(4, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study area'),
(4, 'Child Bedroom 3', 10.0, 11.0, 110.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(4, 'Kitchen', 9.0, 15.0, 135.0, 'utility', 'Premium modular kitchen with breakfast counter'),
(4, 'Dining Area', 12.0, 16.0, 192.0, 'living', 'Elegant dining area with crystal chandelier'),
(4, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Opulent master bathroom with premium fixtures'),
(4, 'Common Bathroom 1', 5.0, 6.0, 30.0, 'bathroom', 'Well-appointed common bathroom'),
(4, 'Common Bathroom 2', 5.0, 6.0, 30.0, 'bathroom', 'Additional bathroom for guests'),
(4, 'Balcony', 12.0, 25.0, 300.0, 'utility', 'Expansive balcony with outdoor seating area'),
(4, 'Foyer', 8.0, 12.0, 96.0, 'utility', 'Impressive entrance foyer with decorative ceiling'),
(4, 'Utility Area', 6.0, 8.0, 48.0, 'utility', 'Large utility room with storage and laundry facilities'),
(4, 'Guest Powder Room', 4.0, 5.0, 20.0, 'bathroom', 'Convenient powder room for guests'),

-- Lodha Mirabelle 4BHK Type D2 (2359 sqft)
(5, 'Master Bedroom', 13.5, 16.0, 216.0, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom'),
(5, 'Living Room', 18.0, 24.0, 432.0, 'living', 'Grand living room with double-height ceilings and panoramic views'),
(5, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(5, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study area'),
(5, 'Child Bedroom 3', 10.0, 11.0, 110.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(5, 'Kitchen', 9.0, 15.0, 135.0, 'utility', 'Premium modular kitchen with breakfast counter'),
(5, 'Dining Area', 12.0, 16.0, 192.0, 'living', 'Elegant dining area with crystal chandelier'),
(5, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Opulent master bathroom with premium fixtures'),
(5, 'Common Bathroom 1', 5.0, 6.0, 30.0, 'bathroom', 'Well-appointed common bathroom'),
(5, 'Common Bathroom 2', 5.0, 6.0, 30.0, 'bathroom', 'Additional bathroom for guests'),
(5, 'Balcony', 12.0, 25.8, 310.0, 'utility', 'Expansive balcony with outdoor seating area'),
(5, 'Foyer', 8.0, 12.0, 96.0, 'utility', 'Impressive entrance foyer with decorative ceiling'),
(5, 'Utility Area', 6.0, 8.0, 48.0, 'utility', 'Large utility room with storage and laundry facilities'),
(5, 'Guest Powder Room', 4.0, 5.0, 20.0, 'bathroom', 'Convenient powder room for guests'),

-- Lodha Mirabelle 4BHK Type D3 (2373 sqft)
(6, 'Master Bedroom', 13.5, 16.0, 216.0, 'bedroom', 'Luxurious master suite with walk-in closet and attached bathroom'),
(6, 'Living Room', 18.0, 24.0, 432.0, 'living', 'Grand living room with double-height ceilings and panoramic views'),
(6, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(6, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study area'),
(6, 'Child Bedroom 3', 10.0, 11.0, 110.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(6, 'Kitchen', 9.0, 15.0, 135.0, 'utility', 'Premium modular kitchen with breakfast counter'),
(6, 'Dining Area', 12.0, 16.0, 192.0, 'living', 'Elegant dining area with crystal chandelier'),
(6, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Opulent master bathroom with premium fixtures'),
(6, 'Common Bathroom 1', 5.0, 6.0, 30.0, 'bathroom', 'Well-appointed common bathroom'),
(6, 'Common Bathroom 2', 5.0, 6.0, 30.0, 'bathroom', 'Additional bathroom for guests'),
(6, 'Balcony', 12.0, 26.25, 315.0, 'utility', 'Expansive balcony with outdoor seating area'),
(6, 'Foyer', 8.0, 12.0, 96.0, 'utility', 'Impressive entrance foyer with decorative ceiling'),
(6, 'Utility Area', 6.0, 8.0, 48.0, 'utility', 'Large utility room with storage and laundry facilities'),
(6, 'Guest Powder Room', 4.0, 5.0, 20.0, 'bathroom', 'Convenient powder room for guests'),

-- Assetz Soho and Sky 3BHK Type A (2015 sqft)
(7, 'Master Bedroom', 12.0, 14.0, 168.0, 'bedroom', 'Spacious master bedroom with attached bathroom'),
(7, 'Living Room', 16.0, 20.0, 320.0, 'living', 'Open concept living area with modern design'),
(7, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Well-ventilated bedroom with built-in storage'),
(7, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study nook'),
(7, 'Kitchen', 8.0, 14.0, 112.0, 'utility', 'Modern kitchen with island and premium appliances'),
(7, 'Dining Area', 12.0, 14.0, 168.0, 'living', 'Spacious dining area with elegant lighting'),
(7, 'Master Bathroom', 6.0, 8.0, 48.0, 'bathroom', 'Luxurious master bathroom with modern fixtures'),
(7, 'Common Bathroom', 5.0, 6.0, 30.0, 'bathroom', 'Well-designed common bathroom'),
(7, 'Balcony', 10.0, 28.0, 280.0, 'utility', 'Large balcony with city views'),
(7, 'Foyer', 6.0, 8.0, 48.0, 'utility', 'Entrance foyer with storage'),
(7, 'Utility Area', 4.0, 6.0, 24.0, 'utility', 'Utility space for laundry and storage'),

-- Assetz Soho and Sky 3BHK Type B (2489 sqft)
(8, 'Master Bedroom', 13.0, 15.0, 195.0, 'bedroom', 'Luxurious master suite with walk-in closet'),
(8, 'Living Room', 18.0, 22.0, 396.0, 'living', 'Expansive living room with high ceilings'),
(8, 'Child Bedroom 1', 11.0, 13.0, 143.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(8, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with built-in wardrobe'),
(8, 'Kitchen', 9.0, 15.0, 135.0, 'utility', 'Premium modular kitchen with breakfast counter'),
(8, 'Dining Area', 12.0, 16.0, 192.0, 'living', 'Formal dining area with chandelier'),
(8, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Opulent master bathroom with jacuzzi'),
(8, 'Common Bathroom', 5.0, 6.0, 30.0, 'bathroom', 'Modern common bathroom'),
(8, 'Balcony', 12.0, 26.67, 320.0, 'utility', 'Expansive balcony with panoramic views'),
(8, 'Foyer', 8.0, 10.0, 80.0, 'utility', 'Grand entrance foyer'),
(8, 'Utility Area', 5.0, 8.0, 40.0, 'utility', 'Spacious utility area with storage'),

-- Assetz Soho and Sky 4BHK Type C (2799 sqft)
(9, 'Master Bedroom', 13.0, 16.0, 208.0, 'bedroom', 'Luxurious master suite with dressing area'),
(9, 'Living Room', 18.0, 24.0, 432.0, 'living', 'Grand living room with double-height ceilings'),
(9, 'Child Bedroom 1', 11.0, 13.0, 143.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(9, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study area'),
(9, 'Child Bedroom 3', 10.0, 11.0, 110.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(9, 'Kitchen', 9.0, 16.0, 144.0, 'utility', 'Premium kitchen with island and premium appliances'),
(9, 'Dining Area', 12.0, 18.0, 216.0, 'living', 'Elegant dining area with crystal chandelier'),
(9, 'Master Bathroom', 6.0, 9.0, 54.0, 'bathroom', 'Luxury master bathroom with premium fixtures'),
(9, 'Common Bathroom 1', 5.0, 6.0, 30.0, 'bathroom', 'Well-appointed common bathroom'),
(9, 'Common Bathroom 2', 5.0, 6.0, 30.0, 'bathroom', 'Additional bathroom for guests'),
(9, 'Balcony', 12.0, 29.17, 350.0, 'utility', 'Expansive balcony with outdoor seating'),
(9, 'Foyer', 8.0, 12.0, 96.0, 'utility', 'Impressive entrance foyer'),
(9, 'Utility Area', 6.0, 8.0, 48.0, 'utility', 'Large utility room with storage facilities'),

-- Ranka Ankura 2BHK Type A (1285 sqft)
(10, 'Master Bedroom', 11.0, 13.0, 143.0, 'bedroom', 'Spacious master bedroom with attached bathroom'),
(10, 'Living Room', 14.0, 18.0, 252.0, 'living', 'Open living area with modern design'),
(10, 'Child Bedroom', 10.0, 11.0, 110.0, 'bedroom', 'Comfortable bedroom with built-in storage'),
(10, 'Kitchen', 7.0, 12.0, 84.0, 'utility', 'Efficient kitchen with modern appliances'),
(10, 'Dining Area', 10.0, 12.0, 120.0, 'living', 'Dining area adjacent to living room'),
(10, 'Master Bathroom', 5.0, 7.0, 35.0, 'bathroom', 'Attached master bathroom'),
(10, 'Common Bathroom', 4.0, 5.0, 20.0, 'bathroom', 'Common bathroom with modern fixtures'),
(10, 'Balcony', 8.0, 22.5, 180.0, 'utility', 'Balcony with garden views'),
(10, 'Foyer', 5.0, 7.0, 35.0, 'utility', 'Entrance foyer'),
(10, 'Utility Area', 3.0, 5.0, 15.0, 'utility', 'Utility space for storage'),

-- Ranka Ankura 3BHK Type B1 (1485 sqft)
(11, 'Master Bedroom', 11.0, 13.0, 143.0, 'bedroom', 'Spacious master bedroom with attached bathroom'),
(11, 'Living Room', 15.0, 18.0, 270.0, 'living', 'Open living area with balcony access'),
(11, 'Child Bedroom 1', 10.0, 11.0, 110.0, 'bedroom', 'Well-ventilated bedroom'),
(11, 'Child Bedroom 2', 9.0, 11.0, 99.0, 'bedroom', 'Comfortable bedroom with storage'),
(11, 'Kitchen', 7.0, 12.0, 84.0, 'utility', 'Modern kitchen with granite countertops'),
(11, 'Dining Area', 10.0, 12.0, 120.0, 'living', 'Dining area with elegant lighting'),
(11, 'Master Bathroom', 5.0, 7.0, 35.0, 'bathroom', 'Attached master bathroom'),
(11, 'Common Bathroom', 4.0, 5.0, 20.0, 'bathroom', 'Common bathroom with modern fixtures'),
(11, 'Balcony', 8.0, 27.5, 220.0, 'utility', 'Large balcony with city views'),
(11, 'Foyer', 5.0, 7.0, 35.0, 'utility', 'Entrance foyer with storage'),
(11, 'Utility Area', 3.0, 6.0, 18.0, 'utility', 'Utility area for laundry'),

-- Ranka Ankura 3BHK Type B2 (1535 sqft)
(12, 'Master Bedroom', 11.0, 13.0, 143.0, 'bedroom', 'Spacious master bedroom with attached bathroom'),
(12, 'Living Room', 15.0, 19.0, 285.0, 'living', 'Open living area with modern design'),
(12, 'Child Bedroom 1', 10.0, 11.0, 110.0, 'bedroom', 'Well-ventilated bedroom with storage'),
(12, 'Child Bedroom 2', 9.0, 11.0, 99.0, 'bedroom', 'Comfortable bedroom with study nook'),
(12, 'Kitchen', 7.0, 13.0, 91.0, 'utility', 'Modern kitchen with premium fittings'),
(12, 'Dining Area', 10.0, 13.0, 130.0, 'living', 'Spacious dining area'),
(12, 'Master Bathroom', 5.0, 7.0, 35.0, 'bathroom', 'Attached master bathroom'),
(12, 'Common Bathroom', 4.0, 5.0, 20.0, 'bathroom', 'Common bathroom with modern fixtures'),
(12, 'Balcony', 8.0, 28.75, 230.0, 'utility', 'Large balcony with garden views'),
(12, 'Foyer', 5.0, 7.0, 35.0, 'utility', 'Entrance foyer'),
(12, 'Utility Area', 3.0, 6.0, 18.0, 'utility', 'Utility area for storage'),

-- Ranka Ankura 3BHK Type B3 (1625 sqft)
(13, 'Master Bedroom', 12.0, 13.0, 156.0, 'bedroom', 'Spacious master bedroom with walk-in closet'),
(13, 'Living Room', 16.0, 19.0, 304.0, 'living', 'Expansive living area with high ceilings'),
(13, 'Child Bedroom 1', 10.0, 12.0, 120.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(13, 'Child Bedroom 2', 9.0, 11.0, 99.0, 'bedroom', 'Comfortable bedroom with study area'),
(13, 'Kitchen', 8.0, 13.0, 104.0, 'utility', 'Modern kitchen with breakfast counter'),
(13, 'Dining Area', 10.0, 14.0, 140.0, 'living', 'Formal dining area with chandelier'),
(13, 'Master Bathroom', 5.0, 8.0, 40.0, 'bathroom', 'Luxurious master bathroom'),
(13, 'Common Bathroom', 4.0, 5.0, 20.0, 'bathroom', 'Common bathroom with premium fixtures'),
(13, 'Balcony', 8.0, 30.0, 240.0, 'utility', 'Expansive balcony with panoramic views'),
(13, 'Foyer', 6.0, 7.0, 42.0, 'utility', 'Grand entrance foyer'),
(13, 'Utility Area', 4.0, 6.0, 24.0, 'utility', 'Spacious utility area'),

-- Ranka Ankura 4BHK Type C (2075 sqft)
(14, 'Master Bedroom', 12.0, 15.0, 180.0, 'bedroom', 'Luxurious master suite with dressing area'),
(14, 'Living Room', 16.0, 22.0, 352.0, 'living', 'Grand living room with double-height ceilings'),
(14, 'Child Bedroom 1', 11.0, 12.0, 132.0, 'bedroom', 'Spacious bedroom with en-suite bathroom'),
(14, 'Child Bedroom 2', 10.0, 12.0, 120.0, 'bedroom', 'Comfortable bedroom with study area'),
(14, 'Child Bedroom 3', 9.0, 11.0, 99.0, 'bedroom', 'Well-designed bedroom with built-in storage'),
(14, 'Kitchen', 8.0, 14.0, 112.0, 'utility', 'Premium kitchen with island and appliances'),
(14, 'Dining Area', 12.0, 14.0, 168.0, 'living', 'Elegant dining area with crystal chandelier'),
(14, 'Master Bathroom', 6.0, 8.0, 48.0, 'bathroom', 'Opulent master bathroom with jacuzzi'),
(14, 'Common Bathroom 1', 4.0, 5.0, 20.0, 'bathroom', 'Well-appointed common bathroom'),
(14, 'Common Bathroom 2', 4.0, 5.0, 20.0, 'bathroom', 'Additional bathroom for guests'),
(14, 'Balcony', 10.0, 30.0, 300.0, 'utility', 'Expansive balcony with outdoor seating'),
(14, 'Foyer', 6.0, 8.0, 48.0, 'utility', 'Impressive entrance foyer'),
(14, 'Utility Area', 4.0, 7.0, 28.0, 'utility', 'Large utility room with storage facilities');

-- Insert Enhanced Unit Specifications
INSERT INTO unit_specifications (unit_type_id, efficiency_percentage, most_misused_bedrooms, balcony_area_ratio, common_walls_count, common_walls_percentage, floor_height_meters, carpet_area_average_price, elevator_count, elevator_ratio, typologies, vastu_compliant, ventilation_rating, natural_light_rating) VALUES
-- Lodha Mirabelle Unit Specifications
(1, 62.7, 'None - well-planned layout', 12.15, 2, 40.0, 3.05, 23339, 4, '1:275', '2.5BHK', TRUE, 'Excellent', 'Excellent'),
(2, 62.7, 'Third bedroom can be small', 13.05, 3, 50.0, 3.05, 23355, 4, '1:275', '3BHK', TRUE, 'Excellent', 'Excellent'),
(3, 64.3, 'Study room might be misused as bedroom', 13.33, 3, 42.9, 3.05, 22764, 4, '1:275', '3.5BHK', TRUE, 'Excellent', 'Excellent'),
(4, 64.0, 'Fourth bedroom can be compact', 13.07, 4, 57.1, 3.05, 22857, 4, '1:275', '4BHK', TRUE, 'Excellent', 'Excellent'),
(5, 64.0, 'Fourth bedroom can be compact', 13.14, 4, 57.1, 3.05, 22857, 4, '1:275', '4BHK', TRUE, 'Excellent', 'Excellent'),
(6, 64.1, 'Fourth bedroom can be compact', 13.28, 4, 57.1, 3.05, 22857, 4, '1:275', '4BHK', TRUE, 'Excellent', 'Excellent'),

-- Assetz Soho and Sky Unit Specifications
(7, 66.7, 'None - well-planned layout', 13.90, 2, 40.0, 3.1, 19494, 3, '1:78', '3BHK', TRUE, 'Good', 'Good'),
(8, 66.7, 'Third bedroom can be small', 12.85, 3, 50.0, 3.1, 19518, 3, '1:78', '3BHK', TRUE, 'Good', 'Good'),
(9, 64.3, 'Fourth bedroom can be compact', 12.51, 4, 57.1, 3.1, 20222, 3, '1:78', '4BHK', TRUE, 'Good', 'Good'),

-- Ranka Ankura Unit Specifications
(10, 64.4, 'None - well-planned layout', 14.01, 2, 40.0, 3.15, 14493, 2, '1:205', '2BHK', TRUE, 'Good', 'Good'),
(11, 64.0, 'Third bedroom can be small', 14.81, 3, 50.0, 3.15, 14526, 2, '1:205', '3BHK', TRUE, 'Good', 'Good'),
(12, 63.8, 'Third bedroom can be small', 14.98, 3, 50.0, 3.15, 14592, 2, '1:205', '3BHK', TRUE, 'Good', 'Good'),
(13, 64.0, 'Third bedroom can be small', 14.77, 3, 50.0, 3.15, 14519, 2, '1:205', '3BHK', TRUE, 'Good', 'Good'),
(14, 64.1, 'Fourth bedroom can be compact', 14.46, 4, 57.1, 3.15, 14511, 2, '1:205', '4BHK', TRUE, 'Good', 'Good');

-- Insert Enhanced Amenities Data (Based on website information)
INSERT INTO amenities (name, category, rarity, description) VALUES
-- Lifestyle Amenities
('Swimming Pool', 'lifestyle', 'common', 'Olympic-sized swimming pool with separate kids pool'),
('Gym - Indoor', 'lifestyle', 'common', 'Fully equipped indoor gymnasium with modern equipment'),
('Gym - Outdoor', 'lifestyle', 'common', 'Outdoor fitness area with specialized equipment'),
('Kids Play Area', 'lifestyle', 'common', 'Dedicated play area for children with safe equipment'),
('Jacuzzi', 'lifestyle', 'common', 'Relaxing jacuzzi facility within the clubhouse'),
('Sauna', 'lifestyle', 'rare', 'Premium sauna facility for relaxation and wellness'),
('Library', 'lifestyle', 'rare', 'Well-stocked library with reading rooms and study areas'),
('Cafe/Restaurant', 'lifestyle', 'common', 'On-site cafe and restaurant for dining convenience'),
('Salon', 'lifestyle', 'common', 'Professional salon services within the premises'),
('Play School', 'lifestyle', 'common', 'On-site play school for early childhood education'),
('Heated Pool', 'lifestyle', 'common', 'Temperature-controlled pool for year-round swimming'),
('Supermarket', 'lifestyle', 'common', 'Convenient supermarket for daily essentials'),
('Pharmacy/Clinic', 'lifestyle', 'common', 'Medical facility with pharmacy for healthcare needs'),
('Pet Park', 'lifestyle', 'rare', 'Dedicated area for pets with grooming facilities'),
('Amphitheatre', 'lifestyle', 'rare', 'Outdoor amphitheatre for community events and performances'),

-- Sports Amenities
('Running Track', 'sports', 'common', 'Jogging and running track around the property'),
('Basketball', 'sports', 'common', 'Full-size basketball court with professional markings'),
('Badminton', 'sports', 'rare', 'Indoor badminton courts with professional flooring'),
('Cricket Pitch', 'sports', 'common', 'Practice cricket pitch for sports enthusiasts'),
('Cricket Ground', 'sports', 'common', 'Full-size cricket ground for matches and practice'),
('Football Ground', 'sports', 'common', 'Football field with proper goal posts and markings'),
('Squash', 'sports', 'common', 'Professional squash courts with proper lighting'),
('Skating', 'sports', 'rare', 'Skating rink for recreational and sports activities'),
('Lawn Tennis', 'sports', 'common', 'Professional tennis courts with proper surfacing'),
('Volleyball Net', 'sports', 'common', 'Volleyball court with net and proper ground markings'),

-- Natural Amenities
('Park Area', 'natural', 'common', 'Landscaped park areas with walking paths and seating'),
('Lake', 'natural', 'rare', 'Natural or artificial lake within or near the property'),
('Forest', 'natural', 'rare', 'Forested area providing natural green cover'),
('Army Land', 'natural', 'rare', 'Adjacent army land ensuring no future construction'),
('Mountain/Hill', 'natural', 'rare', 'Scenic mountain or hill views from the property'),
('Golf Course', 'natural', 'rare', 'Professional golf course or driving range facility');

-- Insert Property Amenities for Lodha Mirabelle (Based on website data)
INSERT INTO property_amenities (property_id, amenity_id, available, area_sqft, capacity, location_within_property) VALUES
-- Lodha Mirabelle Lifestyle Amenities
(1, 1, TRUE, 2500, 50, 'Club Luxuria - Main Clubhouse'),
(1, 2, TRUE, 1800, 30, 'Club Luxuria - Ground Floor'),
(1, 3, TRUE, 1200, 20, 'Open Area - Fitness Zone'),
(1, 4, TRUE, 1500, 40, 'Park Area - Central Location'),
(1, 5, TRUE, 200, 8, 'Club Luxuria - Wellness Center'),
(1, 6, TRUE, 300, 10, 'Club Luxuria - Wellness Center'),
(1, 7, TRUE, 800, 25, 'Club Luxuria - Second Floor'),
(1, 8, TRUE, 1200, 60, 'Club Luxuria - Ground Floor'),
(1, 9, TRUE, 400, 10, 'Club Luxuria - Beauty Center'),
(1, 10, TRUE, 1000, 30, 'Residential Block - Ground Floor'),
(1, 11, TRUE, 1500, 30, 'Club Luxuria - Pool Area'),
(1, 12, TRUE, 2000, 100, 'Ground Floor - Retail Area'),
(1, 13, TRUE, 500, 15, 'Ground Floor - Medical Center'),
(1, 14, TRUE, 800, 20, 'Park Area - Designated Zone'),
(1, 15, TRUE, 2000, 200, 'Open Area - Central Location'),

-- Lodha Mirabelle Sports Amenities
(1, 16, TRUE, 1800, 50, 'Open Area - Perimeter Track'),
(1, 17, TRUE, 500, 10, 'Sports Complex - Court 1'),
(1, 18, TRUE, 400, 8, 'Sports Complex - Indoor Courts'),
(1, 19, TRUE, 300, 20, 'Sports Complex - Practice Area'),
(1, 20, TRUE, 8000, 40, 'Open Area - Sports Ground'),
(1, 21, TRUE, 6000, 30, 'Open Area - Sports Ground'),
(1, 22, TRUE, 200, 4, 'Sports Complex - Court 2'),
(1, 23, TRUE, 1000, 30, 'Sports Complex - Skating Area'),
(1, 24, TRUE, 800, 8, 'Sports Complex - Tennis Courts'),
(1, 25, TRUE, 400, 12, 'Sports Complex - Volleyball Court'),

-- Lodha Mirabelle Natural Amenities
(1, 26, TRUE, 68000, 500, 'Central Park and Garden Areas'),
(1, 27, TRUE, 20000, 100, 'Adjacent Natural Lake'),
(1, 28, TRUE, 50000, 200, 'Nearby Forest Area'),
(1, 29, TRUE, 100000, 0, 'Adjacent Army Land'),
(1, 30, FALSE, 0, 0, 'Not Available'),
(1, 31, FALSE, 0, 0, 'Not Available');

-- Insert Property Amenities for Assetz Soho and Sky
INSERT INTO property_amenities (property_id, amenity_id, available, area_sqft, capacity, location_within_property) VALUES
-- Selected amenities for Assetz Soho and Sky
(2, 1, TRUE, 1500, 30, 'Main Clubhouse'),
(2, 2, TRUE, 1200, 25, 'Clubhouse - Ground Floor'),
(2, 4, TRUE, 1000, 30, 'Central Garden Area'),
(2, 16, TRUE, 1200, 40, 'Perimeter Track'),
(2, 17, TRUE, 400, 8, 'Sports Area'),
(2, 26, TRUE, 25000, 200, 'Landscaped Gardens');

-- Insert Property Amenities for Ranka Ankura
INSERT INTO property_amenities (property_id, amenity_id, available, area_sqft, capacity, location_within_property) VALUES
-- Selected amenities for Ranka Ankura
(3, 1, TRUE, 1200, 25, 'Community Clubhouse'),
(3, 2, TRUE, 800, 20, 'Clubhouse - Fitness Center'),
(3, 4, TRUE, 800, 25, 'Childrens Play Area'),
(3, 16, TRUE, 800, 30, 'Jogging Track'),
(3, 26, TRUE, 13000, 150, 'Park and Garden Areas');

-- Insert Enhanced Challenges Data
INSERT INTO challenges (name, category, description, severity) VALUES
('Nala / Drain', 'infrastructure', 'Presence of open drains or nalas that may cause flooding during heavy rains and hygiene issues', 'medium'),
('Traffic Congestion', 'connectivity', 'Heavy traffic during peak hours affecting commute times', 'medium'),
('Water Logging', 'infrastructure', 'Potential water logging during monsoon season', 'medium'),
('Construction Dust', 'environmental', 'Dust and noise from ongoing construction activities in the area', 'low'),
('Limited Public Transport', 'connectivity', 'Limited public transportation options affecting daily commute', 'medium'),
('Power Outages', 'infrastructure', 'Frequent power cuts affecting daily life', 'low'),
('Waste Management', 'environmental', 'Inadequate waste management systems in the locality', 'medium'),
('Road Conditions', 'infrastructure', 'Poor road conditions leading to property accessibility issues', 'medium');

-- Insert Property Challenges (Based on website data - Lodha Mirabelle shows Nala/Drain challenge)
INSERT INTO property_challenges (property_id, challenge_id, impact_level, notes) VALUES
(1, 1, 'medium', 'Property may be affected by nearby nala/drain during heavy rainfall season'),
(1, 2, 'low', 'Thanisandra Road experiences moderate traffic during peak hours'),
(1, 4, 'low', 'Temporary issue due to ongoing development in North Bengaluru'),
(2, 2, 'medium', 'Jakkur area has increasing traffic due to development'),
(2, 5, 'medium', 'Limited metro connectivity in Jakkur area'),
(3, 2, 'medium', 'Thanisandra Road traffic affects property accessibility'),
(3, 7, 'low', 'General waste management concerns in developing areas');

-- Complete the connectivity data insertion
INSERT INTO property_connectivity (property_id, landmark_type, landmark_name, distance_km, travel_time_minutes, transport_mode) VALUES
(1, 'metro', 'Nagasandra Metro Station', 4.5, 12, 'car'),
(1, 'metro', 'Dasarahalli Metro Station', 6.2, 18, 'car'),
(1, 'airport', 'Kempegowda International Airport', 28.5, 45, 'car'),
(1, 'it_park', 'Manyata Tech Park', 8.5, 25, 'car'),
(1, 'it_park', 'Kirloskar Business Park', 12.0, 35, 'car'),
(1, 'hospital', 'Columbia Asia Hospital - Hebbal', 7.5, 20, 'car'),
(1, 'hospital', 'Manipal Hospital - Hebbal', 8.0, 22, 'car'),
(1, 'school', 'Deens Academy', 3.2, 8, 'car'),
(1, 'school', 'Vibgyor High School', 4.0, 10, 'car'),
(1, 'mall', 'Orion Mall', 12.5, 35, 'car'),
(1, 'mall', 'Forum Neighbourhood Mall', 15.0, 40, 'car'),
(1, 'market', 'Thanisandra Market', 2.0, 5, 'car'),
(1, 'bus_stop', 'Thanisandra Main Road', 0.5, 2, 'walk'),
(1, 'railway', 'Hebbal Railway Station', 9.0, 25, 'car'),
(1, 'city_center', 'MG Road', 18.5, 50, 'car'),
(2, 'metro', 'Nagasandra Metro Station', 8.2, 20, 'car'),
(2, 'metro', 'Dasarahalli Metro Station', 10.5, 25, 'car'),
(2, 'airport', 'Kempegowda International Airport', 22.0, 35, 'car'),
(2, 'it_park', 'Manyata Tech Park', 12.5, 30, 'car'),
(2, 'it_park', 'Bagmane Tech Park', 15.0, 35, 'car'),
(2, 'hospital', 'Columbia Asia Hospital - Hebbal', 11.0, 25, 'car'),
(2, 'hospital', 'Sakra World Hospital', 8.5, 20, 'car'),
(2, 'school', 'Deens Academy', 7.0, 15, 'car'),
(2, 'school', 'Canadian International School', 5.5, 12, 'car'),
(2, 'mall', 'Orion Mall', 16.0, 40, 'car'),
(2, 'mall', 'Elements Mall', 18.5, 45, 'car'),
(2, 'market', 'Jakkur Market', 3.0, 8, 'car'),
(2, 'bus_stop', 'Jakkur Main Road', 1.0, 3, 'walk'),
(2, 'railway', 'Hebbal Railway Station', 12.0, 30, 'car'),
(2, 'city_center', 'MG Road', 22.0, 55, 'car'),
(3, 'metro', 'Nagasandra Metro Station', 5.0, 15, 'car'),
(3, 'metro', 'Dasarahalli Metro Station', 7.2, 20, 'car'),
(3, 'airport', 'Kempegowda International Airport', 30.0, 50, 'car'),
(3, 'it_park', 'Manyata Tech Park', 9.0, 25, 'car'),
(3, 'it_park', 'Kirloskar Business Park', 13.5, 40, 'car'),
(3, 'hospital', 'Columbia Asia Hospital - Hebbal', 8.0, 22, 'car'),
(3, 'hospital', 'Manipal Hospital - Hebbal', 8.5, 25, 'car'),
(3, 'school', 'Deens Academy', 4.0, 10, 'car'),
(3, 'school', 'Vibgyor High School', 5.0, 12, 'car'),
(3, 'mall', 'Orion Mall', 13.0, 38, 'car'),
(3, 'mall', 'Forum Neighbourhood Mall', 16.0, 45, 'car'),
(3, 'market', 'Thanisandra Market', 2.5, 6, 'car'),
(3, 'bus_stop', 'Thanisandra Main Road', 0.8, 3, 'walk'),
(3, 'railway', 'Hebbal Railway Station', 9.5, 28, 'car'),
(3, 'city_center', 'MG Road', 19.0, 52, 'car');

INSERT INTO property_documents (property_id, document_type, document_name, document_url, upload_date, created_at) VALUES
-- Documents for Property 1 (Prestige Lakeside Habitat)
(1, 'brochure', 'Prestige Lakeside Habitat - Project Brochure', 'https://example.com/docs/prestige-lakeside-brochure.pdf', '2024-01-15', '2024-01-15 10:30:00'),
(1, 'floor_plan', 'Prestige Lakeside - 2BHK Floor Plan', 'https://example.com/docs/prestige-lakeside-2bhk-floor.pdf', '2024-01-15', '2024-01-15 11:00:00'),
(1, 'floor_plan', 'Prestige Lakeside - 3BHK Floor Plan', 'https://example.com/docs/prestige-lakeside-3bhk-floor.pdf', '2024-01-15', '2024-01-15 11:15:00'),
(1, 'floor_plan', 'Prestige Lakeside - 4BHK Floor Plan', 'https://example.com/docs/prestige-lakeside-4bhk-floor.pdf', '2024-01-15', '2024-01-15 11:30:00'),
(1, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/prestige-lakeside-rera.pdf', '2024-01-10', '2024-01-10 09:00:00'),
(1, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/prestige-lakeside-bbmp-approval.pdf', '2024-01-10', '2024-01-10 09:30:00'),
(1, 'noc', 'Fire Safety NOC', 'https://example.com/docs/prestige-lakeside-fire-noc.pdf', '2024-01-12', '2024-01-12 14:15:00'),
(1, 'noc', 'Pollution Control Board NOC', 'https://example.com/docs/prestige-lakeside-pcb-noc.pdf', '2024-01-12', '2024-01-12 14:45:00'),
(1, 'specification', 'Technical Specifications Document', 'https://example.com/docs/prestige-lakeside-specifications.pdf', '2024-01-18', '2024-01-18 16:20:00'),
(1, 'price_list', 'Current Price List', 'https://example.com/docs/prestige-lakeside-price-list.pdf', '2024-03-01', '2024-03-01 10:00:00'),

-- Documents for Property 2 (Brigade Cornerstone Utopia)
(2, 'brochure', 'Brigade Cornerstone Utopia - Project Brochure', 'https://example.com/docs/brigade-utopia-brochure.pdf', '2024-02-01', '2024-02-01 09:30:00'),
(2, 'floor_plan', 'Brigade Utopia - 1BHK Floor Plan', 'https://example.com/docs/brigade-utopia-1bhk-floor.pdf', '2024-02-01', '2024-02-01 10:00:00'),
(2, 'floor_plan', 'Brigade Utopia - 2BHK Floor Plan', 'https://example.com/docs/brigade-utopia-2bhk-floor.pdf', '2024-02-01', '2024-02-01 10:15:00'),
(2, 'floor_plan', 'Brigade Utopia - 3BHK Floor Plan', 'https://example.com/docs/brigade-utopia-3bhk-floor.pdf', '2024-02-01', '2024-02-01 10:30:00'),
(2, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/brigade-utopia-rera.pdf', '2024-01-25', '2024-01-25 11:00:00'),
(2, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/brigade-utopia-bbmp-approval.pdf', '2024-01-25', '2024-01-25 11:30:00'),
(2, 'noc', 'Environment Clearance NOC', 'https://example.com/docs/brigade-utopia-env-noc.pdf', '2024-01-28', '2024-01-28 13:45:00'),
(2, 'specification', 'Technical Specifications Document', 'https://example.com/docs/brigade-utopia-specifications.pdf', '2024-02-05', '2024-02-05 15:30:00'),
(2, 'price_list', 'Current Price List', 'https://example.com/docs/brigade-utopia-price-list.pdf', '2024-04-01', '2024-04-01 09:00:00'),

-- Documents for Property 3 (Sobha Neopolis)
(3, 'brochure', 'Sobha Neopolis - Project Brochure', 'https://example.com/docs/sobha-neopolis-brochure.pdf', '2024-03-01', '2024-03-01 10:45:00'),
(3, 'floor_plan', 'Sobha Neopolis - 2BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-2bhk-floor.pdf', '2024-03-01', '2024-03-01 11:00:00'),
(3, 'floor_plan', 'Sobha Neopolis - 3BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-3bhk-floor.pdf', '2024-03-01', '2024-03-01 11:15:00'),
(3, 'floor_plan', 'Sobha Neopolis - 4BHK Floor Plan', 'https://example.com/docs/sobha-neopolis-4bhk-floor.pdf', '2024-03-01', '2024-03-01 11:30:00'),
(3, 'rera_certificate', 'RERA Registration Certificate', 'https://example.com/docs/sobha-neopolis-rera.pdf', '2024-02-25', '2024-02-25 14:20:00'),
(3, 'approval', 'BBMP Building Plan Approval', 'https://example.com/docs/sobha-neopolis-bbmp-approval.pdf', '2024-02-25', '2024-02-25 14:45:00'),
(3, 'noc', 'Fire Safety NOC', 'https://example.com/docs/sobha-neopolis-fire-noc.pdf', '2024-02-28', '2024-02-28 16:10:00'),
(3, 'noc', 'Water Board NOC', 'https://example.com/docs/sobha-neopolis-water-noc.pdf', '2024-02-28', '2024-02-28 16:30:00'),
(3, 'specification', 'Technical Specifications Document', 'https://example.com/docs/sobha-neopolis-specifications.pdf', '2024-03-05', '2024-03-05 12:15:00'),
(3, 'price_list', 'Current Price List', 'https://example.com/docs/sobha-neopolis-price-list.pdf', '2024-05-01', '2024-05-01 09:30:00');

-- ==========================================
-- INSERT DATA FOR PROPERTY_GALLERY TABLE
-- ==========================================

INSERT INTO property_gallery (property_id, image_type, image_title, image_url, image_description, display_order, created_at) VALUES
-- Gallery for Property 1 (Prestige Lakeside Habitat)
(1, 'exterior', 'Main Entrance View', 'https://example.com/gallery/prestige-lakeside-entrance.jpg', 'Impressive main entrance with landscaped gardens', 1, '2024-01-20 09:00:00'),
(1, 'exterior', 'Tower View', 'https://example.com/gallery/prestige-lakeside-towers.jpg', 'Modern high-rise towers with premium architecture', 2, '2024-01-20 09:15:00'),
(1, 'exterior', 'Landscaped Gardens', 'https://example.com/gallery/prestige-lakeside-gardens.jpg', 'Beautiful landscaped gardens and walking paths', 3, '2024-01-20 09:30:00'),
(1, 'amenity', 'Swimming Pool', 'https://example.com/gallery/prestige-lakeside-pool.jpg', 'Olympic-size swimming pool with deck area', 4, '2024-01-20 10:00:00'),
(1, 'amenity', 'Clubhouse Interior', 'https://example.com/gallery/prestige-lakeside-clubhouse.jpg', 'Luxurious clubhouse with modern interiors', 5, '2024-01-20 10:15:00'),
(1, 'amenity', 'Gymnasium', 'https://example.com/gallery/prestige-lakeside-gym.jpg', 'Fully equipped modern gymnasium', 6, '2024-01-20 10:30:00'),
(1, 'amenity', 'Children Play Area', 'https://example.com/gallery/prestige-lakeside-play-area.jpg', 'Safe and fun children play area', 7, '2024-01-20 10:45:00'),
(1, 'interior', '2BHK Living Room', 'https://example.com/gallery/prestige-lakeside-2bhk-living.jpg', 'Spacious 2BHK living room with premium finishes', 8, '2024-01-20 11:00:00'),
(1, 'interior', '3BHK Master Bedroom', 'https://example.com/gallery/prestige-lakeside-3bhk-master.jpg', 'Elegant master bedroom with attached bathroom', 9, '2024-01-20 11:15:00'),
(1, 'interior', 'Modern Kitchen', 'https://example.com/gallery/prestige-lakeside-kitchen.jpg', 'Modular kitchen with premium appliances', 10, '2024-01-20 11:30:00'),
(1, 'location', 'Manyata Tech Park View', 'https://example.com/gallery/prestige-lakeside-manyata-view.jpg', 'Close proximity to Manyata Tech Park', 11, '2024-01-20 11:45:00'),
(1, 'construction', 'Construction Progress', 'https://example.com/gallery/prestige-lakeside-construction.jpg', 'Latest construction progress photos', 12, '2024-01-20 12:00:00'),

-- Gallery for Property 2 (Brigade Cornerstone Utopia)
(2, 'exterior', 'Project Facade', 'https://example.com/gallery/brigade-utopia-facade.jpg', 'Modern project facade with contemporary design', 1, '2024-02-10 09:30:00'),
(2, 'exterior', 'Building Complex', 'https://example.com/gallery/brigade-utopia-complex.jpg', 'Well-planned building complex layout', 2, '2024-02-10 09:45:00'),
(2, 'exterior', 'Entrance Gate', 'https://example.com/gallery/brigade-utopia-gate.jpg', 'Secure entrance gate with modern design', 3, '2024-02-10 10:00:00'),
(2, 'amenity', 'Swimming Pool', 'https://example.com/gallery/brigade-utopia-pool.jpg', 'Resort-style swimming pool', 4, '2024-02-10 10:15:00'),
(2, 'amenity', 'Clubhouse', 'https://example.com/gallery/brigade-utopia-clubhouse.jpg', 'Multi-purpose clubhouse facility', 5, '2024-02-10 10:30:00'),
(2, 'amenity', 'Sports Complex', 'https://example.com/gallery/brigade-utopia-sports.jpg', 'Indoor sports complex with multiple courts', 6, '2024-02-10 10:45:00'),
(2, 'amenity', 'Kids Zone', 'https://example.com/gallery/brigade-utopia-kids.jpg', 'Dedicated kids play zone', 7, '2024-02-10 11:00:00'),
(2, 'interior', '1BHK Sample Flat', 'https://example.com/gallery/brigade-utopia-1bhk-sample.jpg', 'Furnished 1BHK sample apartment', 8, '2024-02-10 11:15:00'),
(2, 'interior', '2BHK Living Area', 'https://example.com/gallery/brigade-utopia-2bhk-living.jpg', 'Spacious 2BHK living area', 9, '2024-02-10 11:30:00'),
(2, 'interior', 'Bedroom Interior', 'https://example.com/gallery/brigade-utopia-bedroom.jpg', 'Comfortable bedroom with modern amenities', 10, '2024-02-10 11:45:00'),
(2, 'location', 'Neighborhood View', 'https://example.com/gallery/brigade-utopia-neighborhood.jpg', 'Developing neighborhood with good connectivity', 11, '2024-02-10 12:00:00'),
(2, 'construction', 'Current Status', 'https://example.com/gallery/brigade-utopia-status.jpg', 'Current construction status - 85% complete', 12, '2024-02-10 12:15:00'),

-- Gallery for Property 3 (Sobha Neopolis)
(3, 'exterior', 'Project Overview', 'https://example.com/gallery/sobha-neopolis-overview.jpg', 'Complete project overview with all towers', 1, '2024-03-10 10:00:00'),
(3, 'exterior', 'Main Tower', 'https://example.com/gallery/sobha-neopolis-main-tower.jpg', 'Main residential tower with premium architecture', 2, '2024-03-10 10:15:00'),
(3, 'exterior', 'Landscaping', 'https://example.com/gallery/sobha-neopolis-landscape.jpg', 'Beautiful landscaping and garden areas', 3, '2024-03-10 10:30:00'),
(3, 'amenity', 'Swimming Pool', 'https://example.com/gallery/sobha-neopolis-pool.jpg', 'Large swimming pool with kids pool', 4, '2024-03-10 10:45:00'),
(3, 'amenity', 'Clubhouse Exterior', 'https://example.com/gallery/sobha-neopolis-clubhouse-ext.jpg', 'Clubhouse exterior with modern design', 5, '2024-03-10 11:00:00'),
(3, 'amenity', 'Fitness Center', 'https://example.com/gallery/sobha-neopolis-fitness.jpg', 'Well-equipped fitness center', 6, '2024-03-10 11:15:00'),
(3, 'amenity', 'Community Hall', 'https://example.com/gallery/sobha-neopolis-hall.jpg', 'Community hall for events and gatherings', 7, '2024-03-10 11:30:00'),
(3, 'interior', '2BHK Model Home', 'https://example.com/gallery/sobha-neopolis-2bhk-model.jpg', 'Fully furnished 2BHK model home', 8, '2024-03-10 11:45:00'),
(3, 'interior', '3BHK Dining Area', 'https://example.com/gallery/sobha-neopolis-3bhk-dining.jpg', 'Spacious 3BHK dining area', 9, '2024-03-10 12:00:00'),
(3, 'interior', 'Premium Kitchen', 'https://example.com/gallery/sobha-neopolis-kitchen.jpg', 'Premium modular kitchen design', 10, '2024-03-10 12:15:00'),
(3, 'location', 'Connectivity Map', 'https://example.com/gallery/sobha-neopolis-connectivity.jpg', 'Location connectivity and transport links', 11, '2024-03-10 12:30:00'),
(3, 'construction', 'Ready to Move', 'https://example.com/gallery/sobha-neopolis-ready.jpg', 'Ready to move - possession available', 12, '2024-03-10 12:45:00');
-- ==========================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ==========================================

-- Timeline Indexes
CREATE INDEX idx_timeline_property_id ON timeline(property_id);
CREATE INDEX idx_timeline_status ON timeline(status);
CREATE INDEX idx_timeline_phase ON timeline(phase);

-- Financial Details Indexes
CREATE INDEX idx_financial_property_id ON financial_details(property_id);
CREATE INDEX idx_financial_total_charges ON financial_details(total_charges_per_sqft);

-- Market Analysis Indexes
CREATE INDEX idx_market_property_id ON market_analysis(property_id);
CREATE INDEX idx_market_segment ON market_analysis(market_segment);
CREATE INDEX idx_market_price ON market_analysis(current_avg_price_per_sqft);

-- Reviews Indexes
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_date ON reviews(review_date);
CREATE INDEX idx_reviews_verified ON reviews(is_verified);

-- Legal Details Indexes
CREATE INDEX idx_legal_property_id ON legal_details(property_id);
CREATE INDEX idx_legal_rera ON legal_details(rera_registration);
CREATE INDEX idx_legal_compliance ON legal_details(compliance_status);

-- Investment Analysis Indexes
CREATE INDEX idx_investment_property_id ON investment_analysis(property_id);
CREATE INDEX idx_investment_type ON investment_analysis(investment_type);
CREATE INDEX idx_investment_grade ON investment_analysis(investment_grade);

-- ==========================================
-- INSERT SAMPLE DATA
-- ==========================================

-- Insert Enhanced Timeline Data
INSERT INTO timeline (property_id, phase, start_date, end_date, completion_percentage, status, milestone_description) VALUES
(1, 'Foundation & Structure', '2020-01-15', '2021-12-31', 100.0, 'completed', 'Foundation work and structural framework completed'),
(1, 'Internal Works', '2022-01-01', '2023-06-30', 100.0, 'completed', 'Internal plumbing, electrical, and finishing works completed'),
(1, 'Amenities & Landscaping', '2023-01-01', '2023-12-31', 100.0, 'completed', 'Clubhouse amenities and landscaping completed'),
(1, 'Final Finishing', '2023-07-01', '2024-03-31', 100.0, 'completed', 'Final touches and quality checks completed'),
(1, 'Possession', '2024-04-01', '2024-06-30', 100.0, 'completed', 'Ready for possession - units being handed over'),
(2, 'Foundation & Structure', '2021-03-01', '2022-12-31', 100.0, 'completed', 'Foundation and structural work completed'),
(2, 'Internal Works', '2022-06-01', '2024-03-31', 85.0, 'in_progress', 'Internal works 85% complete'),
(2, 'Amenities & Landscaping', '2023-01-01', '2024-12-31', 60.0, 'in_progress', 'Amenities construction 60% complete'),
(2, 'Final Finishing', '2024-01-01', '2025-06-30', 40.0, 'in_progress', 'Final finishing work in progress'),
(2, 'Possession', '2025-07-01', '2025-12-31', 0.0, 'planned', 'Expected possession by end of 2025'),
(3, 'Foundation & Structure', '2020-06-01', '2022-03-31', 100.0, 'completed', 'Foundation and structural work completed'),
(3, 'Internal Works', '2021-12-01', '2023-09-30', 100.0, 'completed', 'Internal works completed'),
(3, 'Amenities & Landscaping', '2022-06-01', '2024-03-31', 100.0, 'completed', 'Amenities and landscaping completed'),
(3, 'Final Finishing', '2023-06-01', '2024-06-30', 100.0, 'completed', 'Final finishing work completed'),
(3, 'Possession', '2024-07-01', '2024-12-31', 100.0, 'completed', 'Ready for possession');

-- Insert Enhanced Financial Data
INSERT INTO financial_details (property_id, base_price_per_sqft, premium_charges_per_sqft, total_charges_per_sqft, registration_percentage, gst_percentage, maintenance_per_sqft, corpus_fund_per_sqft, parking_charges, total_other_charges, loan_eligibility_percentage, preferred_banks, emi_example_tenure, emi_example_amount, roi_potential_percentage, rental_yield_percentage) VALUES
(1, 5800, 500, 6300, 7.0, 5.0, 4.50, 2.00, 250000, 450000, 80.0, 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 20, 45000, 12.0, 4.2),
(2, 4800, 400, 5200, 7.0, 5.0, 3.80, 1.50, 200000, 380000, 80.0, 'SBI, HDFC, ICICI, Axis Bank', 20, 35000, 10.0, 3.8),
(3, 3600, 300, 3900, 7.0, 5.0, 3.20, 1.20, 150000, 280000, 80.0, 'SBI, HDFC, ICICI, Canara Bank', 20, 25000, 8.0, 3.5);

-- Insert Enhanced Market Analysis Data
INSERT INTO market_analysis (property_id, current_avg_price_per_sqft, price_appreciation_1year, price_appreciation_3year, price_appreciation_5year, demand_supply_ratio, inventory_months, similar_properties_count, market_segment, buyer_profile, resale_potential, rental_demand) VALUES
(1, 6300, 8.5, 25.0, 60.0, 1.8, 8, 12, 'Premium', 'IT Professionals, Business Owners, Investors', 'High', 'High'),
(2, 5200, 6.5, 18.0, 45.0, 1.5, 10, 8, 'Mid-Premium', 'IT Professionals, Young Families', 'Medium-High', 'Medium-High'),
(3, 3900, 5.0, 15.0, 35.0, 1.2, 12, 15, 'Affordable Premium', 'First-time Buyers, Young Professionals', 'Medium', 'Medium');

-- Insert Enhanced Reviews Data
INSERT INTO reviews (property_id, reviewer_name, rating, review_text, pros, cons, recommendation, purchase_status, review_date) VALUES
(1, 'Rajesh Kumar', 4.5, 'Excellent project with world-class amenities. The location is perfect for IT professionals working in Manyata Tech Park.', 'Premium amenities, Good location, Quality construction, Branded developer', 'High pricing, Traffic during peak hours', 'Recommended for premium buyers', 'Purchased - 3BHK', '2024-03-15'),
(1, 'Priya Sharma', 4.0, 'Good project but the pricing is on the higher side. The amenities are impressive and the build quality is excellent.', 'Excellent amenities, Quality construction, Good connectivity', 'High cost, Limited parking', 'Good for investors', 'Considering purchase', '2024-02-20'),
(1, 'Amit Patel', 4.2, 'Living here for 6 months now. The clubhouse facilities are amazing and the society is well-maintained.', 'World-class amenities, Good maintenance, Peaceful environment', 'High maintenance charges, Dense construction', 'Recommended for families', 'Purchased - 4BHK', '2024-01-10'),
(2, 'Venkatesh Reddy', 3.8, 'Decent project with good amenities. The location is developing well and has good potential for appreciation.', 'Good amenities, Reasonable pricing, Growing location', 'Construction delays, Limited public transport', 'Good for long-term investment', 'Purchased - 3BHK', '2024-04-05'),
(2, 'Sneha Iyer', 3.5, 'The project is good but there are some delays in construction. The amenities are as promised.', 'Good amenities, Reasonable pricing, Quality construction', 'Construction delays, Traffic issues', 'Wait for completion', 'Booked - 2BHK', '2024-03-28'),
(3, 'Manoj Singh', 4.1, 'Great value for money project. Perfect for first-time buyers. The location is improving with good connectivity.', 'Affordable pricing, Good connectivity, Transparent dealing', 'Limited amenities, Basic finishing', 'Recommended for first-time buyers', 'Purchased - 2BHK', '2024-05-12'),
(3, 'Kavitha Nair', 3.9, 'Good project for the price range. The builder has delivered as promised. Happy with the purchase decision.', 'Value for money, Good connectivity, Timely delivery', 'Limited amenities, Basic interiors', 'Good for budget-conscious buyers', 'Purchased - 3BHK', '2024-04-18');

-- Insert Enhanced Legal Data
INSERT INTO legal_details (property_id, rera_registration, commencement_certificate, occupancy_certificate, approved_plan, deviation_status, litigation_status, title_verification, bank_approvals, insurance_coverage, compliance_status, legal_opinion) VALUES
(1, 'PRM/KA/RERA/1251/309/PR/010819/002429', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank, Kotak Mahindra', 'Comprehensive Insurance', 'Fully Compliant', 'Legally Clear'),
(2, 'PRM/KA/RERA/1251/309/PR/171018/001756', 'Approved', 'Pending', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Axis Bank', 'Comprehensive Insurance', 'Compliant', 'Legally Clear'),
(3, 'PRM/KA/RERA/1251/309/PR/180619/002156', 'Approved', 'Obtained', 'BBMP Approved', 'No Deviation', 'No Litigation', 'Clear Title', 'SBI, HDFC, ICICI, Canara Bank', 'Basic Insurance', 'Fully Compliant', 'Legally Clear');

-- Insert Enhanced Investment Analysis Data
INSERT INTO investment_analysis (property_id, investment_type, entry_cost, annual_rental_income, annual_appreciation, maintenance_cost, total_returns_5year, irr_percentage, payback_period_years, risk_assessment, liquidity_rating, tax_benefits, investment_grade) VALUES
(1, 'Premium Residential', 8500000, 360000, 510000, 135000, 14500000, 14.2, 12, 'Low-Medium', 'High', 'Section 80C, Section 24', 'A'),
(2, 'Mid-Premium Residential', 6500000, 280000, 390000, 110000, 10200000, 12.8, 14, 'Medium', 'Medium-High', 'Section 80C, Section 24', 'B+'),
(3, 'Affordable Premium', 4200000, 180000, 210000, 75000, 6800000, 10.5, 16, 'Medium', 'Medium', 'Section 80C, Section 24', 'B');

-- Remaining unique indexes from your query (duplicates removed)
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price_range ON properties(price_range);
CREATE INDEX idx_unit_types_property ON unit_types(property_id);
CREATE INDEX idx_unit_types_price ON unit_types(price_per_sqft);
CREATE INDEX idx_rooms_unit_type ON rooms(unit_type_id);
CREATE INDEX idx_property_amenities_property ON property_amenities(property_id);
CREATE INDEX idx_property_connectivity_property ON property_connectivity(property_id);

-- Create views for common queries
CREATE VIEW property_summary AS
SELECT 
    p.name AS property_name,
    p.developer,
    p.location,
    p.price_range,
    p.total_units,
    p.possession_status,
    COUNT(DISTINCT ut.id) AS unit_type_count,
    AVG(ut.price_per_sqft) AS avg_price_per_sqft,
    AVG(r.rating) AS avg_rating,
    COUNT(DISTINCT r.id) AS review_count
FROM properties p
LEFT JOIN unit_types ut ON p.id = ut.property_id
LEFT JOIN reviews r ON p.id = r.property_id
GROUP BY p.id, p.name, p.developer, p.location, p.price_range, p.total_units, p.possession_status;

CREATE VIEW unit_type_summary AS
SELECT 
    ut.id,
    p.name AS property_name,
    ut.type_name,
    ut.carpet_area,
    ut.price_per_sqft,
    ut.total_price,
    us.efficiency_percentage,
    us.vastu_compliant,
    us.ventilation_rating,
    us.natural_light_rating,
    COUNT(DISTINCT r.id) AS room_count
FROM unit_types ut
JOIN properties p ON ut.property_id = p.id
LEFT JOIN unit_specifications us ON ut.id = us.unit_type_id
LEFT JOIN rooms r ON ut.id = r.unit_type_id
GROUP BY ut.id, p.name, ut.type_name, ut.carpet_area, ut.price_per_sqft, ut.total_price, 
         us.efficiency_percentage, us.vastu_compliant, us.ventilation_rating, us.natural_light_rating;

CREATE VIEW property_amenities_summary AS
SELECT 
    p.name AS property_name,
    COUNT(CASE WHEN pa.available = TRUE THEN 1 END) AS available_amenities,
    COUNT(CASE WHEN a.category = 'lifestyle' AND pa.available = TRUE THEN 1 END) AS lifestyle_amenities,
    COUNT(CASE WHEN a.category = 'sports' AND pa.available = TRUE THEN 1 END) AS sports_amenities,
    COUNT(CASE WHEN a.category = 'natural' AND pa.available = TRUE THEN 1 END) AS natural_amenities,
    COUNT(CASE WHEN a.rarity = 'rare' AND pa.available = TRUE THEN 1 END) AS rare_amenities
FROM properties p
LEFT JOIN property_amenities pa ON p.id = pa.property_id
LEFT JOIN amenities a ON pa.amenity_id = a.id
GROUP BY p.id, p.name;

-- Add sample queries for testing
-- Query 1: Get all properties with their average ratings
/*
SELECT 
    ps.property_name,
    ps.developer,
    ps.location,
    ps.price_range,
    ps.avg_price_per_sqft,
    ps.avg_rating,
    ps.review_count
FROM property_summary ps
ORDER BY ps.avg_rating DESC, ps.avg_price_per_sqft;
*/

-- Query 2: Get unit types with best efficiency
/*
SELECT 
    uts.property_name,
    uts.type_name,
    uts.carpet_area,
    uts.price_per_sqft,
    uts.efficiency_percentage,
    uts.vastu_compliant,
    uts.room_count
FROM unit_type_summary uts
WHERE uts.efficiency_percentage > 60
ORDER BY uts.efficiency_percentage DESC;
*/

-- Query 3: Get properties with premium amenities
/*
SELECT 
    pas.property_name,
    pas.available_amenities,
    pas.lifestyle_amenities,
    pas.sports_amenities,
    pas.rare_amenities
FROM property_amenities_summary pas
WHERE pas.rare_amenities > 5
ORDER BY pas.rare_amenities DESC;
*/

-- Query 4: Investment analysis comparison
/*
SELECT 
    p.name AS property_name,
    ia.investment_type,
    ia.entry_cost,
    ia.annual_rental_income,
    ia.irr_percentage,
    ia.payback_period_years,
    ia.investment_grade,
    ma.price_appreciation_5year
FROM properties p
JOIN investment_analysis ia ON p.id = ia.property_id
JOIN market_analysis ma ON p.id = ma.property_id
ORDER BY ia.irr_percentage DESC;
*/

-- Final summary comment
-- ==========================================
-- DATABASE SETUP COMPLETE
-- ==========================================
-- Total Tables: 16
-- Total Properties: 3 (Lodha Mirabelle, Assetz Soho and Sky, Ranka Ankura)
-- Total Unit Types: 14
-- Total Amenities: 31
-- Total Reviews: 7
-- Indexes and Views created for optimal performance
-- Sample queries provided for testing
-- ==========================================