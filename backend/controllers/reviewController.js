const Review = require('../models/review');

exports.getAllReviews = (req, res) => {
  Review.getAll((err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

exports.getReviewById = (req, res) => {
  Review.getById(req.params.id, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (results.length === 0) return res.status(404).json({ error: 'Review not found' });
    res.json(results[0]);
  });
};

exports.createReview = (req, res) => {
  Review.create(req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ id: result.insertId, ...req.body });
  });
};

exports.updateReview = (req, res) => {
  Review.update(req.params.id, req.body, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Review updated' });
  });
};

exports.deleteReview = (req, res) => {
  Review.delete(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Review deleted' });
  });
};
