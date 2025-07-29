const db = require('../server').db;

const FinancialDetail = {
  getAll: (callback) => {
    db.query('SELECT * FROM financial_details', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM financial_details WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO financial_details SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE financial_details SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM financial_details WHERE id = ?', [id], callback);
  }
};

module.exports = FinancialDetail;
