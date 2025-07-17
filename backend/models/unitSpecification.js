const db = require('../server').db;

const UnitSpecification = {
  getAll: (callback) => {
    db.query('SELECT * FROM unit_specifications', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM unit_specifications WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO unit_specifications SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE unit_specifications SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM unit_specifications WHERE id = ?', [id], callback);
  }
};

module.exports = UnitSpecification;
