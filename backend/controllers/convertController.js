let fs = require("fs");
let parse = require("csv-parse");
let axios = require("axios");
let blob = require("blob");
let pgStructure = require("pg-structure");
let { Pool, Client } = require("pg");
let PouchDB = require("pouchdb");

exports.odkToBdmer = (req, res) => {
	importFromOdk(req.body)
		.then(response => {
			console.log(response);
			return res.status(200).send(response);
		})
		.catch(err => {
			return res.status(401).send(response);
		});
};

function importFromOdk(user) {
	let errors = [];
	return new Promise(function(resolve, reject) {
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

					getAllSpecies(user.bdmer.url)
						.then(species => {
							for (let table of json.schemas["0"].tables) {
								if (table.name.startsWith("BUILD") && table.name.endsWith("CORE")) {
									// if (table.name === "BUILD_SEACUSEY_ANONYME_1522902257_CORE") {
									// if (table.name === "BUILD_SEACUSEY_MUSCADIN_1522902223_CORE" || table.name === "BUILD_SEACUSEY_ANONYME_1522902257_CORE") {
									const client = new Client({
										user: user.odk.username,
										host: user.odk.url.split(":")[0],
										database: user.odk.dbConfiguration.db,
										password: user.odk.dbConfiguration.password,
										port: user.odk.url.split(":")[1]
									});
									client.connect();
									client.query("SELECT * FROM " + user.odk.dbConfiguration.schema + '."' + table.name + '"', (err, data) => {
										let db = new PouchDB(user.bdmer.url + "/platforms", {
											skip_setup: true
										});
										if (data.rows[0] !== undefined) {
											checkPlatformExist(user.bdmer.url, data.rows[0])
												.then(platform => {
													if (platform.status === 404) {
														let err = {
															table: table.name,
															msg: "not platform found"
														};

														if (!errors.includes(err)) {
															errors.push(err);
														}
													} else {
														for (let row of data.rows) {
															let station = createStation(row, platform);
															if (station.err) {
																errors.push({
																	row: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																	msg: station.msg
																});
															} else {
																let survey = createSurvey(row, platform);
																if (survey.err) {
																	errors.push({
																		row: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																		msg: survey.msg
																	});
																} else {
																	let count = createCount(row, platform, station, survey, species);
																	if (count.err) {
																		errors.push({
																			row:
																				row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																			msg: count.msg
																		});
																	} else {
																		platform.stations.push(station);
																		survey.counts.push(count);
																		platform.surveys.push(survey);
																		// db.put(platform)
																		// 	.then(function(response) {
																		// 		console.log(response);
																		// 	})
																		// 	.catch(function(err) {
																		// 		console.log(err);
																		// 	});
																	}
																}
															}
														}
														setTimeout(() => {
															resolve(errors);
														}, 3000);
													}
												})
												.catch(err => console.log(err));
										}
										client.end();
									});
								}
							}
						})
						.catch(err => console.log(err));
				})
				.catch(err => console.log(err.stack));
		}
	});
}

function createStation(data, platform) {
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
		codePlatform: platform.code
	};

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return { err: true, msg: "no name provided" };
	} else {
		for (let i = 0; i < platform.stations.length; i++) {
			if (data.META_INSTANCE_NAME === platform.stations[i].properties.code) {
				return { err: true, msg: "station already exist" };
			}
		}
		station.properties.name = data.META_INSTANCE_NAME;
		station.properties.code = data.META_INSTANCE_NAME;
	}

	if (data.GPS_MANUAL_UPDATED_LONGITUDE === "0.0000000000" || data.GPS_MANUAL_UPDATED_LONGITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LONGITUDE === "0.0000000000" || data.GPS_MANUAL_CURRENT_LONGITUDE === null) {
			return { err: true, msg: "no lng provided" };
		} else {
			station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_CURRENT_LONGITUDE));
		}
	} else {
		station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_UPDATED_LONGITUDE));
	}

	if (data.GPS_MANUAL_UPDATED_LATITUDE === "0.0000000000" || data.GPS_MANUAL_UPDATED_LATITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LATITUDE === "0.0000000000" || data.GPS_MANUAL_CURRENT_LATITUDE === null) {
			return { err: true, msg: "no lat provided" };
		} else {
			station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_CURRENT_LATITUDE));
		}
	} else {
		station.geometry.coordinates.push(parseFloat(data.GPS_MANUAL_UPDATED_LATITUDE));
	}

	return station;
}

function createSurvey(data, platform) {
	let survey = {
		code: "",
		codePlatform: platform.code,
		dateStart: "",
		dateEnd: "",
		participants: "",
		surfaceTransect: "",
		description: "",
		codeCountry: platform.codeCountry,
		counts: []
	};

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return { err: true, msg: "no name provided" };
	} else {
		for (let i = 0; i < platform.surveys.length; i++) {
			if (platform.surveys[i].code === data.META_INSTANCE_NAME) {
				return { err: true, msg: "survey already exist" };
			}
		}
		survey.code = data.META_INSTANCE_NAME;
	}

	if (data.FISHING_DATE === null || data.FISHING_DATE === "") {
		return { err: true, msg: "no fishing date provided" };
	} else {
		survey.dateEnd = data.FISHING_DATE;
		survey.dateStart = data.FISHING_DATE;
	}

	return survey;
}

function createCount(data, platform, station, survey, species) {
	let count = {
		code: "",
		codePlatform: platform.code,
		codeSurvey: survey.code,
		codeStation: station.properties.code,
		date: null,
		monospecies: null,
		mesures: []
	};

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return { err: true, msg: "no name provided" };
	} else {
		count.code = data.META_INSTANCE_NAME;
	}

	let speciesName = [];

	speciesName.push("SPECIES_DETAILS_VENT_BLAN_COUNT");
	speciesName.push("SPECIES_DETAILS_VENT_rf_q_qsdqsdd_COUNT");

	for (var key in data) {
		if (key.startsWith("SPECIES_DETAILS_") && key.endsWith("_COUNT") && data[key] !== null) {
			speciesName.push(key);
		}
	}

	for (let i in speciesName) {
		let name = speciesName[i]
			.split("SPECIES_DETAILS_")[1]
			.split("_COUNT")[0]
			.split("_");

		let refactorName = "";

		for (let y = 0; y < name.length; y++) {
			if (y === name.length - 1) {
				refactorName += name[y];
			} else {
				refactorName += name[y] + " ";
			}
		}
		speciesName[i] = refactorName;
	}

	let speciesBdmer = [];
	for (let specie of species) {
		let sp = {
			code: specie.doc.code,
			names: []
		};
		for (let name of specie.doc.names) {
			sp.names.push(name.name.toLowerCase());
		}
		speciesBdmer.push(sp);
	}

	for (let name of speciesName) {
		for (let sp of speciesBdmer) {
			if (sp.names.includes(name.toLowerCase())) {
				let mesure = {
					codeSpecies: sp.code,
					long: "",
					larg: ""
				};
				count.mesures.push(mesure);
			}
		}
	}

	if (count.mesures.length > 1) {
		count.monospecies = false;
	} else {
		count.monospecies = true;
	}

	return count;
}

function getAllSpecies(url) {
	return new Promise(function(resolve, reject) {
		let db = new PouchDB(url + "/species", {
			skip_setup: true
		});

		db.allDocs({
			include_docs: true
		})
			.then(function(doc) {
				resolve(doc.rows);
			})
			.catch(function(err) {
				reject(err);
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
				resolve(doc);
			})
			.catch(function(err) {
				resolve(err);
			});
	});
}
