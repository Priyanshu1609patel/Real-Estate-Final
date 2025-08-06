console.log('Password length:', process.env.DB_PASSWORD?.length || 'MISSING');
const mysql = require('mysql2/promise');
require('dotenv').config();

const isProduction = process.env.NODE_ENV === 'production';

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: process.env.MYSQL_SSL === 'true' 
    ? { rejectUnauthorized: false }
    : undefined,
  connectTimeout: 60000,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  timezone: 'Z'
});

(async () => {
  try {
    const conn = await pool.getConnection();
    console.log(`✅ Successfully connected to database: ${process.env.DB_NAME}`);
    conn.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
    console.error('Connection details:', {
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      database: process.env.DB_NAME,
      user: process.env.DB_USER,
      ssl: process.env.MYSQL_SSL === 'true' ? 'enabled' : 'disabled'
    });
  }
})();

module.exports = pool;
