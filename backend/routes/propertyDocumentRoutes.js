const express = require('express');
const router = express.Router();
const propertyDocumentController = require('../controllers/propertyDocumentController');

router.get('/', propertyDocumentController.getAllPropertyDocuments);
router.get('/:id', propertyDocumentController.getPropertyDocumentById);
router.post('/', propertyDocumentController.createPropertyDocument);
router.put('/:id', propertyDocumentController.updatePropertyDocument);
router.delete('/:id', propertyDocumentController.deletePropertyDocument);

module.exports = router;
