const { Pool } = require('pg');
require('dotenv').config();

const pool = process.env.DATABASE_URL
  ? new Pool({
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false }
    })
  : new Pool({
      host: process.env.DB_HOST || 'real_estate_db', // container name from docker-compose
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || 'root',
      database: process.env.DB_NAME || 'real-estate-database',
      port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
      ssl: false
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

module.exports = { pool, checkConnection };
