const MarketAnalysis = require('../models/marketAnalysis');

exports.getAllMarketAnalysis = (req, res) => {
  MarketAnalysis.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getMarketAnalysisById = (req, res) => {
  MarketAnalysis.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Market analysis not found' });
    res.json(results[0]);
  });
};

exports.createMarketAnalysis = (req, res) => {
  MarketAnalysis.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateMarketAnalysis = (req, res) => {
  MarketAnalysis.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Market analysis updated' });
  });
};

exports.deleteMarketAnalysis = (req, res) => {
  MarketAnalysis.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Market analysis deleted' });
  });
};
