const pgClient = require('pg').Client;

const pgURI = 'postgresql://postgres:root@localhost:5432/tmaapp_dev'; // eslint-disable-line

const client = new pgClient({
	connectionString: pgURI
});

function pgConnect() {
	client.connect()
		.then(() => console.log('OK.'))
		.catch(e => console.error('KO ---> ' + e));
}

const query = (text, params, cb) => {
	return client.query(text, params, (err, res) => {
		cb(err, res);
	});
};

module.exports = {
	query,
	pgConnect
};
