const InvestmentAnalysis = require('../models/investmentAnalysis');

exports.getAllInvestmentAnalysis = (req, res) => {
  InvestmentAnalysis.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getInvestmentAnalysisById = (req, res) => {
  InvestmentAnalysis.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Investment analysis not found' });
    res.json(results[0]);
  });
};

exports.createInvestmentAnalysis = (req, res) => {
  InvestmentAnalysis.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateInvestmentAnalysis = (req, res) => {
  InvestmentAnalysis.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Investment analysis updated' });
  });
};

exports.deleteInvestmentAnalysis = (req, res) => {
  InvestmentAnalysis.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Investment analysis deleted' });
  });
};
