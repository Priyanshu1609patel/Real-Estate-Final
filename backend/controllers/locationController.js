const Location = require('../models/location');

exports.getAllLocations = (req, res) => {
  Location.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getLocationById = (req, res) => {
  Location.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Location not found' });
    res.json(results[0]);
  });
};

exports.createLocation = (req, res) => {
  Location.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateLocation = (req, res) => {
  Location.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Location updated' });
  });
};

exports.deleteLocation = (req, res) => {
  Location.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Location deleted' });
  });
};
