import PouchDB from "pouchdb";
import axios from "axios";

export function seacuseyToBdmer(user) {
	return new Promise((resolve, reject) => {
		synchronize(user)
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
					console.log(response);
					if (platforms[platforms.length - 1] === plat) {
						resolve({ errors: errors, success: success });
					}
				})
				.catch(err => {
					console.log(err);
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

/*
	Synchronisation between Seacusey Survey and BDMER3
	user: information from the user
*/
function synchronize(user) {
	let tables = [];
	let warnings = [];
	let platforms = [];
	let errors = [];
	let speciesBdmer = [];
	let addPlatform = false;
	let rows = [];
	let end = false;

	return new Promise((resolve, reject) => {
		axios
			.get(user.odk.url + "/" + user.odk.dbConfiguration.db + "/" + user.odk.dbConfiguration.schema)
			.then(allTables => {
				for (let table of allTables.data) {
					if (table.name.startsWith("BUILD") && table.name.endsWith("CORE")) {
						tables.push(table.name);
					}
				}

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
							axios
								.get(user.odk.url + "/" + user.odk.dbConfiguration.db + "/" + user.odk.dbConfiguration.schema + "/" + table)
								.then(data => {
									// If the table isn't empty
									if (data.data.length > 0) {
										// Checking if the platform exist
										checkPlatformExist(user.bdmer.url, data.data[0])
											.then(platform => {
												// If platform isn't found
												if (platform.status === 404) {
													errors.push({
														error: data.data[0].META_INSTANCE_NAME.split("-")[0],
														msg: "Platform not found"
													});
												} else {
													// Browsing each row of the table
													for (let row of data.data) {
														// If we are at the last row of the last table
														if (table === tables[tables.length - 1] && data.data[data.data.length - 1] === row) {
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
								})
								.catch(err => reject({ err: err, type: "odk" }));
						}
					})
					.catch(err => reject({ err: err, type: "bdmer" }));
			})
			.catch(err => reject({ err: err, type: "odk" }));
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
				reject({ err: err, type: "table" });
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

		db.get(data.META_INSTANCE_NAME.split("-")[0])
			.then(function(doc) {
				resolve(doc);
			})
			.catch(function(err) {
				if (err.message === "Database does not exist.") {
					reject({ err: err, type: "table" });
				} else {
					resolve(err);
				}
			});
	});
}
