const express = require('express');
const cors = require('cors');
const path = require('path');
const fs = require('fs');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// Serve static files from the frontend/public directory
app.use(express.static(path.join(__dirname, '../frontend/public')));

// Serve files from /public path as well
app.use('/public', express.static(path.join(__dirname, '../frontend/public')));

// Serve admin files from the frontend/admin directory
app.use('/admin', express.static(path.join(__dirname, '../frontend/admin')));

// Serve the home page as the default route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/public/index.html'));
});

// Helper function to convert string booleans and numbers
function sanitizeData(data, schema) {
  const sanitized = {};
  for (const key in data) {
    if (!schema[key]) {
      sanitized[key] = data[key];
      continue;
    }
    const type = schema[key];
    if (type === 'int' || type === 'bigint') {
      sanitized[key] = data[key] !== undefined && data[key] !== '' ? Number(data[key]) : null;
    } else if (type === 'decimal' || type === 'float') {
      sanitized[key] = data[key] !== undefined && data[key] !== '' ? parseFloat(data[key]) : null;
    } else if (type === 'boolean') {
      sanitized[key] = data[key] === 'true' || data[key] === true || data[key] === 1 || data[key] === '1' ? 1 : 0;
    } else {
      sanitized[key] = data[key];
    }
  }
  return sanitized;
}

// Table schemas for type conversion
const schemas = {
  developers: {
    established_year: 'int',
    completed_projects: 'int',
    total_sqft_delivered: 'string',
    description: 'string',
    specialization: 'string',
    website_url: 'string',
  },
  locations: {
    area_name: 'string', city: 'string', state: 'string', pincode: 'string', description: 'string',
    market_average_price_per_sqft: 'decimal', market_average_clubhouse_factor: 'decimal',
    coordinates_lat: 'decimal', coordinates_lng: 'decimal',
  },
  properties: {
    developer_id: 'int', location_id: 'int', property_type: 'string', land_area_acres: 'decimal', land_area_sqft: 'bigint',
    total_units: 'int', total_towers: 'int', floors_per_tower: 'int', open_area_percentage: 'decimal', clubhouse_area_sqft: 'int',
    clubhouse_factor: 'int', park_area_acres: 'decimal', unit_density_per_acre: 'int', closest_metro_distance_km: 'decimal',
    airport_distance_km: 'decimal', approach_road_width_meters: 'int', possession_date: 'string', rera_approved: 'boolean',
    rera_registration_number: 'string', rera_approvals_count: 'int', total_rera_approvals: 'int', price_per_sqft: 'decimal',
    min_price: 'decimal', max_price: 'decimal', min_unit_size_sqft: 'int', max_unit_size_sqft: 'int', status: 'string',
    propsoch_id: 'int', project_highlights: 'string', description: 'string',
  },
  unit_types: {
    property_id: 'int', bhk_type: 'string', configuration_name: 'string', area_sqft: 'int', price: 'decimal',
    carpet_area_sqft: 'int', carpet_area_percentage: 'decimal', balcony_area_sqft: 'int', ceiling_height_meters: 'decimal',
    bedrooms: 'int', bathrooms: 'int', unit_count: 'int', floor_count: 'int', price_per_sqft: 'decimal', configuration_details: 'string',
  },
  room_details: {
    unit_type_id: 'int', room_type: 'string', length_ft: 'decimal', breadth_ft: 'decimal', area_sqft: 'decimal', room_category: 'string', room_description: 'string',
  },
  unit_specifications: {
    unit_type_id: 'int', efficiency_percentage: 'decimal', most_misused_bedrooms: 'string', balcony_area_ratio: 'decimal',
    common_walls_count: 'int', common_walls_percentage: 'decimal', floor_height_meters: 'decimal', carpet_area_average_price: 'decimal',
    elevator_count: 'int', elevator_ratio: 'string', typologies: 'string', vastu_compliant: 'boolean', ventilation_rating: 'string', natural_light_rating: 'string',
  },
  amenities: {
    name: 'string', category: 'string', rarity: 'string', description: 'string',
  },
  property_amenities: {
    property_id: 'int', amenity_id: 'int', available: 'boolean', area_sqft: 'int', capacity: 'int', location_within_property: 'string',
  },
  challenges: {
    name: 'string', category: 'string', description: 'string', severity: 'string',
  },
  property_challenges: {
    property_id: 'int', challenge_id: 'int', impact_level: 'string', notes: 'string',
  },
  property_connectivity: {
    property_id: 'int', landmark_type: 'string', landmark_name: 'string', distance_km: 'decimal', travel_time_minutes: 'int', transport_mode: 'string',
  },
  property_gallery: {
    property_id: 'int', image_type: 'string', image_url: 'string', image_title: 'string', image_description: 'string', display_order: 'int',
  },
  property_documents: {
    property_id: 'int', document_type: 'string', document_name: 'string', document_url: 'string', upload_date: 'string',
  },
  timeline: {
    property_id: 'int', phase: 'string', start_date: 'string', end_date: 'string', completion_percentage: 'decimal', status: 'string', milestone_description: 'string',
  },
  financial_details: {
    property_id: 'int', base_price_per_sqft: 'decimal', premium_charges_per_sqft: 'decimal', total_charges_per_sqft: 'decimal', registration_percentage: 'decimal', gst_percentage: 'decimal', maintenance_per_sqft: 'decimal', corpus_fund_per_sqft: 'decimal', parking_charges: 'decimal', total_other_charges: 'decimal', loan_eligibility_percentage: 'decimal', preferred_banks: 'string', emi_example_tenure: 'int', emi_example_amount: 'decimal', roi_potential_percentage: 'decimal', rental_yield_percentage: 'decimal',
  },
  market_analysis: {
    property_id: 'int', current_avg_price_per_sqft: 'decimal', price_appreciation_1year: 'decimal', price_appreciation_3year: 'decimal', inventory_months: 'int', similar_properties_count: 'int', market_segment: 'string', buyer_profile: 'string', resale_potential: 'string', rental_demand: 'string',
  },
  reviews: {
    property_id: 'int', reviewer_name: 'string', rating: 'int', review_text: 'string', pros: 'string', cons: 'string', recommendation: 'string', purchase_status: 'string', review_date: 'string', is_verified: 'boolean',
  },
  legal_details: {
    property_id: 'int', rera_registration: 'string', commencement_certificate: 'string', occupancy_certificate: 'string', approved_plan: 'string', deviation_status: 'string', litigation_status: 'string', title_verification: 'string', bank_approvals: 'string', insurance_coverage: 'string', compliance_status: 'string', legal_opinion: 'string',
  },
  investment_analysis: {
    property_id: 'int', investment_type: 'string', entry_cost: 'decimal', annual_rental_income: 'decimal', annual_appreciation: 'decimal', maintenance_cost: 'decimal', total_returns_5year: 'decimal', irr_percentage: 'decimal', payback_period_years: 'decimal', risk_assessment: 'string', liquidity_rating: 'string', tax_benefits: 'string', investment_grade: 'string',
  },
};

app.post('/api/developers', (req, res) => {
  const data = sanitizeData(req.body, schemas.developers);
  db.query('INSERT INTO developers SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/developers', (req, res) => {
  db.query('SELECT * FROM developers', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Locations
app.post('/api/locations', (req, res) => {
  const data = sanitizeData(req.body, schemas.locations);
  db.query('INSERT INTO locations SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/locations', (req, res) => {
  db.query('SELECT * FROM locations', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Properties
app.post('/api/properties', (req, res) => {
  const data = sanitizeData(req.body, schemas.properties);
  db.query('INSERT INTO properties SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/properties', (req, res) => {
  db.query('SELECT * FROM properties', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Users
app.get('/api/users', (req, res) => {
  db.query('SELECT id, username, email, created_at FROM users', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// --- FULL PROPERTY DETAILS ENDPOINT FOR COMPARISON ---
app.get('/api/properties/full', async (req, res) => {
  try {
    // Get all properties with developer and location info
    db.query(`
      SELECT p.*, d.name AS developer_name, d.website_url, l.area_name, l.city, l.state
      FROM properties p
      LEFT JOIN developers d ON p.developer_id = d.id
      LEFT JOIN locations l ON p.location_id = l.id
    `, async (err, properties) => {
      if (err) return res.status(500).json({ error: err });
      if (!properties.length) return res.json([]);

      // Get all amenities, galleries, etc. in parallel
      db.query('SELECT * FROM property_gallery', (err, galleries) => {
        if (err) return res.status(500).json({ error: err });
        db.query('SELECT pa.property_id, a.name, a.category FROM property_amenities pa LEFT JOIN amenities a ON pa.amenity_id = a.id WHERE pa.available = 1', (err, amenities) => {
          if (err) return res.status(500).json({ error: err });

          // Map amenities by property_id
          const amenitiesMap = {};
          amenities.forEach(a => {
            if (!amenitiesMap[a.property_id]) amenitiesMap[a.property_id] = [];
            amenitiesMap[a.property_id].push({ name: a.name, category: a.category });
          });

          // Map galleries by property_id (pick first image as main)
          const galleryMap = {};
          galleries.forEach(g => {
            if (!galleryMap[g.property_id]) galleryMap[g.property_id] = [];
            galleryMap[g.property_id].push(g);
          });

          // Compose full property objects
          const fullProperties = properties.map(p => {
            const images = galleryMap[p.id] || [];
            let mainImage = images.length ? images[0].image_url : null;
            if (!mainImage) mainImage = `/images/placeholder-property.jpg`;
            return {
              ...p,
              mainImage,
              amenities: amenitiesMap[p.id] || [],
              developer: {
                name: p.developer_name,
                website_url: p.website_url
              },
              location: {
                area_name: p.area_name,
                city: p.city,
                state: p.state
              }
            };
          });

          res.json(fullProperties);
        });
      });
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.post('/api/unit_types', (req, res) => {
  const data = sanitizeData(req.body, schemas.unit_types);
  db.query('INSERT INTO unit_types SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/unit_types', (req, res) => {
  db.query('SELECT * FROM unit_types', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/room_details', (req, res) => {
  const data = sanitizeData(req.body, schemas.room_details);
  db.query('INSERT INTO room_details SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/room_details', (req, res) => {
  db.query('SELECT * FROM room_details', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/unit_specifications', (req, res) => {
  const data = sanitizeData(req.body, schemas.unit_specifications);
  db.query('INSERT INTO unit_specifications SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/unit_specifications', (req, res) => {
  db.query('SELECT * FROM unit_specifications', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/amenities', (req, res) => {
  const data = sanitizeData(req.body, schemas.amenities);
  db.query('INSERT INTO amenities SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/amenities', (req, res) => {
  db.query('SELECT * FROM amenities', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/property_amenities', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_amenities);
  db.query('INSERT INTO property_amenities SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/property_amenities', (req, res) => {
  db.query('SELECT * FROM property_amenities', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/challenges', (req, res) => {
  const data = sanitizeData(req.body, schemas.challenges);
  db.query('INSERT INTO challenges SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/challenges', (req, res) => {
  db.query('SELECT * FROM challenges', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/property_challenges', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_challenges);
  db.query('INSERT INTO property_challenges SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/property_challenges', (req, res) => {
  db.query('SELECT * FROM property_challenges', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/property_connectivity', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_connectivity);
  db.query('INSERT INTO property_connectivity SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/property_connectivity', (req, res) => {
  db.query('SELECT * FROM property_connectivity', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/property_gallery', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_gallery);
  db.query('INSERT INTO property_gallery SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/property_gallery', (req, res) => {
  db.query('SELECT * FROM property_gallery', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/property_documents', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_documents);
  db.query('INSERT INTO property_documents SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/property_documents', (req, res) => {
  db.query('SELECT * FROM property_documents', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/timeline', (req, res) => {
  const data = sanitizeData(req.body, schemas.timeline);
  db.query('INSERT INTO timeline SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/timeline', (req, res) => {
  db.query('SELECT * FROM timeline', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/financial_details', (req, res) => {
  const data = sanitizeData(req.body, schemas.financial_details);
  db.query('INSERT INTO financial_details SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/financial_details', (req, res) => {
  db.query('SELECT * FROM financial_details', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/market_analysis', (req, res) => {
  const data = sanitizeData(req.body, schemas.market_analysis);
  db.query('INSERT INTO market_analysis SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/market_analysis', (req, res) => {
  db.query('SELECT * FROM market_analysis', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/reviews', (req, res) => {
  const data = sanitizeData(req.body, schemas.reviews);
  db.query('INSERT INTO reviews SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/reviews', (req, res) => {
  db.query('SELECT * FROM reviews', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/legal_details', (req, res) => {
  const data = sanitizeData(req.body, schemas.legal_details);
  db.query('INSERT INTO legal_details SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/legal_details', (req, res) => {
  db.query('SELECT * FROM legal_details', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

app.post('/api/investment_analysis', (req, res) => {
  const data = sanitizeData(req.body, schemas.investment_analysis);
  db.query('INSERT INTO investment_analysis SET ?', data, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/investment_analysis', (req, res) => {
  db.query('SELECT * FROM investment_analysis', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// --- PUT and DELETE endpoints for all entities ---

// Developers
app.put('/api/developers/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.developers);
  db.query('UPDATE developers SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) {
      console.error('DB Update Error:', err);
      return res.status(500).json({ error: err });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Developer not found' });
    }
    res.json({ message: 'Developer updated' });
  });
});
app.delete('/api/developers/:id', (req, res) => {
  db.query('DELETE FROM developers WHERE id = ?', [req.params.id], (err, result) => {
    if (err) {
      console.error('DB Delete Error:', err);
      return res.status(500).json({ error: err });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Developer not found' });
    }
    res.json({ message: 'Developer deleted' });
  });
});

// Locations
app.put('/api/locations/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.locations);
  db.query('UPDATE locations SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Location not found' });
    res.json({ message: 'Location updated' });
  });
});
app.delete('/api/locations/:id', (req, res) => {
  db.query('DELETE FROM locations WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Location not found' });
    res.json({ message: 'Location deleted' });
  });
});

// Properties
app.put('/api/properties/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.properties);
  db.query('UPDATE properties SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property not found' });
    res.json({ message: 'Property updated' });
  });
});
app.delete('/api/properties/:id', (req, res) => {
  db.query('DELETE FROM properties WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property not found' });
    res.json({ message: 'Property deleted' });
  });
});

// Unit Types
app.put('/api/unit_types/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.unit_types);
  db.query('UPDATE unit_types SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Unit type not found' });
    res.json({ message: 'Unit type updated' });
  });
});
app.delete('/api/unit_types/:id', (req, res) => {
  db.query('DELETE FROM unit_types WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Unit type not found' });
    res.json({ message: 'Unit type deleted' });
  });
});

// Room Details
app.put('/api/room_details/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.room_details);
  db.query('UPDATE room_details SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Room detail not found' });
    res.json({ message: 'Room detail updated' });
  });
});
app.delete('/api/room_details/:id', (req, res) => {
  db.query('DELETE FROM room_details WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Room detail not found' });
    res.json({ message: 'Room detail deleted' });
  });
});

// Unit Specifications
app.put('/api/unit_specifications/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.unit_specifications);
  db.query('UPDATE unit_specifications SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Unit specification not found' });
    res.json({ message: 'Unit specification updated' });
  });
});
app.delete('/api/unit_specifications/:id', (req, res) => {
  db.query('DELETE FROM unit_specifications WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Unit specification not found' });
    res.json({ message: 'Unit specification deleted' });
  });
});

// Amenities
app.put('/api/amenities/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.amenities);
  db.query('UPDATE amenities SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Amenity not found' });
    res.json({ message: 'Amenity updated' });
  });
});
app.delete('/api/amenities/:id', (req, res) => {
  db.query('DELETE FROM amenities WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Amenity not found' });
    res.json({ message: 'Amenity deleted' });
  });
});

// Property Amenities
app.put('/api/property_amenities/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_amenities);
  db.query('UPDATE property_amenities SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property amenity not found' });
    res.json({ message: 'Property amenity updated' });
  });
});
app.delete('/api/property_amenities/:id', (req, res) => {
  db.query('DELETE FROM property_amenities WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property amenity not found' });
    res.json({ message: 'Property amenity deleted' });
  });
});

// Challenges
app.put('/api/challenges/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.challenges);
  db.query('UPDATE challenges SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Challenge not found' });
    res.json({ message: 'Challenge updated' });
  });
});
app.delete('/api/challenges/:id', (req, res) => {
  db.query('DELETE FROM challenges WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Challenge not found' });
    res.json({ message: 'Challenge deleted' });
  });
});

// Property Challenges
app.put('/api/property_challenges/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_challenges);
  db.query('UPDATE property_challenges SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property challenge not found' });
    res.json({ message: 'Property challenge updated' });
  });
});
app.delete('/api/property_challenges/:id', (req, res) => {
  db.query('DELETE FROM property_challenges WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property challenge not found' });
    res.json({ message: 'Property challenge deleted' });
  });
});

// Property Connectivity
app.put('/api/property_connectivity/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_connectivity);
  db.query('UPDATE property_connectivity SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property connectivity not found' });
    res.json({ message: 'Property connectivity updated' });
  });
});
app.delete('/api/property_connectivity/:id', (req, res) => {
  db.query('DELETE FROM property_connectivity WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property connectivity not found' });
    res.json({ message: 'Property connectivity deleted' });
  });
});

// Property Gallery
app.put('/api/property_gallery/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_gallery);
  db.query('UPDATE property_gallery SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property gallery not found' });
    res.json({ message: 'Property gallery updated' });
  });
});
app.delete('/api/property_gallery/:id', (req, res) => {
  db.query('DELETE FROM property_gallery WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property gallery not found' });
    res.json({ message: 'Property gallery deleted' });
  });
});

// Property Documents
app.put('/api/property_documents/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.property_documents);
  db.query('UPDATE property_documents SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property document not found' });
    res.json({ message: 'Property document updated' });
  });
});
app.delete('/api/property_documents/:id', (req, res) => {
  db.query('DELETE FROM property_documents WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Property document not found' });
    res.json({ message: 'Property document deleted' });
  });
});

// Timeline
app.put('/api/timeline/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.timeline);
  db.query('UPDATE timeline SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Timeline not found' });
    res.json({ message: 'Timeline updated' });
  });
});
app.delete('/api/timeline/:id', (req, res) => {
  db.query('DELETE FROM timeline WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Timeline not found' });
    res.json({ message: 'Timeline deleted' });
  });
});

// Financial Details
app.put('/api/financial_details/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.financial_details);
  db.query('UPDATE financial_details SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Financial detail not found' });
    res.json({ message: 'Financial detail updated' });
  });
});
app.delete('/api/financial_details/:id', (req, res) => {
  db.query('DELETE FROM financial_details WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Financial detail not found' });
    res.json({ message: 'Financial detail deleted' });
  });
});

// Market Analysis
app.put('/api/market_analysis/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.market_analysis);
  db.query('UPDATE market_analysis SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Market analysis not found' });
    res.json({ message: 'Market analysis updated' });
  });
});
app.delete('/api/market_analysis/:id', (req, res) => {
  db.query('DELETE FROM market_analysis WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Market analysis not found' });
    res.json({ message: 'Market analysis deleted' });
  });
});

// Reviews
app.put('/api/reviews/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.reviews);
  db.query('UPDATE reviews SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Review not found' });
    res.json({ message: 'Review updated' });
  });
});
app.delete('/api/reviews/:id', (req, res) => {
  db.query('DELETE FROM reviews WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Review not found' });
    res.json({ message: 'Review deleted' });
  });
});

// Legal Details
app.put('/api/legal_details/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.legal_details);
  db.query('UPDATE legal_details SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Legal detail not found' });
    res.json({ message: 'Legal detail updated' });
  });
});
app.delete('/api/legal_details/:id', (req, res) => {
  db.query('DELETE FROM legal_details WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Legal detail not found' });
    res.json({ message: 'Legal detail deleted' });
  });
});

// Investment Analysis
app.put('/api/investment_analysis/:id', (req, res) => {
  const data = sanitizeData(req.body, schemas.investment_analysis);
  db.query('UPDATE investment_analysis SET ? WHERE id = ?', [data, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Investment analysis not found' });
    res.json({ message: 'Investment analysis updated' });
  });
});
app.delete('/api/investment_analysis/:id', (req, res) => {
  db.query('DELETE FROM investment_analysis WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Investment analysis not found' });
    res.json({ message: 'Investment analysis deleted' });
  });
});

const userRoutes = require('./routes/userRoutes');
app.use('/api', userRoutes);

app.listen(3001, () => console.log('Server running on 3001')); 