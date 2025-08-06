const mysql = require('mysql2/promise');

/**
 * Database configuration for different environments
 */
const getDbConfig = () => {
  // Check if we're running in Railway environment
  const isRailway = process.env.RAILWAY_ENVIRONMENT === 'production' || 
                   process.env.RAILWAY_SERVICE_NAME !== undefined ||
                   process.env.MYSQLHOST !== undefined;

  if (isRailway) {
    // Railway environment - use environment variables with fallbacks
    console.log('Using Railway database configuration');
    
    // Parse MYSQL_URL if available (Railway provides this)
    let mysqlConfig = {};
    if (process.env.MYSQL_URL) {
      try {
        const url = new URL(process.env.MYSQL_URL);
        mysqlConfig = {
          host: url.hostname,
          port: parseInt(url.port, 10) || 3306,
          user: url.username,
          password: url.password,
          database: url.pathname.replace(/^\//, '')
        };
      } catch (error) {
        console.error('Error parsing MYSQL_URL:', error);
      }
    }

    // Use Railway's environment variables
    const config = {
      host: process.env.MYSQLHOST || 'mysql.railway.internal',
      port: parseInt(process.env.MYSQLPORT || '3306', 10),
      user: process.env.MYSQLUSER || 'root',
      password: process.env.MYSQLPASSWORD || '',
      database: process.env.MYSQLDATABASE || 'railway',
      // Enable SSL for secure connection
      ssl: process.env.MYSQL_SSL === 'true' ? { rejectUnauthorized: false } : false,
      connectTimeout: 60000, // Increased timeout to 60 seconds
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      debug: process.env.NODE_ENV === 'development',
      timezone: 'Z' // Use UTC timezone
    };
    
    console.log('Database connection config:', {
      host: config.host,
      port: config.port,
      user: config.user,
      database: config.database,
      ssl: config.ssl ? 'enabled' : 'disabled',
      usingMysqlUrl: !!process.env.MYSQL_URL
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
