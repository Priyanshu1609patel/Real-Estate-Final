const db = require('../server').db;

// Property Model
const Property = {
  getAll: (callback) => {
    db.query('SELECT * FROM properties', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM properties WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO properties SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE properties SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM properties WHERE id = ?', [id], callback);
  }
};

module.exports = Property; 