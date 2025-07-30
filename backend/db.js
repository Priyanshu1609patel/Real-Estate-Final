const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'root',
  database: process.env.DB_NAME || 'real-estate-database',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
  ssl: { rejectUnauthorized: false } // For cloud DBs like Render
});

pool.connect((err, client, release) => {
  if (err) {
    console.error('Database connection failed:', err);
    throw err;
  }
  console.log('✅ Connected to PostgreSQL Database:', process.env.DB_NAME || 'real-estate-database');
  release();
});

module.exports = pool;
