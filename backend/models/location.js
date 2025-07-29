const db = require('../server').db;

const Location = {
  getAll: (callback) => {
    db.query('SELECT * FROM locations', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM locations WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO locations SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE locations SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM locations WHERE id = ?', [id], callback);
  }
};

module.exports = Location;
