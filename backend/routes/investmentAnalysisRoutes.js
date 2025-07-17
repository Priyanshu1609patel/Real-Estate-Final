const express = require('express');
const router = express.Router();
const investmentAnalysisController = require('../controllers/investmentAnalysisController');

router.get('/', investmentAnalysisController.getAllInvestmentAnalysis);
router.get('/:id', investmentAnalysisController.getInvestmentAnalysisById);
router.post('/', investmentAnalysisController.createInvestmentAnalysis);
router.put('/:id', investmentAnalysisController.updateInvestmentAnalysis);
router.delete('/:id', investmentAnalysisController.deleteInvestmentAnalysis);

module.exports = router;
