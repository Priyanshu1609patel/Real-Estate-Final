const db = require('../server').db;

const UnitType = {
  getAll: (callback) => {
    db.query('SELECT * FROM unit_types', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM unit_types WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO unit_types SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE unit_types SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM unit_types WHERE id = ?', [id], callback);
  }
};

module.exports = UnitType;
