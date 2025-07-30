const { pool } = require('../db');

const PropertyAmenity = {
  getAll: (callback) => {
    pool.query('SELECT * FROM property_amenities', callback);
  },
  getById: (id, callback) => {
    pool.query('SELECT * FROM property_amenities WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    pool.query('INSERT INTO property_amenities SET ?', data, callback);
  },
  update: (id, data, callback) => {
    pool.query('UPDATE property_amenities SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    pool.query('DELETE FROM property_amenities WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyAmenity;
