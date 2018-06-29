import PouchDB from "pouchdb";
import PouchDBAuth from "pouchdb-authentication";
import request from "request";
PouchDB.plugin(PouchDBAuth);

export function signinODK(user) {
	return new Promise((resolve, reject) => {
		request(
			user.url + "/" + user.dbConfiguration.db + "/" + user.dbConfiguration.schema + "/",
			{
				auth: {
					user: user.username,
					pass: user.password
				},
				timeout: 2000
			},
			function(error, response, body) {
				if (response) {
					if (response.statusCode === 200) {
						resolve(response);
					} else {
						reject({ err: true, status: response.statusCode });
					}
				}
				if (error) {
					reject({ err: true, status: 404 });
				}
			}
		);
	});
}

export function signinBdmer(user) {
	return new Promise((resolve, reject) => {
		let db = new PouchDB(user.url + "/_users", {
			skip_setup: true
		});

		db.logIn(user.username, user.password, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}
