const db = require('../server').db;

const RoomDetail = {
  getAll: (callback) => {
    db.query('SELECT * FROM room_details', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT * FROM room_details WHERE id = ?', [id], callback);
  },
  create: (data, callback) => {
    db.query('INSERT INTO room_details SET ?', data, callback);
  },
  update: (id, data, callback) => {
    db.query('UPDATE room_details SET ? WHERE id = ?', [data, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM room_details WHERE id = ?', [id], callback);
  }
};

module.exports = RoomDetail;
