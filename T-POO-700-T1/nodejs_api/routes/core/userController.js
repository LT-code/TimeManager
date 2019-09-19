const userService = require('../../services/core/userService');
// const util = require('util');

/*
async function getAllUsers(req, res) {
	let user = await userService.getAllUsers();
	console.log('USERS: ' + user);
	res.json({ status: 'OK', user: user.foundUser });
}
*/

async function getUserByEmailAndUsername(req, res) {
	let user = await userService.getUserByEmailAndUsername(req.query.email, req.query.username);
	if (user.status === 'KO') {
		res.status(500).json({ status: 'KO', error: user.error }).end();
	} else {
		res.status(200).json({ status: 'OK', user: user.foundUser });
	}
}

async function getUserById(req, res) {
	let user = await userService.getUserById(req.params.userId);
	if (user.status === 'KO') {
		res.status(500).json({ status: 'KO', error: user.error }).end();
	} else {
		res.status(200).json({ status: 'OK', user: user.foundUser });
	}
}

async function createUser(req, res) {
	let user = await userService.createUser(req.body.user.email, req.body.user.username);
	if (user.status === 'KO') {
		res.status(500).json({ status: 'KO', error: user.error }).end();
	} else {
		res.status(201).json({ status: 'OK', users: user.createdUser });
	}
}

async function updateUser(req, res) {
	let user = await userService.updateUser(req.params.userId, req.body.user.email, req.body.user.username);
	if (user.status === 'KO') {
		res.status(500).json({ status: 'KO', error: user.error }).end();
	} else {
		res.status(200).json({ status: 'OK', user: user.updatedUser });
	}
}

async function deleteUser(req, res) {
	let user = await userService.deleteUser(req.params.userId);
	if (user.status === 'KO') {
		res.status(500).json({ status: 'KO', error: user.error }).end();

	} else {
		res.status(200).json({ status: 'OK', user: user.deletedUser });
	}
}

module.exports = {
	createUser,
	updateUser,
	deleteUser,
	getUserById,
	getUserByEmailAndUsername
};
