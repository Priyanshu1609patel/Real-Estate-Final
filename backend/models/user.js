const db = require('../db');
const bcrypt = require('bcryptjs');

const User = {
  create: async (data, callback) => {
    try {
      const hash = await bcrypt.hash(data.password, 10);
      db.query('INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)', [data.username, data.email, hash], callback);
    } catch (err) {
      callback(err);
    }
  },
  findByUsernameOrEmail: (identifier, callback) => {
    db.query('SELECT * FROM users WHERE username = ? OR email = ?', [identifier, identifier], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  }
};

module.exports = User; 