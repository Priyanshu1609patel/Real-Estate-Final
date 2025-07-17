const db = require('../server').db;

const PropertyChallenge = {
  getAll: (callback) => {
    db.query('SELECT * FROM property_challenges', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM property_challenges WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO property_challenges SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE property_challenges SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM property_challenges WHERE id = ?', [id], callback);
  }
};

module.exports = PropertyChallenge;
