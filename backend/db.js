const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: parseInt(process.env.DB_PORT || '5432'),
  ssl: {
    rejectUnauthorized: false,
    sslmode: 'require'
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

module.exports = {
  pool,
  query: pool.query,
  checkConnection
};

// Export the checkConnection function for server.js
module.exports.checkConnection = checkConnection;
