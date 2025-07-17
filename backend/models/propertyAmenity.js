const db = require('../server').db;

const PropertyAmenity = {
  getAll: (callback) => {
    db.query('SELECT * FROM property_amenities', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM property_amenities WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO property_amenities SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE property_amenities SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM property_amenities WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyAmenity;
