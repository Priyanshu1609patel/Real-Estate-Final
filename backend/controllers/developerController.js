const Developer = require('../models/developer');

exports.getAllDevelopers = (req, res) => {
  Developer.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getDeveloperById = (req, res) => {
  Developer.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Developer not found' });
    res.json(results[0]);
  });
};

exports.createDeveloper = (req, res) => {
  Developer.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateDeveloper = (req, res) => {
  Developer.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Developer updated' });
  });
};

exports.deleteDeveloper = (req, res) => {
  Developer.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Developer deleted' });
  });
};
