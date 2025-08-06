const mysql = require('mysql2/promise');

/**
 * Database configuration for different environments
 */
const getDbConfig = () => {
  // Check if we're running in Railway environment
  const isRailway = process.env.RAILWAY_ENVIRONMENT === 'production' || 
                   process.env.RAILWAY_SERVICE_NAME !== undefined;

  if (isRailway) {
    // Railway environment - use environment variables without defaults
    console.log('Using Railway database configuration');
    const config = {
      host: process.env.MYSQLHOST,
      port: parseInt(process.env.MYSQLPORT || '3306', 10),
      user: process.env.MYSQLUSER,
      password: process.env.MYSQLPASSWORD,
      database: process.env.MYSQLDATABASE,
      ssl: process.env.MYSQL_SSL === 'true' ? { rejectUnauthorized: false } : undefined,
      connectTimeout: 30000, // Increased timeout to 30 seconds
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      debug: process.env.NODE_ENV === 'development'
    };
    
    console.log('Database connection config:', {
      ...config,
      password: config.password ? '***' : 'undefined',
      ssl: config.ssl ? 'enabled' : 'disabled'
    });
    
    return config;
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
