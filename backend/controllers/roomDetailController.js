const RoomDetail = require('../models/roomDetail');

exports.getAllRoomDetails = (req, res) => {
  RoomDetail.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getRoomDetailById = (req, res) => {
  RoomDetail.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Room detail not found' });
    res.json(results[0]);
  });
};

exports.createRoomDetail = (req, res) => {
  RoomDetail.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateRoomDetail = (req, res) => {
  RoomDetail.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Room detail updated' });
  });
};

exports.deleteRoomDetail = (req, res) => {
  RoomDetail.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Room detail deleted' });
  });
};
