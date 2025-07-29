const db = require('../db');
const bcrypt = require('bcryptjs');

const User = {
  create: async (data, callback) => {
    try {
      const hash = await bcrypt.hash(data.password, 10);
      db.query(
        'INSERT INTO users (username, email, password_hash) VALUES ($1, $2, $3)',
        [data.username, data.email, hash],
        (err, result) => {
          if (err) return callback(err);
          callback(null, result);
        }
      );
    } catch (err) {
      callback(err);
    }
  },
  findByUsernameOrEmail: (identifier, callback) => {
    db.query(
      'SELECT * FROM users WHERE username = $1 OR email = $1',
      [identifier],
      (err, result) => {
        if (err) return callback(err);
        callback(null, result.rows[0]);
      }
    );
  }
};

module.exports = User; 