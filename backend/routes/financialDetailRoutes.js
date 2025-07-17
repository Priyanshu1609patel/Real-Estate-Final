const express = require('express');
const router = express.Router();
const financialDetailController = require('../controllers/financialDetailController');

router.get('/', financialDetailController.getAllFinancialDetails);
router.get('/:id', financialDetailController.getFinancialDetailById);
router.post('/', financialDetailController.createFinancialDetail);
router.put('/:id', financialDetailController.updateFinancialDetail);
router.delete('/:id', financialDetailController.deleteFinancialDetail);

module.exports = router;
