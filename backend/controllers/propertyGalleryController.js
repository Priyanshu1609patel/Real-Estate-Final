const PropertyGallery = require('../models/propertyGallery');

exports.getAllPropertyGallery = (req, res) => {
  PropertyGallery.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyGalleryById = (req, res) => {
  PropertyGallery.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property gallery not found' });
    res.json(results[0]);
  });
};

exports.createPropertyGallery = (req, res) => {
  PropertyGallery.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updatePropertyGallery = (req, res) => {
  PropertyGallery.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property gallery updated' });
  });
};

exports.deletePropertyGallery = (req, res) => {
  PropertyGallery.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property gallery deleted' });
  });
};
