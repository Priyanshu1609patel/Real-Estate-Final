const db = require('../server').db;

const Review = {
  getAll: (callback) => {
    db.query('SELECT * FROM reviews', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM reviews WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO reviews SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE reviews SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM reviews WHERE id = ?', [id], callback);
  }
};

module.exports = Review;
