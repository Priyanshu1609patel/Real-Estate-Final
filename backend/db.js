const { Pool } = require('pg');
require('dotenv').config();

const pool = process.env.DATABASE_URL
  ? new Pool({
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false }
    })
  : new Pool({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || 'root',
      database: process.env.DB_NAME || 'real-estate-database',
      port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
      ssl: false
    });

pool.connect((err, client, release) => {
  if (err) {
    console.error('Database connection failed:', err);
    throw err;
  }
  console.log('✅ Connected to PostgreSQL Database');
  release();
});

module.exports = pool;
