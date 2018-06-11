let pool = require("../config/postgres");
let PouchDB = require("pouchdb");
let PouchDBAuth = require("pouchdb-authentication");
let jwt = require("jsonwebtoken");
let bcrypt = require("bcryptjs");
let config = require("../config/config");
let pgStructure = require("pg-structure");
let { Pool } = require("pg");
PouchDB.plugin(PouchDBAuth);

exports.signinBdmer = (req, res) => {
	if (!req.body.url || !req.body.username || !req.body.password) {
		res.status(400).send({
			success: false,
			msg: "Missing informations"
		});
	} else {
		let db = new PouchDB(req.body.url + "/_users", {
			skip_setup: true
		});

		db.logIn(req.body.username, req.body.password, function(err, response) {
			if (err) {
				res.status(err.status).send(err);
			} else {
				res.status(200).send(response);
			}
		});
	}
};

exports.signinODK = (req, res) => {
	if (
		!req.body.user.url ||
		!req.body.user.username ||
		!req.body.user.password ||
		!req.body.user.dbConfiguration.db ||
		!req.body.user.dbConfiguration.schema
	) {
		res.status(400).send({
			success: false,
			msg: "Missing informations"
		});
	} else {
		pgStructure(
			{
				database: req.body.user.dbConfiguration.db,
				user: req.body.user.username,
				password: req.body.user.password,
				host: req.body.user.url.split(":")[0],
				port: req.body.user.url.split(":")[1]
			},
			[req.body.user.dbConfiguration.schema]
		)
			.then(db => {
				// Basic
				var tables = db.schemas.get(req.body.user.dbConfiguration.schema)
					.tables; // Map of Table objects.
				res.status(200).send(db);
			})
			.catch(err => {
				res.status(401).send(err);
			});
	}
};
