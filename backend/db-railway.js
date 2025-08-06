const mysql = require('mysql2/promise');

const db = mysql.createPool({
  host: process.env.MYSQLHOST,
  port: process.env.MYSQLPORT,
  user: process.env.MYSQLUSER,
  password: process.env.MYSQLPASSWORD,
  database: process.env.MYSQLDATABASE,
  ssl: { rejectUnauthorized: false } // allow Railway self-signed SSL
});

(async () => {
  try {
    const conn = await db.getConnection();
    console.log(`✅ Connected to MySQL Database: ${process.env.MYSQLDATABASE}`);
    conn.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
    console.error('Connection details:', {
      host: process.env.MYSQLHOST,
      port: process.env.MYSQLPORT,
      user: process.env.MYSQLUSER,
      database: process.env.MYSQLDATABASE,
      ssl: 'enabled',
    });
  }
})();

module.exports = db;
