const express = require('express');
const router = express.Router();
const propertyAmenityController = require('../controllers/propertyAmenityController');

router.get('/', propertyAmenityController.getAllPropertyAmenities);
router.get('/:id', propertyAmenityController.getPropertyAmenityById);
router.post('/', propertyAmenityController.createPropertyAmenity);
router.put('/:id', propertyAmenityController.updatePropertyAmenity);
router.delete('/:id', propertyAmenityController.deletePropertyAmenity);

module.exports = router;
