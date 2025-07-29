const db = require('../db');

// Property Model
const Property = {
  getAll: (callback) => {
    db.query('SELECT * FROM properties', (err, result) => {
      if (err) return callback(err);
      callback(null, result.rows);
    });
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM properties WHERE id = $1', [id], (err, result) => {
      if (err) return callback(err);
      callback(null, result.rows);
    });
  },
  create: (data, callback) => {
    const keys = Object.keys(data);
    const values = Object.values(data);
    const columns = keys.map((k) => k).join(', ');
    const placeholders = keys.map((_, i) => `$${i + 1}`).join(', ');
    const query = `INSERT INTO properties (${columns}) VALUES (${placeholders}) RETURNING *`;
    db.query(query, values, (err, result) => {
      if (err) return callback(err);
      callback(null, result.rows[0]);
    });
  },
  update: (id, data, callback) => {
    const keys = Object.keys(data);
    const values = Object.values(data);
    const setString = keys.map((k, i) => `${k} = $${i + 1}`).join(', ');
    const query = `UPDATE properties SET ${setString} WHERE id = $${keys.length + 1} RETURNING *`;
    db.query(query, [...values, id], (err, result) => {
      if (err) return callback(err);
      callback(null, result.rows[0]);
    });
  },
  delete: (id, callback) => {
    db.query('DELETE FROM properties WHERE id = $1 RETURNING *', [id], (err, result) => {
      if (err) return callback(err);
      callback(null, result.rows[0]);
    });
  }
};

module.exports = Property; 