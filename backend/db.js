const mysql = require('mysql2');
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'real-estate-database'
});
db.connect((err) => {
  if (err) throw err;
  console.log('Connected!');
});
module.exports = db; 