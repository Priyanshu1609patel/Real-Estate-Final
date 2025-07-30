const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: 'dpg-d24agbvgi27c73dd2u4g-a.singapore-postgres.render.com',
  user: 'real_estate_user',
  password: 'KexjQ06hwfyawgcOuQrcegm4XzcVskgg',
  database: 'real_estate_db_m1j4',
  port: 5432,
  ssl: {
    rejectUnauthorized: false
  }
});

async function checkConnection(retries = 10, delay = 5000) {
  for (let i = 0; i < retries; i++) {
    try {
      const res = await pool.query('SELECT NOW()');
      console.log('✅ Connected to PostgreSQL Database. Time:', res.rows[0].now);
      return true;
    } catch (err) {
      console.error(`❌ DB not ready (attempt ${i + 1}/${retries})`, err.message);
      await new Promise(res => setTimeout(res, delay));
    }
  }
  throw new Error('❌ Could not connect to PostgreSQL after several attempts');
}

async function setupIndexes() {
  try {
    console.log('Setting up database indexes...');
    
    // Create indexes for frequently joined columns
    await pool.query('CREATE INDEX IF NOT EXISTS idx_properties_developer ON properties(developer_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_property_amenities_property ON property_amenities(property_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_property_amenities_amenity ON property_amenities(amenity_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_property_gallery_property ON property_gallery(property_id)');
    
    console.log('Indexes created successfully');
  } catch (err) {
    console.error('Error setting up indexes:', err);
    throw err;
  }
}

module.exports = {
  pool,
  query: pool.query,
  checkConnection,
  setupIndexes
};

// Export the checkConnection function for server.js
module.exports.checkConnection = checkConnection;
