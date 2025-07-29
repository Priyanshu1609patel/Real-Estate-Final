const PropertyConnectivity = require('../models/propertyConnectivity');

exports.getAllPropertyConnectivity = (req, res) => {
  PropertyConnectivity.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyConnectivityById = (req, res) => {
  PropertyConnectivity.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property connectivity not found' });
    res.json(results[0]);
  });
};

exports.createPropertyConnectivity = (req, res) => {
  PropertyConnectivity.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updatePropertyConnectivity = (req, res) => {
  PropertyConnectivity.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property connectivity updated' });
  });
};

exports.deletePropertyConnectivity = (req, res) => {
  PropertyConnectivity.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property connectivity deleted' });
  });
};
