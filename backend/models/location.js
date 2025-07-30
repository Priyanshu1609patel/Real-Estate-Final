const { pool } = require('../db');

const Location = {
  getAll: (callback) => {
    pool.query('SELECT * FROM locations', callback);
  },
  getById: (id, callback) => {
    pool.query('SELECT * FROM locations WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    pool.query('INSERT INTO locations SET ?', data, callback);
  },
  update: (id, data, callback) => {
    pool.query('UPDATE locations SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    pool.query('DELETE FROM locations WHERE id = ?', [id], callback);
  }
};

module.exports = Location;
