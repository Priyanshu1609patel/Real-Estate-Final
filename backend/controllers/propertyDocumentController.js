const PropertyDocument = require('../models/propertyDocument');

exports.getAllPropertyDocuments = (req, res) => {
  PropertyDocument.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyDocumentById = (req, res) => {
  PropertyDocument.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property document not found' });
    res.json(results[0]);
  });
};

exports.createPropertyDocument = (req, res) => {
  PropertyDocument.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updatePropertyDocument = (req, res) => {
  PropertyDocument.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property document updated' });
  });
};

exports.deletePropertyDocument = (req, res) => {
  PropertyDocument.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property document deleted' });
  });
};
