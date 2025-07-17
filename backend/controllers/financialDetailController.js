const FinancialDetail = require('../models/financialDetail');

exports.getAllFinancialDetails = (req, res) => {
  FinancialDetail.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getFinancialDetailById = (req, res) => {
  FinancialDetail.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Financial detail not found' });
    res.json(results[0]);
  });
};

exports.createFinancialDetail = (req, res) => {
  FinancialDetail.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateFinancialDetail = (req, res) => {
  FinancialDetail.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Financial detail updated' });
  });
};

exports.deleteFinancialDetail = (req, res) => {
  FinancialDetail.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Financial detail deleted' });
  });
};
