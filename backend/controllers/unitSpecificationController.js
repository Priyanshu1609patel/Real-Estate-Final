const UnitSpecification = require('../models/unitSpecification');

exports.getAllUnitSpecifications = (req, res) => {
  UnitSpecification.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getUnitSpecificationById = (req, res) => {
  UnitSpecification.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Unit specification not found' });
    res.json(results[0]);
  });
};

exports.createUnitSpecification = (req, res) => {
  UnitSpecification.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateUnitSpecification = (req, res) => {
  UnitSpecification.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Unit specification updated' });
  });
};

exports.deleteUnitSpecification = (req, res) => {
  UnitSpecification.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Unit specification deleted' });
  });
};
