const db = require('../server').db;

const InvestmentAnalysis = {
  getAll: (callback) => {
    db.query('SELECT * FROM investment_analysis', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM investment_analysis WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO investment_analysis SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE investment_analysis SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM investment_analysis WHERE id = ?', [id], callback);
  }
};

module.exports = InvestmentAnalysis;
