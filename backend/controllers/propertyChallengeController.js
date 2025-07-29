const PropertyChallenge = require('../models/propertyChallenge');

exports.getAllPropertyChallenges = (req, res) => {
  PropertyChallenge.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getPropertyChallengeById = (req, res) => {
  PropertyChallenge.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Property challenge not found' });
    res.json(results[0]);
  });
};

exports.createPropertyChallenge = (req, res) => {
  PropertyChallenge.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updatePropertyChallenge = (req, res) => {
  PropertyChallenge.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property challenge updated' });
  });
};

exports.deletePropertyChallenge = (req, res) => {
  PropertyChallenge.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Property challenge deleted' });
  });
};
