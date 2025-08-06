const mysql = require('mysql2/promise');

// Database configuration for Railway
const getDbConfig = () => {
  console.log('Using Railway database configuration');
  
  // Log available environment variables for debugging
  const relevantVars = Object.keys(process.env)
    .filter(key => key.startsWith('MYSQL') || key.startsWith('RAILWAY_') || key === 'NODE_ENV')
    .join(', ');
  console.log('Available environment variables:', relevantVars || 'None found');

  // Get connection details from environment variables
  const config = {
    host: process.env.MYSQLHOST || process.env.RAILWAY_MYSQLHOST || 'mysql.railway.internal',
    port: parseInt(process.env.MYSQLPORT || process.env.RAILWAY_MYSQLPORT || '3306', 10),
    user: process.env.MYSQLUSER || process.env.RAILWAY_MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || process.env.RAILWAY_MYSQLPASSWORD || process.env.RAILWAY_DATABASE_PASSWORD,
    database: process.env.MYSQLDATABASE || process.env.RAILWAY_MYSQLDATABASE || 'railway',
    ssl: (process.env.MYSQL_SSL === 'true' || process.env.RAILWAY_ENVIRONMENT === 'production') 
      ? { rejectUnauthorized: false } 
      : false,
    connectTimeout: 60000,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    debug: process.env.NODE_ENV === 'development',
    timezone: 'Z' // Use UTC timezone
  };

  // Log configuration (without password)
  const { password, ...configWithoutPassword } = config;
  console.log('Database connection config:', {
    ...configWithoutPassword,
    password: password ? '***' : undefined,
    ssl: config.ssl ? 'enabled' : 'disabled'
  });

  return config;
};

// Create connection pool
const pool = mysql.createPool(getDbConfig());

// Test the database connection
const testConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('✅ Successfully connected to the database');
    connection.release();
    return true;
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    console.error('Connection details:', {
      host: pool.config.connectionConfig.host,
      port: pool.config.connectionConfig.port,
      database: pool.config.connectionConfig.database,
      user: pool.config.connectionConfig.user,
      ssl: pool.config.connectionConfig.ssl ? 'enabled' : 'disabled'
    });
    return false;
  }
};

// Test the connection when this module is loaded
testConnection().catch(console.error);

module.exports = pool;
