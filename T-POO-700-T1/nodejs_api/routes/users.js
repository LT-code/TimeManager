const express = require('express');
const router = express.Router();
const userController = require('./core/userController');

router
    .route('/users')
    // .get(userController.getAllUsers)
    .get(userController.getUserByEmailAndUsername)
    .post(userController.createUser);

router
    .route('/users/:userId')
    .get(userController.getUserById)
    .put(userController.updateUser)
    .delete(userController.deleteUser);

module.exports = router;
