const express = require('express');
const router = express.Router();
const legalDetailController = require('../controllers/legalDetailController');

router.get('/', legalDetailController.getAllLegalDetails);
router.get('/:id', legalDetailController.getLegalDetailById);
router.post('/', legalDetailController.createLegalDetail);
router.put('/:id', legalDetailController.updateLegalDetail);
router.delete('/:id', legalDetailController.deleteLegalDetail);

module.exports = router;
