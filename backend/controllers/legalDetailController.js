const LegalDetail = require('../models/legalDetail');

exports.getAllLegalDetails = (req, res) => {
  LegalDetail.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getLegalDetailById = (req, res) => {
  LegalDetail.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Legal detail not found' });
    res.json(results[0]);
  });
};

exports.createLegalDetail = (req, res) => {
  LegalDetail.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateLegalDetail = (req, res) => {
  LegalDetail.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Legal detail updated' });
  });
};

exports.deleteLegalDetail = (req, res) => {
  LegalDetail.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Legal detail deleted' });
  });
};
