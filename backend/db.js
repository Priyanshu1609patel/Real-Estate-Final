const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
  ssl: { rejectUnauthorized: false } // Required for Render.com
});

pool.connect((err, client, release) => {
  if (err) {
    console.error('Database connection failed:', err);
    throw err;
  }
  console.log('✅ Connected to PostgreSQL Database:', process.env.DB_NAME);
  release();
});

module.exports = pool;
