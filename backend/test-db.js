const { Pool } = require('pg');
require('dotenv').config();

// Use the full hostname directly from environment variables
const dbHost = process.env.DB_HOST;

const pool = new Pool({
  host: dbHost,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: parseInt(process.env.DB_PORT || '5432'),
  ssl: {
    rejectUnauthorized: false,
    sslmode: 'require'
  }
});

async function testConnection() {
  const client = await pool.connect();
  try {
    console.log('Testing database connection...');
    const res = await client.query('SELECT NOW()');
    console.log('✅ Database connection successful!');
    console.log('Current database time:', res.rows[0].now);
    
    // Test if users table exists and count records
    const users = await client.query('SELECT COUNT(*) FROM users');
    console.log(`📊 Total users in database: ${users.rows[0].count}`);
    
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
    if (err.code === '42P01') {
      console.log('Note: The users table might not exist yet.');
    }
  } finally {
    client.release();
    await pool.end();
  }
}

testConnection();
