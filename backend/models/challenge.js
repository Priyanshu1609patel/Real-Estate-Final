const db = require('../server').db;

const Challenge = {
  getAll: (callback) => {
    db.query('SELECT * FROM challenges', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM challenges WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO challenges SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE challenges SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM challenges WHERE id = ?', [id], callback);
  }
};

module.exports = Challenge;
