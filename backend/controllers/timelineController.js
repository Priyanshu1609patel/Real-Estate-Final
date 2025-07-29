const Timeline = require('../models/timeline');

exports.getAllTimeline = (req, res) => {
  Timeline.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getTimelineById = (req, res) => {
  Timeline.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Timeline not found' });
    res.json(results[0]);
  });
};

exports.createTimeline = (req, res) => {
  Timeline.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateTimeline = (req, res) => {
  Timeline.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Timeline updated' });
  });
};

exports.deleteTimeline = (req, res) => {
  Timeline.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Timeline deleted' });
  });
};
