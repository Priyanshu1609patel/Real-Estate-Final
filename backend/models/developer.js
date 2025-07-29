const db = require('../server').db;

const Developer = {
  getAll: (callback) => {
    db.query('SELECT * FROM developers', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM developers WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO developers SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE developers SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM developers WHERE id = ?', [id], callback);
  }
};

module.exports = Developer;
