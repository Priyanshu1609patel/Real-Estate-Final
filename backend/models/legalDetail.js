const db = require('../server').db;

const LegalDetail = {
  getAll: (callback) => {
    db.query('SELECT * FROM legal_details', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM legal_details WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO legal_details SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE legal_details SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM legal_details WHERE id = ?', [id], callback);
  }
};

module.exports = LegalDetail;
