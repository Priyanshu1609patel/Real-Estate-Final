const express = require('express');
const router = express.Router();
const unitSpecificationController = require('../controllers/unitSpecificationController');

router.get('/', unitSpecificationController.getAllUnitSpecifications);
router.get('/:id', unitSpecificationController.getUnitSpecificationById);
router.post('/', unitSpecificationController.createUnitSpecification);
router.put('/:id', unitSpecificationController.updateUnitSpecification);
router.delete('/:id', unitSpecificationController.deleteUnitSpecification);

module.exports = router;
