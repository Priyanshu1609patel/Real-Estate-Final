const express = require('express');
const cors = require('cors');
const path = require('path');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { pool, query, checkConnection } = require('./db'); // Import pool, query, and checkConnection from db.js

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

const PORT = process.env.PORT || 3001;
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key_here';

async function startServer() {
  try {
    await checkConnection(); // ✅ Wait for PostgreSQL
    app.listen(PORT, () => {
      console.log(`🚀 Server running on port ${PORT}`);
    });
  } catch (err) {
    console.error('❌ Could not start server:', err.message);
    process.exit(1);
  }
}

startServer();


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

// Authentication Middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) return res.sendStatus(401);

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
};

// Login endpoint
app.post('/api/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    
    // Validate input
    if (!username || !password) {
      return res.status(400).json({ error: 'Username and password are required' });
    }

    // Find user by username or email
    const result = await pool.query(
      'SELECT * FROM users WHERE username = $1 OR email = $1',
      [username]
    );

    const user = result.rows[0];
    
    // Check if user exists
    if (!user) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    // Verify password
    const validPassword = await bcrypt.compare(password, user.password_hash);
    if (!validPassword) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    // Create and sign JWT token
    const token = jwt.sign(
      { 
        id: user.id, 
        username: user.username, 
        email: user.email 
      }, 
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    // Return user data (excluding password) and token
    const { password_hash, ...userWithoutPassword } = user;
    res.json({
      user: userWithoutPassword,
      token
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error during login' });
  }
});

// Register endpoint
app.post('/api/register', async (req, res) => {
  try {
    const { username, email, password } = req.body;
    
    // Validate input
    if (!username || !email || !password) {
      return res.status(400).json({ error: 'All fields are required' });
    }

    // Check if username or email already exists
    const existingUser = await pool.query(
      'SELECT * FROM users WHERE username = $1 OR email = $2',
      [username, email]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({ error: 'Username or email already exists' });
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);

    // Create new user
    const result = await pool.query(
      'INSERT INTO users (username, email, password_hash) VALUES ($1, $2, $3) RETURNING id, username, email, created_at',
      [username, email, password_hash]
    );

    const newUser = result.rows[0];
    
    // Generate token
    const token = jwt.sign(
      { 
        id: newUser.id, 
        username: newUser.username, 
        email: newUser.email 
      }, 
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.status(201).json({
      user: newUser,
      token
    });

  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Internal server error during registration' });
  }
});

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
  const columns = Object.keys(data).map(key => `${key} = $${Object.keys(data).indexOf(key) + 1}`).join(', ');
  const values = Object.values(data);
  db.query(`INSERT INTO developers (${columns})`, values, (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/developers', (req, res) => {
  db.query('SELECT * FROM developers', (err, results) => {
    if (err) {
      console.error('DB Query Error:', err);
      return res.status(500).json({ error: err });
    }
    res.json(results.rows);
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
    console.log('Fetching properties...');
    const properties = await new Promise((resolve, reject) => {
      pool.query(`
        SELECT 
          p.id,
          p.name,
          p.developer_id,
          p.location_id,
          p.property_type,
          p.land_area_acres,
          p.land_area_sqft,
          p.total_units,
          p.total_towers,
          p.floors_per_tower,
          p.open_area_percentage,
          p.clubhouse_area_sqft,
          p.clubhouse_factor,
          p.park_area_acres,
          p.unit_density_per_acre,
          p.closest_metro_distance_km,
          p.airport_distance_km,
          p.approach_road_width_meters,
          p.possession_date,
          p.rera_approved,
          p.rera_registration_number,
          p.rera_approvals_count,
          p.total_rera_approvals,
          p.price_per_sqft,
          p.min_price,
          p.max_price,
          p.min_unit_size_sqft,
          p.max_unit_size_sqft,
          p.status,
          p.propsoch_id,
          p.project_highlights,
          p.description,
          d.name AS developer_name,
          d.website_url,
          l.area_name,
          l.city,
          l.state,
          l.pincode,
          l.market_average_price_per_sqft,
          l.market_average_clubhouse_factor
        FROM properties p
        LEFT JOIN developers d ON p.developer_id = d.id
        LEFT JOIN locations l ON p.location_id = l.id
      `, (err, result) => {
        if (err) {
          console.error('Properties query error:', err);
          return reject(err);
        }
        console.log('Properties fetched:', result.rows.length);
        result.rows.forEach((p, index) => {
          console.log(`Property ${index + 1}:`, {
            id: p.id,
            name: p.name,
            developer: p.developer_name,
            location: p.area_name
          });
        });
        resolve(result.rows);
      });
    });

    if (!properties.length) return res.json([]);

    // Get all amenities and galleries in parallel
    console.log('Fetching amenities and galleries...');
    const [galleries, amenities] = await Promise.all([
      new Promise((resolve, reject) => {
        pool.query('SELECT * FROM property_gallery', (err, result) => {
          if (err) {
            console.error('Gallery query error:', err);
            return reject(err);
          }
          console.log('Galleries fetched:', result.rows.length);
          result.rows.forEach((g, index) => {
            console.log(`Gallery ${index + 1}:`, {
              id: g.id,
              property_id: g.property_id,
              image_url: g.image_url
            });
          });
          resolve(result.rows);
        });
      }),
      new Promise((resolve, reject) => {
        pool.query('SELECT pa.property_id, a.name, a.category FROM property_amenities pa LEFT JOIN amenities a ON pa.amenity_id = a.id WHERE pa.available = true', (err, result) => {
          if (err) {
            console.error('Amenities query error:', err);
            return reject(err);
          }
          console.log('Amenities fetched:', result.rows.length);
          result.rows.forEach((a, index) => {
            console.log(`Amenity ${index + 1}:`, {
              property_id: a.property_id,
              name: a.name,
              category: a.category
            });
          });
          resolve(result.rows);
        });
      })
    ]);

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
      galleryMap[g.property_id].push({
        id: g.id,
        image_url: g.image_url || `/images/placeholder-property.jpg`,
        property_id: g.property_id
      });
    });

    // Compose full property objects
    const fullProperties = properties.map(p => {
      const images = galleryMap[p.id] || [];
      const mainImage = images.length ? images[0].image_url : `/images/placeholder-property.jpg`;
      console.log('Processing property:', {
        id: p.id,
        name: p.name,
        imagesCount: images.length,
        amenitiesCount: amenitiesMap[p.id] ? amenitiesMap[p.id].length : 0
      });
      return {
        id: p.id,
        name: p.name,
        developer_id: p.developer_id,
        location_id: p.location_id,
        property_type: p.property_type,
        land_area_acres: p.land_area_acres,
        land_area_sqft: p.land_area_sqft,
        total_units: p.total_units,
        total_towers: p.total_towers,
        floors_per_tower: p.floors_per_tower,
        open_area_percentage: p.open_area_percentage,
        clubhouse_area_sqft: p.clubhouse_area_sqft,
        clubhouse_factor: p.clubhouse_factor,
        park_area_acres: p.park_area_acres,
        unit_density_per_acre: p.unit_density_per_acre,
        closest_metro_distance_km: p.closest_metro_distance_km,
        airport_distance_km: p.airport_distance_km,
        approach_road_width_meters: p.approach_road_width_meters,
        possession_date: p.possession_date,
        rera_approved: p.rera_approved,
        rera_registration_number: p.rera_registration_number,
        rera_approvals_count: p.rera_approvals_count,
        total_rera_approvals: p.total_rera_approvals,
        price_per_sqft: p.price_per_sqft,
        min_price: p.min_price,
        max_price: p.max_price,
        min_unit_size_sqft: p.min_unit_size_sqft,
        max_unit_size_sqft: p.max_unit_size_sqft,
        status: p.status,
        propsoch_id: p.propsoch_id,
        project_highlights: p.project_highlights,
        description: p.description,
        developer: {
          name: p.developer_name,
          website_url: p.website_url
        },
        location: {
          area_name: p.area_name,
          city: p.city,
          state: p.state,
          pincode: p.pincode,
          market_average_price_per_sqft: p.market_average_price_per_sqft,
          market_average_clubhouse_factor: p.market_average_clubhouse_factor
        },
        mainImage,
        images,
        amenities: amenitiesMap[p.id] || []
      };
    });

    console.log('Sending response with', fullProperties.length, 'properties');
    res.json(fullProperties);
  } catch (err) {
    console.error('Error in properties/full endpoint:', err);
    res.status(500).json({ 
      error: 'Failed to fetch property details',
      details: err.message
    });
  }
});

app.post('/api/unit_types', (req, res) => {
  const data = sanitizeData(req.body, schemas.unit_types);
  // ... (rest of the code remains the same)
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
  console.log('Fetching timeline data...');
  pool.query('SELECT * FROM timeline', (err, results) => {
    if (err) {
      console.error('Timeline query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch timeline data',
        details: err.message
      });
    }
    console.log('Timeline data fetched:', results.rows.length);
    res.json(results.rows);
  });
});

app.post('/api/financial_details', (req, res) => {
  const data = sanitizeData(req.body, schemas.financial_details);
  pool.query('INSERT INTO financial_details (property_id, base_price_per_sqft) VALUES ($1, $2) RETURNING *', [data.property_id, data.base_price_per_sqft], (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/financial_details', (req, res) => {
  console.log('Fetching financial details...');
  pool.query('SELECT * FROM financial_details', (err, results) => {
    if (err) {
      console.error('Financial details query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch financial details',
        details: err.message
      });
    }
    console.log('Financial details fetched:', results.rows.length);
    res.json(results.rows);
  });
});

app.post('/api/market_analysis', (req, res) => {
  const data = sanitizeData(req.body, schemas.market_analysis);
  pool.query('INSERT INTO market_analysis (property_id, current_avg_price_per_sqft, price_appreciation_1year, price_appreciation_3year, price_appreciation_5year, demand_supply_ratio, inventory_months, similar_properties_count, market_segment, buyer_profile, resale_potential, rental_demand) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING *', [data.property_id, data.current_avg_price_per_sqft, data.price_appreciation_1year, data.price_appreciation_3year, data.price_appreciation_5year, data.demand_supply_ratio, data.inventory_months, data.similar_properties_count, data.market_segment, data.buyer_profile, data.resale_potential, data.rental_demand], (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/market_analysis', (req, res) => {
  console.log('Fetching market analysis...');
  pool.query('SELECT * FROM market_analysis', (err, results) => {
    if (err) {
      console.error('Market analysis query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch market analysis',
        details: err.message
      });
    }
    console.log('Market analysis fetched:', results.rows.length);
    res.json(results.rows);
  });
});

app.post('/api/reviews', (req, res) => {
  const data = sanitizeData(req.body, schemas.reviews);
  pool.query('INSERT INTO reviews (property_id, rating, comment, created_at) VALUES ($1, $2, $3, CURRENT_TIMESTAMP) RETURNING *', [data.property_id, data.rating, data.comment], (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/reviews', (req, res) => {
  console.log('Fetching reviews...');
  pool.query('SELECT * FROM reviews', (err, results) => {
    if (err) {
      console.error('Reviews query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch reviews',
        details: err.message
      });
    }
    console.log('Reviews fetched:', results.rows.length);
    res.json(results.rows);
  });
});

app.post('/api/legal_details', (req, res) => {
  const data = sanitizeData(req.body, schemas.legal_details);
  pool.query('INSERT INTO legal_details (property_id, rera_registration, commencement_certificate, occupancy_certificate, approved_plan, deviation_status, litigation_status, title_verification, bank_approvals, insurance_coverage, compliance_status, legal_opinion) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING *', [data.property_id, data.rera_registration, data.commencement_certificate, data.occupancy_certificate, data.approved_plan, data.deviation_status, data.litigation_status, data.title_verification, data.bank_approvals, data.insurance_coverage, data.compliance_status, data.legal_opinion], (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/legal_details', (req, res) => {
  console.log('Fetching legal details...');
  pool.query('SELECT * FROM legal_details', (err, results) => {
    if (err) {
      console.error('Legal details query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch legal details',
        details: err.message
      });
    }
    console.log('Legal details fetched:', results.rows.length);
    res.json(results.rows);
  });
});

app.post('/api/investment_analysis', (req, res) => {
  const data = sanitizeData(req.body, schemas.investment_analysis);
  pool.query('INSERT INTO investment_analysis (property_id, investment_type, entry_cost, annual_rental_income, annual_appreciation, maintenance_cost, total_returns_5year, irr_percentage, payback_period_years, risk_assessment, liquidity_rating, tax_benefits, investment_grade) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING *', [data.property_id, data.investment_type, data.entry_cost, data.annual_rental_income, data.annual_appreciation, data.maintenance_cost, data.total_returns_5year, data.irr_percentage, data.payback_period_years, data.risk_assessment, data.liquidity_rating, data.tax_benefits, data.investment_grade], (err, result) => {
    if (err) {
      console.error('DB Insert Error:', err);
      return res.status(500).json({ error: err });
    }
    res.status(201).json({ id: result.insertId, ...data });
  });
});

app.get('/api/investment_analysis', (req, res) => {
  console.log('Fetching investment analysis...');
  pool.query('SELECT * FROM investment_analysis', (err, results) => {
    if (err) {
      console.error('Investment analysis query error:', err);
      return res.status(500).json({ 
        error: 'Failed to fetch investment analysis',
        details: err.message
      });
    }
    console.log('Investment analysis fetched:', results.rows.length);
    res.json(results.rows);
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