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

module.exports = {
  pool,
  query: pool.query,
  checkConnection
};
