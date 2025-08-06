const mysql = require('mysql2/promise');
require('dotenv').config();

const config = {
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
};

// Debug config (without showing password)
console.log('Database connection config:', {
  host: config.host,
  port: config.port,
  user: config.user,
  database: config.database,
  ssl: config.ssl ? 'enabled' : 'disabled'
});

// Extra debug: confirm password exists
console.log('Password length:', process.env.DB_PASSWORD?.length || 'MISSING');

const pool = mysql.createPool(config);

(async () => {
  try {
    const connection = await pool.getConnection();
    console.log(`✅ Connected to MySQL Database: ${config.database}`);
    connection.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
    console.error('Connection details:', {
      host: config.host,
      port: config.port,
      user: config.user,
      database: config.database,
      ssl: config.ssl ? 'enabled' : 'disabled'
    });
  }
})();

module.exports = pool;
