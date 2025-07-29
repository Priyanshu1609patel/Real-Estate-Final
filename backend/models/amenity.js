const db = require('../server').db;

const Amenity = {
  getAll: (callback) => {
    db.query('SELECT * FROM amenities', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM amenities WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO amenities SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE amenities SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM amenities WHERE id = ?', [id], callback);
  }
};

module.exports = Amenity;
