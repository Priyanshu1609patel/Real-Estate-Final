const express = require('express');
const router = express.Router();
const marketAnalysisController = require('../controllers/marketAnalysisController');

router.get('/', marketAnalysisController.getAllMarketAnalysis);
router.get('/:id', marketAnalysisController.getMarketAnalysisById);
router.post('/', marketAnalysisController.createMarketAnalysis);
router.put('/:id', marketAnalysisController.updateMarketAnalysis);
router.delete('/:id', marketAnalysisController.deleteMarketAnalysis);

module.exports = router;
