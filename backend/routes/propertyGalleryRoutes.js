const express = require('express');
const router = express.Router();
const propertyGalleryController = require('../controllers/propertyGalleryController');

router.get('/', propertyGalleryController.getAllPropertyGallery);
router.get('/:id', propertyGalleryController.getPropertyGalleryById);
router.post('/', propertyGalleryController.createPropertyGallery);
router.put('/:id', propertyGalleryController.updatePropertyGallery);
router.delete('/:id', propertyGalleryController.deletePropertyGallery);

module.exports = router;
