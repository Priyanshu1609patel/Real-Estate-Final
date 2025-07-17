const Amenity = require('../models/amenity');

exports.getAllAmenities = (req, res) => {
  Amenity.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getAmenityById = (req, res) => {
  Amenity.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Amenity not found' });
    res.json(results[0]);
  });
};

exports.createAmenity = (req, res) => {
  Amenity.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateAmenity = (req, res) => {
  Amenity.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Amenity updated' });
  });
};

exports.deleteAmenity = (req, res) => {
  Amenity.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Amenity deleted' });
  });
};
