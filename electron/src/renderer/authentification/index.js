import axios from "axios";
import PouchDB from "pouchdb";
import PouchDBAuth from "pouchdb-authentication";

PouchDB.plugin(PouchDBAuth);

export function signinODK(user) {
	return new Promise((resolve, reject) => {
		axios
			.get(user.url + "/" + user.dbConfiguration.db + "/" + user.dbConfiguration.schema)
			.then(response => {
				if (response === undefined) {
					reject(false);
				} else {
					resolve(true);
				}
			})
			.catch(error => {
				reject(false);
			});
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
