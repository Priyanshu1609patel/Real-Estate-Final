const Challenge = require('../models/challenge');

exports.getAllChallenges = (req, res) => {
  Challenge.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getChallengeById = (req, res) => {
  Challenge.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Challenge not found' });
    res.json(results[0]);
  });
};

exports.createChallenge = (req, res) => {
  Challenge.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateChallenge = (req, res) => {
  Challenge.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Challenge updated' });
  });
};

exports.deleteChallenge = (req, res) => {
  Challenge.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Challenge deleted' });
  });
};
