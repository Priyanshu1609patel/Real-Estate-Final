require('dotenv').config();
const mysql = require('mysql2/promise');

async function testConnection() {
  const dbConfig = {
    host: 'containers-us-west-123.railway.app', // Directly using the provided host
    port: 3306,
    user: 'root',
    password: 'root',
    database: 'real-estate-database',
    ssl: { rejectUnauthorized: false } // Enable SSL for Railway
  };
  
  console.log('🔧 Using database configuration:', {
    ...dbConfig,
    password: '***' // Don't log the actual password
  });
  
  const connection = await mysql.createConnection(dbConfig);

  try {
    console.log('🚀 Attempting to connect to the database...');
    await connection.connect();
    console.log('✅ Successfully connected to the database!');
    
    // Test query
    const [rows] = await connection.execute('SELECT DATABASE() as db, VERSION() as version, USER() as user');
    console.log('\n📊 Database Information:');
    console.log(`- Database: ${rows[0].db}`);
    console.log(`- MySQL Version: ${rows[0].version}`);
    console.log(`- Connected as: ${rows[0].user}`);
    
    // List tables
    const [tables] = await connection.execute('SHOW TABLES');
    console.log('\n📋 Available Tables:');
    tables.forEach((table, i) => {
      const tableName = Object.values(table)[0];
      console.log(`  ${i + 1}. ${tableName}`);
    });
    
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    console.error('Error code:', error.code);
    console.error('Error SQL state:', error.sqlState);
  } finally {
    if (connection) await connection.end();
    console.log('\n🔌 Connection closed.');
  }
}

testConnection();
