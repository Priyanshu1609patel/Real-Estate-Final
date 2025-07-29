const Property = require('../models/property');

exports.getAllProperties = (req, res) => {
  Property.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyById = (req, res) => {
  Property.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property not found' });
    res.json(results[0]);
  });
};

exports.createProperty = (req, res) => {
  Property.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateProperty = (req, res) => {
  Property.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property updated' });
  });
};

exports.deleteProperty = (req, res) => {
  Property.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property deleted' });
  });
}; 