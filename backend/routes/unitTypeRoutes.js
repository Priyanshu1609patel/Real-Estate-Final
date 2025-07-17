const express = require('express');
const router = express.Router();
const unitTypeController = require('../controllers/unitTypeController');

router.get('/', unitTypeController.getAllUnitTypes);
router.get('/:id', unitTypeController.getUnitTypeById);
router.post('/', unitTypeController.createUnitType);
router.put('/:id', unitTypeController.updateUnitType);
router.delete('/:id', unitTypeController.deleteUnitType);

module.exports = router;
