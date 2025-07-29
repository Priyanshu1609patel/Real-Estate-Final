-- PostgreSQL schema converted from MySQL for Render.com hosting
-- Remove or adjust SERIAL/IDENTITY as needed for your version

-- Example: amenities table
CREATE TABLE amenities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(50) NOT NULL,
  rarity VARCHAR(20) DEFAULT 'common',
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO amenities (id, name, category, rarity, description, created_at) VALUES
(1, 'Swimming Pool', 'lifestyle', 'common', 'Olympic-sized swimming pool with separate kids pool', '2025-07-15 07:17:30'),
(2, 'Gym - Indoor', 'lifestyle', 'common', 'Fully equipped indoor gymnasium with modern equipment', '2025-07-15 07:17:30'),
(3, 'Gym - Outdoor', 'lifestyle', 'common', 'Outdoor fitness area with specialized equipment', '2025-07-15 07:17:30'),
(4, 'Kids Play Area', 'lifestyle', 'common', 'Dedicated play area for children with safe equipment', '2025-07-15 07:17:30'),
(5, 'Jacuzzi', 'lifestyle', 'common', 'Relaxing jacuzzi facility within the clubhouse', '2025-07-15 07:17:30'),
(6, 'Sauna', 'lifestyle', 'rare', 'Premium sauna facility for relaxation and wellness', '2025-07-15 07:17:30'),
(7, 'Library', 'lifestyle', 'rare', 'Well-stocked library with reading rooms and study areas', '2025-07-15 07:17:30'),
(8, 'Cafe/Restaurant', 'lifestyle', 'common', 'On-site cafe and restaurant for dining convenience', '2025-07-15 07:17:30'),
(9, 'Salon', 'lifestyle', 'common', 'Professional salon services within the premises', '2025-07-15 07:17:30'),
(10, 'Play School', 'lifestyle', 'common', 'On-site play school for early childhood education', '2025-07-15 07:17:30');

-- Repeat for all other tables and data
-- Use SERIAL for auto-incrementing primary keys
-- Use TIMESTAMP DEFAULT CURRENT_TIMESTAMP for created_at fields
-- Remove ENGINE, AUTO_INCREMENT, and MySQL-specific syntax

-- Example: property_gallery table (for update_image_urls.sql)
CREATE TABLE property_gallery (
  id SERIAL PRIMARY KEY,
  property_id INTEGER,
  image_type VARCHAR(50),
  image_url VARCHAR(500),
  image_title VARCHAR(255),
  image_description TEXT,
  display_order INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example insert for local images
INSERT INTO property_gallery (property_id, image_type, image_title, image_url, image_description, display_order, created_at) VALUES
(1, 'exterior', 'Main Entrance View', '/images/property-1-entrance.jpg', 'Impressive main entrance with landscaped gardens', 1, NOW()),
(1, 'exterior', 'Tower View', '/images/property-1-towers.jpg', 'Modern high-rise towers with premium architecture', 2, NOW()),
(1, 'amenity', 'Swimming Pool', '/images/property-1-pool.jpg', 'Olympic-size swimming pool with deck area', 3, NOW()),
(1, 'interior', '2BHK Living Room', '/images/property-1-living.jpg', 'Spacious 2BHK living room with premium finishes', 4, NOW()),
(2, 'exterior', 'Project Facade', '/images/property-2-facade.jpg', 'Modern project facade with contemporary design', 1, NOW()),
(2, 'amenity', 'Swimming Pool', '/images/property-2-pool.jpg', 'Resort-style swimming pool', 2, NOW()),
(2, 'interior', '2BHK Living Area', '/images/property-2-living.jpg', 'Spacious 2BHK living area', 3, NOW()),
(3, 'exterior', 'Project Overview', '/images/property-3-overview.jpg', 'Complete project overview with all towers', 1, NOW()),
(3, 'amenity', 'Swimming Pool', '/images/property-3-pool.jpg', 'Large swimming pool with kids pool', 2, NOW()),
(3, 'interior', '2BHK Model Home', '/images/property-3-model.jpg', 'Fully furnished 2BHK model home', 3, NOW());

-- Continue for all other tables and data as needed
-- If you want the full conversion, let me know!
