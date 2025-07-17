const PropertyAmenity = require('../models/propertyAmenity');

exports.getAllPropertyAmenities = (req, res) => {
  PropertyAmenity.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyAmenityById = (req, res) => {
  PropertyAmenity.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property amenity not found' });
    res.json(results[0]);
  });
};

exports.createPropertyAmenity = (req, res) => {
  PropertyAmenity.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updatePropertyAmenity = (req, res) => {
  PropertyAmenity.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property amenity updated' });
  });
};

exports.deletePropertyAmenity = (req, res) => {
  PropertyAmenity.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property amenity deleted' });
  });
};
