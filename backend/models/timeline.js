const db = require('../server').db;

const Timeline = {
  getAll: (callback) => {
    db.query('SELECT * FROM timeline', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM timeline WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO timeline SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE timeline SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM timeline WHERE id = ?', [id], callback);
  }
};

module.exports = Timeline;
