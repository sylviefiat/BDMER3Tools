let fs = require("fs");
let parse = require("csv-parse");
let axios = require("axios");
let blob = require("blob");
let pgStructure = require("pg-structure");
let { Pool, Client } = require("pg");
let PouchDB = require("pouchdb");

exports.odkToBdmer = (req, res) => {
	importFromOdk(req.body);
	return res.status(200).send();
};

function importFromOdk(user) {
	if (!user.odk.url || !user.odk.username || !user.odk.password || !user.odk.dbConfiguration.db || !user.odk.dbConfiguration.schema) {
		return null;
	} else {
		pgStructure(
			{
				database: user.odk.dbConfiguration.db,
				user: user.odk.username,
				password: user.odk.password,
				host: user.odk.url.split(":")[0],
				port: user.odk.url.split(":")[1]
			},
			[user.odk.dbConfiguration.schema]
		)
			.then(db => pgStructure.serialize(db))
			.then(data => {
				var json = JSON.parse(data);
				for (let table of json.schemas["0"].tables) {
					// if (table.name.startsWith("BUILD") && table.name.endsWith("CORE")) {
					if (table.name === "BUILD_SEACUSEY_ANONYME_1522902257_CORE") {
						const client = new Client({
							user: user.odk.username,
							host: user.odk.url.split(":")[0],
							database: user.odk.dbConfiguration.db,
							password: user.odk.dbConfiguration.password,
							port: user.odk.url.split(":")[1]
						});
						client.connect();
						client.query("SELECT * FROM " + user.odk.dbConfiguration.schema + '."' + table.name + '"', (err, data) => {
							for (let row of data.rows) {
								let test = null;
								let test2 = null;
								checkSpecieExist(user.bdmer.url, row)
									.then(() => {
										checkPlatformExist(user.bdmer.url, row)
											.then(() => {
												createStation(row);
											})
											.catch(() => console.log("err"));
									})
									.catch(() => console.log("err"));
							}
							client.end();
						});
					}
				}
			})
			.catch(err => console.log(err.stack));
	}
}

function createStation(data) {
	let station = {
		type: "Feature",
		geometry: {
			type: "Point",
			coordinates: []
		},
		properties: {
			name: "",
			code: "",
			description: ""
		},
		staticMapStation: "",
		codePlatform: ""
	};

	if (data.GPS_MANUAL_UPDATED_LONGITUDE === "0.0000000000" || data.GPS_MANUAL_UPDATED_LONGITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LONGITUDE === "0.0000000000" || data.GPS_MANUAL_CURRENT_LONGITUDE === null) {
			return null;
		} else {
			station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_CURRENT_LONGITUDE));
		}
	} else {
		station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_UPDATED_LONGITUDE));
	}

	if (data.GPS_MANUAL_UPDATED_LATITUDE === "0.0000000000" || data.GPS_MANUAL_UPDATED_LATITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LATITUDE === "0.0000000000" || data.GPS_MANUAL_CURRENT_LATITUDE === null) {
			return null;
		} else {
			station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_CURRENT_LATITUDE));
		}
	} else {
		station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_UPDATED_LATITUDE));
	}

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return null;
	} else {
		station.codePlatform = data.META_INSTANCE_NAME.split("-")[0];
		station.properties.name = data.META_INSTANCE_NAME;
		station.properties.code = data.META_INSTANCE_NAME;
	}
	console.log(station);
}

function checkSpecieExist(url, data) {
	return new Promise(function(resolve, reject) {
		let db = new PouchDB(url + "/species", {
			skip_setup: true
		});
		db.get("tes")
			.then(function(doc) {
				resolve();
			})
			.catch(function(err) {
				reject();
			});
	});
}

function checkPlatformExist(url, data) {
	return new Promise(function(resolve, reject) {
		let db = new PouchDB(url + "/platforms", {
			skip_setup: true
		});

		db.get(data.META_INSTANCE_NAME.split("-")[0])
			.then(function(doc) {
				resolve();
			})
			.catch(function(err) {
				reject();
			});
	});
}
