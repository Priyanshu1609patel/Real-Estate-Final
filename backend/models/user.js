const db = require('../db');

const User = {
  create: (data, callback) => {
    // Store password as plain text (for demo only)
    db.query('INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)', [data.username, data.email, data.password], callback);
  },
  findByUsernameOrEmail: (identifier, callback) => {
    db.query('SELECT * FROM users WHERE username = ? OR email = ?', [identifier, identifier], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  }
};

module.exports = User;
