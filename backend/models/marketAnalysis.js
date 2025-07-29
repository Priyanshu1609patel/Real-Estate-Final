const db = require('../server').db;

const MarketAnalysis = {
  getAll: (callback) => {
    db.query('SELECT * FROM market_analysis', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM market_analysis WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO market_analysis SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE market_analysis SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM market_analysis WHERE id = ?', [id], callback);
  }
};

module.exports = MarketAnalysis;
