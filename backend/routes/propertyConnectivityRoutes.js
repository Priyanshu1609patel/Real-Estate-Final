const express = require('express');
const router = express.Router();
const propertyConnectivityController = require('../controllers/propertyConnectivityController');

router.get('/', propertyConnectivityController.getAllPropertyConnectivity);
router.get('/:id', propertyConnectivityController.getPropertyConnectivityById);
router.post('/', propertyConnectivityController.createPropertyConnectivity);
router.put('/:id', propertyConnectivityController.updatePropertyConnectivity);
router.delete('/:id', propertyConnectivityController.deletePropertyConnectivity);

module.exports = router;
