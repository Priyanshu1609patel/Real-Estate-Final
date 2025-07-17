const UnitType = require('../models/unitType');

exports.getAllUnitTypes = (req, res) => {
  UnitType.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getUnitTypeById = (req, res) => {
  UnitType.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Unit type not found' });
    res.json(results[0]);
  });
};

exports.createUnitType = (req, res) => {
  UnitType.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateUnitType = (req, res) => {
  UnitType.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Unit type updated' });
  });
};

exports.deleteUnitType = (req, res) => {
  UnitType.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Unit type deleted' });
  });
};
