const express = require('express');
const router = express.Router();
const propertyChallengeController = require('../controllers/propertyChallengeController');

router.get('/', propertyChallengeController.getAllPropertyChallenges);
router.get('/:id', propertyChallengeController.getPropertyChallengeById);
router.post('/', propertyChallengeController.createPropertyChallenge);
router.put('/:id', propertyChallengeController.updatePropertyChallenge);
router.delete('/:id', propertyChallengeController.deletePropertyChallenge);

module.exports = router;
