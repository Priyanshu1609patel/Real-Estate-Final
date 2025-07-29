const mysql = require('mysql2');

const db = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'root',
  database: process.env.DB_NAME || 'real-estate-database'
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err);
    throw err;
  }
  console.log('✅ Connected to MySQL Database:', process.env.DB_NAME || 'real-estate-database');
});

module.exports = db;
