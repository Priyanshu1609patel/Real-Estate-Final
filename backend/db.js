const mysql = require('mysql2/promise');
require('dotenv').config();

const isProduction = process.env.NODE_ENV === 'production';

console.log('ENV CHECK:', {
  DB_HOST: process.env.DB_HOST,
  DB_PORT: process.env.DB_PORT,
  DB_USER: process.env.DB_USER,
  DB_PASSWORD: process.env.DB_PASSWORD ? '***' : '(missing)',
  DB_NAME: process.env.DB_NAME,
  MYSQL_SSL: process.env.MYSQL_SSL,
});

const db = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'root',
  database: process.env.DB_NAME || 'real-estate-database',
  port: process.env.DB_PORT || 3306,
  ssl: isProduction
    ? { rejectUnauthorized: false } // ✅ allow Railway self-signed cert
    : undefined,
  connectTimeout: 60000,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  timezone: 'Z'
});

(async () => {
  try {
    const connection = await db.getConnection();
    console.log(`✅ Connected to MySQL Database: ${process.env.DB_NAME || 'real-estate-database'}`);
    connection.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
  }
})();

module.exports = db;
