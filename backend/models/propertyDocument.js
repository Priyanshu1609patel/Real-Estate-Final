const db = require('../server').db;

const PropertyDocument = {
  getAll: (callback) => {
    db.query('SELECT * FROM property_documents', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM property_documents WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO property_documents SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE property_documents SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM property_documents WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyDocument;
