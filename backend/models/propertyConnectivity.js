const db = require('../server').db;

const PropertyConnectivity = {
  getAll: (callback) => {
    db.query('SELECT * FROM property_connectivity', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM property_connectivity WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO property_connectivity SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE property_connectivity SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM property_connectivity WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyConnectivity;
