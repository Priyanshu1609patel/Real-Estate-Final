const mysql = require('mysql2/promise');

/**
 * Database configuration for different environments
 */
const getDbConfig = () => {
  // Check if we're running in Railway environment
  const isRailway = process.env.RAILWAY_ENVIRONMENT === 'production' || 
                   process.env.RAILWAY_SERVICE_NAME !== undefined;

  if (isRailway) {
    // Railway environment
    return {
      host: process.env.MYSQLHOST || 'containers-us-west-123.railway.app',
      port: process.env.MYSQLPORT || 6605,
      user: process.env.MYSQLUSER || 'root',
      password: process.env.MYSQLPASSWORD || 'root',
      database: process.env.MYSQLDATABASE || 'real-estate-database',
      ssl: { rejectUnauthorized: false },
      connectTimeout: 10000,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    };
  }

  // Local development environment
  return {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'root',
    database: process.env.DB_NAME || 'real-estate-database',
    connectTimeout: 10000,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  };
};

// Create a connection pool for better performance
const pool = mysql.createPool(getDbConfig());

// Test the database connection
const testConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('✅ Successfully connected to MySQL database');
    connection.release();
    return true;
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    console.error('Connection details:', {
      host: process.env.MYSQLHOST || process.env.DB_HOST || 'localhost',
      port: process.env.MYSQLPORT || process.env.DB_PORT || 3306,
      database: process.env.MYSQLDATABASE || process.env.DB_NAME || 'real-estate-database',
      user: process.env.MYSQLUSER || process.env.DB_USER || 'root',
      ssl: process.env.MYSQL_SSL ? 'enabled' : 'disabled'
    });
    return false;
  }
};

// Test the connection when this module is loaded
testConnection().then(success => {
  if (!success) {
    console.error('⚠️  Failed to establish database connection. The application may not function correctly.');
  }
});

// Export the pool for use in the application
module.exports = pool;
