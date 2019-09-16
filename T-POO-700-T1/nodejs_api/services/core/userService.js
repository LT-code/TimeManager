const db = require('../../db/config');
const util = require('util');

/*
function getAllUsers() {
	console.log('Searching for all users.');

	return new Promise((resolve, reject) => {
		let findUserSql = 'SELECT * FROM users';

		const findUserQuery = {
			text: findUserSql,
			values: []
		};
		db.query(findUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				console.log(result.rows);
				resolve({ status: 'OK', foundUser: result.rows });
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}
*/

function getUserByEmailAndUsername(email, username) {
	console.log('Searching for user named [ ' + username + ' ]  [ ' + email + ' ].');

	return new Promise((resolve, reject) => {
		let findUserSql = 'SELECT * FROM users WHERE email LIKE LOWER($1) ' +
			'AND username LIKE LOWER($2)';

		const findUserQuery = {
			text: findUserSql,
			values: [ email, username ]
		};
		db.query(findUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				if (result.rows.length === 0) {
					resolve({ status: 'OK', foundUser: 'No users found named [ ' + username + ' ]  [ ' + email + ' ].' });
				} else {
					resolve({ status: 'OK', foundUser: result.rows });
				}
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}

function getUserById(userId) {
	console.log('Searching for user with id [ ' + userId + ' ].');

	return new Promise((resolve, reject) => {
		let findUserSql = 'SELECT * FROM users WHERE id = $1';

		const findUserQuery = {
			text: findUserSql,
			values: [ userId ]
		};
		db.query(findUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				if (result.rows.length === 0) {
					console.log('No users found with the id [ ' + userId + ' ].');
					resolve({ status: 'OK', foundUser: 'No users found with the id [ ' + userId + ' ].' });
				} else {
					console.log(result.rows);
					resolve({ status: 'OK', foundUser: result.rows });
				}
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}

function createUser(email, username) {
	console.log('Creating user named [ ' + username + ' ]  [ ' + email + ' ].');

	return new Promise((resolve, reject) => {
		let createUserSql = 'INSERT INTO users (email, username, inserted_at, updated_at) VALUES ($1, $2, $3, $3) RETURNING *';

		const createUserQuery = {
			text: createUserSql,
			values: [ email.toLowerCase(), username.toLowerCase(), new Date() ]
		};
		db.query(createUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				resolve({ status: 'OK', createdUser: result.rows });
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}

function updateUser(userId, email, username) {
	console.log('Updating user with id [ ' + userId + ' ] to [ ' + username + ' ]  [ ' + email + ' ].');

	return new Promise(async (resolve, reject) => {
		let toUpdateUser = await this.getUserById(userId);

		if (toUpdateUser.foundUser.length === 0) {
			reject({ status: 'KO', error: 'No user found with the id [ ' + userId + ' ].' });
		}

		let updateUserSql = 'UPDATE users SET email = $1, username = $2, updated_at = $3';

		const updateUserQuery = {
			text: updateUserSql,
			values: [ email.toLowerCase(), username.toLowerCase(), new Date() ]
		};
		db.query(updateUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				resolve({ status: 'OK', updatedUser: result.rows });
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}

function deleteUser(userId) {
	console.log('Deleting user with id [ ' + userId + ' ].');

	return new Promise(async (resolve, reject) => {
		let toDeleteUser = await this.getUserById(userId);

		console.log('--> ' + toDeleteUser.foundUser.length);
		console.log('--> ' + util.inspect(toDeleteUser.foundUser));

		if (toDeleteUser.foundUser.length === 0 || toDeleteUser.foundUser.startsWith('No users found')) {
			reject({ status: 'KO', error: 'No users found with the id [ ' + userId + ' ].' });
		}

		let deleteUserSql = 'DELETE FROM users WHERE id = $1';

		const deleteUserQuery = {
			text: deleteUserSql,
			values: [ userId ]
		};
		db.query(deleteUserQuery, '', (err, result) => {
			if (err) {
				console.error(err.stack);
				reject({ status: 'KO', error: err });
			} else {
				resolve({ status: 'OK', deletedUser: result.rows });
			}
		});
	}).catch(rejected => {
		return rejected;
	});
}

module.exports = {
	createUser,
	updateUser,
	deleteUser,
	getUserById,
	getUserByEmailAndUsername
};
