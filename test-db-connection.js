const mysql = require('mysql2/promise');

async function testConnection() {
  // Try to use MYSQL_URL first, then fall back to direct config
  const config = process.env.MYSQL_URL 
    ? {
        uri: process.env.MYSQL_URL,
        ssl: { rejectUnauthorized: false },
        connectTimeout: 10000
      }
    : {
        host: process.env.MYSQLHOST || 'containers-us-west-123.railway.app',
        port: 3306, // Using default MySQL port 3306
        user: process.env.MYSQLUSER || 'root',
        password: process.env.MYSQLPASSWORD || 'QvxdQQFIHjrBwnolUOpgVCVRHoxCkwbb',
        database: process.env.MYSQLDATABASE || 'railway',
        ssl: false, // Try without SSL first
        connectTimeout: 30000, // Increased timeout to 30 seconds
      };

  // Log the connection details we're using
  console.log('Environment:');
  console.log('- NODE_ENV:', process.env.NODE_ENV || 'not set');
  console.log('- RAILWAY_ENVIRONMENT:', process.env.RAILWAY_ENVIRONMENT || 'not set');
  console.log('\nAttempting to connect with config:', {
    ...config,
    password: config.password ? '***' : 'not set',
    ssl: config.ssl ? 'enabled' : 'disabled'
  });

  try {
    console.log('\nStep 1: Creating connection...');
    const connection = await mysql.createConnection(config);
    console.log('✅ Successfully connected to MySQL database');
    
    try {
      console.log('\nStep 2: Testing query...');
      const [rows] = await connection.execute('SELECT 1 as test');
      console.log('✅ Test query result:', rows);
      
      console.log('\nStep 3: Checking database version...');
      const [version] = await connection.execute('SELECT VERSION() as version');
      console.log('✅ Database version:', version[0].version);
      
      return true;
    } finally {
      console.log('\nClosing connection...');
      await connection.end();
    }
  } catch (error) {
    console.error('\n❌ Database connection failed:', error.code || error.message);
    console.error('Error details:', {
      code: error.code,
      errno: error.errno,
      sqlState: error.sqlState,
      sqlMessage: error.sqlMessage
    });
    
    // Additional debug information
    if (error.code === 'ETIMEDOUT') {
      console.error('\n🔍 Troubleshooting:');
      console.error('- Check if the hostname and port are correct');
      console.error('- Verify the database is running and accessible');
      console.error('- Check if a VPN or firewall is blocking the connection');
      console.error('- Try pinging the host to check network connectivity');
    }
    
    return false;
  }
}

testConnection().then(success => {
  process.exit(success ? 0 : 1);
});
