const { pool } = require('../db');

const Developer = {
  getAll: (callback) => {
    pool.query('SELECT * FROM developers', callback);
  },
  getById: (id, callback) => {
    pool.query('SELECT * FROM developers WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    pool.query('INSERT INTO developers SET ?', data, callback);
  },
  update: (id, data, callback) => {
    pool.query('UPDATE developers SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    pool.query('DELETE FROM developers WHERE id = ?', [id], callback);
  }
};

module.exports = Developer;
