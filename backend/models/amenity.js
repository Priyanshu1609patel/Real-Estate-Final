const { pool } = require('../db');

const Amenity = {
  getAll: (callback) => {
    pool.query('SELECT * FROM amenities', callback);
  },
  getById: (id, callback) => {
    pool.query('SELECT * FROM amenities WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    pool.query('INSERT INTO amenities SET ?', data, callback);
  },
  update: (id, data, callback) => {
    pool.query('UPDATE amenities SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    pool.query('DELETE FROM amenities WHERE id = ?', [id], callback);
  }
};

module.exports = Amenity;
