-- Update property_gallery table with local image URLs
USE `real-estate-database`;

-- Clear existing placeholder data
DELETE FROM property_gallery WHERE image_url LIKE 'https://example.com%';

-- Insert sample local image data
INSERT INTO property_gallery (property_id, image_type, image_title, image_url, image_description, display_order, created_at) VALUES
-- Property 1 (Prestige Lakeside Habitat)
(1, 'exterior', 'Main Entrance View', '/images/property-1-entrance.jpg', 'Impressive main entrance with landscaped gardens', 1, NOW()),
(1, 'exterior', 'Tower View', '/images/property-1-towers.jpg', 'Modern high-rise towers with premium architecture', 2, NOW()),
(1, 'amenity', 'Swimming Pool', '/images/property-1-pool.jpg', 'Olympic-size swimming pool with deck area', 3, NOW()),
(1, 'interior', '2BHK Living Room', '/images/property-1-living.jpg', 'Spacious 2BHK living room with premium finishes', 4, NOW()),

-- Property 2 (Brigade Cornerstone Utopia)
(2, 'exterior', 'Project Facade', '/images/property-2-facade.jpg', 'Modern project facade with contemporary design', 1, NOW()),
(2, 'amenity', 'Swimming Pool', '/images/property-2-pool.jpg', 'Resort-style swimming pool', 2, NOW()),
(2, 'interior', '2BHK Living Area', '/images/property-2-living.jpg', 'Spacious 2BHK living area', 3, NOW()),

-- Property 3 (Sobha Neopolis)
(3, 'exterior', 'Project Overview', '/images/property-3-overview.jpg', 'Complete project overview with all towers', 1, NOW()),
(3, 'amenity', 'Swimming Pool', '/images/property-3-pool.jpg', 'Large swimming pool with kids pool', 2, NOW()),
(3, 'interior', '2BHK Model Home', '/images/property-3-model.jpg', 'Fully furnished 2BHK model home', 3, NOW()); 