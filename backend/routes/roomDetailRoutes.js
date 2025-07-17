const express = require('express');
const router = express.Router();
const roomDetailController = require('../controllers/roomDetailController');

router.get('/', roomDetailController.getAllRoomDetails);
router.get('/:id', roomDetailController.getRoomDetailById);
router.post('/', roomDetailController.createRoomDetail);
router.put('/:id', roomDetailController.updateRoomDetail);
router.delete('/:id', roomDetailController.deleteRoomDetail);

module.exports = router;
