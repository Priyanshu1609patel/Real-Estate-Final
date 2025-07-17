const db = require('../server').db;

const PropertyGallery = {
  getAll: (callback) => {
    db.query('SELECT * FROM property_gallery', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM property_gallery WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO property_gallery SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE property_gallery SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM property_gallery WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyGallery;
