import PouchDB from "pouchdb";
import request from "request";

export function seacuseyToBdmer(user) {
	return new Promise((resolve, reject) => {
		getTablesOdk(user.odk)
			.then(tables => {
				synchronize(user, tables)
					.then(response => {
						if (response.platforms.length > 0) {
							updateBdmer(response.platforms, user).then(plat => {
								for (let r of plat.errors) {
									response.errors.push(r);
								}
								resolve({ errors: response.errors, warnings: response.warnings, success: plat.success });
							});
						} else {
							resolve({ errors: response.errors, warnings: response.warnings, success: [] });
						}
					})
					.catch(err => {
						reject(err);
					});
			})
			.catch(error => {
				reject(error);
			});
	});
}

/*
	Updating platforms of BDMER3
	platforms: list of platform to update
	user: information from the user
*/
function updateBdmer(platforms, user) {
	let errors = [];
	let success = [];

	let db = new PouchDB(user.bdmer.url + "/platforms", {
		skip_setup: true
	});

	return new Promise((resolve, reject) => {
		for (let plat of platforms) {
			db.put(plat.platform)
				.then(response => {
					for (let row of plat.rows) {
						success.push({ success: row.META_INSTANCE_NAME, msg: "Imported with success" });
					}
					if (platforms[platforms.length - 1] === plat) {
						resolve({ errors: errors, success: success });
					}
				})
				.catch(err => {
					errors.push({
						error: plat.code,
						msg: "Couldnt be inserted in database"
					});

					if (platforms[platforms.length - 1] === plat) {
						resolve({ errors: errors, success: success });
					}
				});
		}
	});
}

function getTablesOdk(user) {
	let tables = [];
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
						let allTables = JSON.parse(body);
						for (let table of allTables) {
							if (table.name.startsWith("BUILD") && table.name.endsWith("CORE")) {
								tables.push(table.name);
							}
						}
						resolve(tables);
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

/*
	Synchronisation between Seacusey Survey and BDMER3
	user: information from the user
*/
function synchronize(user, tables) {
	let warnings = [];
	let platforms = [];
	let errors = [];
	let speciesBdmer = [];
	let addPlatform = false;
	let rows = [];
	let end = false;

	return new Promise((resolve, reject) => {
		getAllSpecies(user.bdmer.url)
			.then(species => {
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

				for (let table of tables) {
					request(
						user.odk.url + "/" + user.odk.dbConfiguration.db + "/" + user.odk.dbConfiguration.schema + "/" + table,
						{
							auth: {
								user: user.odk.username,
								pass: user.odk.password,
								sendImmediately: false
							},
							timeout: 2000
						},
						function(error, response, body) {
							if (response) {
								let data = JSON.parse(body);
								// If the table isn't empty
								if (data.length > 0) {
									// Checking if the platform exist
									checkPlatformExist(user.bdmer.url, data[0])
										.then(platform => {
											// If platform isn't found
											if (platform.status === 404) {
												errors.push({
													error: data[0].META_INSTANCE_NAME.split("-")[0].replace("_", " "),
													msg: "Platform not found"
												});
												if (table === tables[tables.length - 1]) {
													resolve({ errors: errors, warnings: warnings, platforms: platforms });
												}
											} else {
												// Browsing each row of the table
												for (let row of data) {
													// If we are at the last row of the last table
													if (table === tables[tables.length - 1] && data[data.length - 1] === row) {
														end = true;
													}
													let station = createStation(row, platform);
													if (station.err) {
														errors.push({
															error: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
															msg: station.msg
														});
													} else if (station.warning) {
														warnings.push({
															warning: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
															msg: station.msg
														});
													} else {
														let survey = createSurvey(row, platform);
														if (survey.err) {
															errors.push({
																error: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																msg: survey.msg
															});
														} else if (survey.warning) {
															warnings.push({
																warning: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																msg: survey.msg
															});
														} else {
															let count = createCount(row, platform, station, survey, speciesBdmer);
															if (count.err) {
																errors.push({
																	error: row.META_INSTANCE_NAME === null || row.META_INSTANCE_NAME === "" ? "No identifier" : row.META_INSTANCE_NAME,
																	msg: count.msg
																});
															} else {
																platform.stations.push(station);
																survey.counts.push(count);
																platform.surveys.push(survey);
																addPlatform = true;
																rows.push(row);
															}
														}
													}
												}

												// If we have a valid platform
												if (addPlatform) {
													platforms.push({ platform: platform, rows: rows });
													addPlatform = false;
													rows = [];
												}

												// If we browsed all the rows of the tables
												if (end) {
													resolve({ errors: errors, warnings: warnings, platforms: platforms });
												}
											}
										})
										.catch(err => reject({ err: err, type: "bdmer" }));
								}
							}
							if (error) {
								reject({ err: error, type: "odk" });
							}
						}
					);
				}
			})
			.catch(err => reject({ err: err, type: "bdmer" }));
	});
}

/*
	Refactoring a coordinate in from Degrees Minutes Decimal to Decimal
	data: row of the pg database
	platform: platform refering to the row
*/
function createStation(data, platform) {
	let lng = "";
	let lat = "";

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

	if (!platform.stations) {
		return { err: true, msg: "Platform has no station array in db" };
	}

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return { err: true, msg: "No name provided" };
	} else {
		for (let i = 0; i < platform.stations.length; i++) {
			if (data.META_INSTANCE_NAME === platform.stations[i].properties.code) {
				return { warning: true, msg: "station already exist" };
			}
		}
		station.properties.name = data.META_INSTANCE_NAME;
		station.properties.code = data.META_INSTANCE_NAME;
	}

	if (data.GPS_MANUAL_UPDATED_LONGITUDE === 0 || data.GPS_MANUAL_UPDATED_LONGITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LONGITUDE === 0 || data.GPS_MANUAL_CURRENT_LONGITUDE === null) {
			return { err: true, msg: "No lng provided" };
		} else {
			lng = data.GPS_MANUAL_CURRENT_LONGITUDE;
		}
	} else {
		lng = refactorCoord(data.GPS_MANUAL_UPDATED_LONGITUDE);
	}

	if (data.GPS_MANUAL_UPDATED_LATITUDE === 0 || data.GPS_MANUAL_UPDATED_LATITUDE === null) {
		if (data.GPS_MANUAL_CURRENT_LATITUDE === 0 || data.GPS_MANUAL_CURRENT_LATITUDE === null) {
			return { err: true, msg: "No lat provided" };
		} else {
			lat = data.GPS_MANUAL_CURRENT_LATITUDE;
		}
	} else {
		lat = refactorCoord(data.GPS_MANUAL_UPDATED_LATITUDE);
	}

	station.geometry.coordinates.push(lng, lat);

	return station;
}

/*
	Refactoring a coordinate in from Degrees Minutes Decimal to Decimal
	coord: lat or lng in Degrees Minutes Decimal
*/
function refactorCoord(coord) {
	coord = coord
		.toUpperCase()
		.split(" ")
		.join("");
	coord =
		(coord.substr(coord.length - 1) === "S" || coord.substr(coord.length - 1) === "W" || coord.substr(coord.length - 1) === "O" ? -1 : 1) *
		(parseFloat(coord.split("°")[0]) + parseFloat(coord.split("°")[1].split("'")[0]) / 60);

	return coord;
}

/*
	Creating an object 'Survey' according to BDMER3 'Survey' structure
	data: row of the pg database
	platform: platform refering to the row
*/
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

	if (!platform.surveys) {
		return { err: true, msg: "Platform has no survey array in db" };
	}

	if (data.META_INSTANCE_NAME === null || data.META_INSTANCE_NAME === "") {
		return { err: true, msg: "No name provided" };
	} else {
		for (let i = 0; i < platform.surveys.length; i++) {
			if (platform.surveys[i].code === data.META_INSTANCE_NAME) {
				return { warning: true, msg: "survey already exist" };
			}
		}
		survey.code = data.META_INSTANCE_NAME;
	}

	if (data.FISHING_DATE === null || data.FISHING_DATE === "") {
		return { err: true, msg: "No fishing date provided" };
	} else {
		survey.dateEnd = data.FISHING_DATE;
		survey.dateStart = data.FISHING_DATE;
	}

	return survey;
}

/*
	Creating an object 'Count' according to BDMER3 'Count' structure
	data: row of the pg database
	platform: platform refering to the row
	station: station refering to the row
	survey: survey refering to the row
	speciesBdmer: species available in bdmer
*/
function createCount(data, platform, station, survey, speciesBdmer) {
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
		return { err: true, msg: "No name provided" };
	} else {
		count.code = data.META_INSTANCE_NAME;
	}

	let speciesName = [];

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

/*
	Getting all the species from BDMER3
	url: BDMER3 url
*/
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
				if (err.code === "ECONNREFUSED") {
					reject({ err: err, type: "connection" });
				} else {
					reject({ err: err, type: "table", table: "species" });
				}
			});
	});
}

/*
	Check if the platform exist in BDMER3
	url: BDMER3 url
	data: the platform which you want to check his existence
*/
function checkPlatformExist(url, data) {
	return new Promise(function(resolve, reject) {
		let db = new PouchDB(url + "/platforms", {
			skip_setup: true
		});
		db.allDocs({
			include_docs: true
		})
			.then(function(doc) {
				let names = [];
				for (let row of doc.rows) {
					if (
						row.id
							.toUpperCase()
							.replace("_", " ")
							.replace("-", " ") ===
						data.META_INSTANCE_NAME.split("-")[0]
							.toUpperCase()
							.replace("_", " ")
					) {
						resolve(row.doc);
					}

					if (row === doc.rows[doc.rows.length - 1]) {
						resolve({
							docId: data.META_INSTANCE_NAME.split("-")[0].replace("_", " "),
							error: "not_found",
							message: "missing",
							name: "not_found",
							reason: "missing",
							status: 404
						});
					}
				}
			})
			.catch(function(err) {
				if (err.code === "ECONNREFUSED") {
					reject({ err: err, type: "connection" });
				} else {
					reject({ err: err, type: "table", table: "platforms" });
				}
			});
	});
}
