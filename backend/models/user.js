const db = require('../db-railway');  // ✅ now points to db-railway.js

const User = {
  create: async (data, callback) => {
    try {
      // 🚨 Password is plain text (for demo only)
      const [result] = await db.query(
        'INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)',
        [data.username, data.email, data.password]
      );
      callback(null, result);
    } catch (err) {
      callback(err);
    }
  },

  findByUsernameOrEmail: async (identifier, callback) => {
    try {
      const [results] = await db.query(
        'SELECT * FROM users WHERE username = ? OR email = ?',
        [identifier, identifier]
      );
      callback(null, results[0]);
    } catch (err) {
      callback(err);
    }
  }
};

module.exports = User;
