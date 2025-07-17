const express = require('express');
const router = express.Router();
const developerController = require('../controllers/developerController');

router.get('/', developerController.getAllDevelopers);
router.get('/:id', developerController.getDeveloperById);
router.post('/', developerController.createDeveloper);
router.put('/:id', developerController.updateDeveloper);
router.delete('/:id', developerController.deleteDeveloper);

module.exports = router;
