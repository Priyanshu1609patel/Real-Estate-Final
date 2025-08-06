const mysql = require('mysql2/promise');
require('dotenv').config();

const isProduction = process.env.NODE_ENV === 'production';

const db = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'root',
  database: process.env.DB_NAME || 'real-estate-database',
  port: process.env.DB_PORT || 3306,
  ssl: isProduction ? { rejectUnauthorized: true } : undefined
});

(async () => {
  try {
    const connection = await db.getConnection();
    console.log(`✅ Connected to MySQL Database: ${process.env.DB_NAME || 'real-estate-database'}`);
    connection.release(); // release connection back to pool
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
  }
})();

module.exports = db;
