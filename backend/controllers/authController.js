let pool = require("../config/postgres")
let PouchDB = require('pouchdb')
let PouchDBAuth = require("pouchdb-authentication")
let jwt = require('jsonwebtoken')
let bcrypt = require('bcryptjs')
let config = require('../config/config')
let pgStructure = require('pg-structure');
let {
  Pool
} = require('pg')
PouchDB.plugin(PouchDBAuth)

exports.signinBdmer = (req, res) => {
  if (!req.body.url || !req.body.username || !req.body.password) {
    res.status(400).send({
      success: false,
      msg: 'Missing informations'
    });
  } else {
    let db = new PouchDB(req.body.url + '/_users', {
      skip_setup: true
    })

    db.logIn(req.body.username, req.body.password, function(err, response) {
      if (err) {
        res.status(err.status).send(err)
        console.log(err.status)
      } else {
        res.status(200).send(response)
      }
    })
  }
}

exports.signinODK = (req, res) => {
  if (!req.body.url || !req.body.username || !req.body.password) {
    res.status(400).send({
      success: false,
      msg: 'Missing informations'
    });
  } else {
    pgStructure({
        database: 'aggregate',
        user: req.body.username,
        password: req.body.password,
        host: req.body.url,
        port: 5432
      }, ['odk_prod'])
      .then((db) => {
        // Basic
        var tables = db.schemas.get('odk_prod').tables; // Map of Table objects.
        res.status(200).send(db)
      })
      .catch((err) => {
        res.status(401).send(err)
      });
  }
}

exports.verifyToken = (req, res, next) => {
  let token = req.body.token || req.query.token || req.headers['x-access-token']

  if (!token) return res.status(401).send({
    auth: false,
    message: 'No token provided.'
  });

  jwt.verify(token, config.secret, (err, decoded) => {
    if (err) {
      return res.status(500).send({
        auth: false,
        message: 'Failed to authenticate token.'
      })
    } else {
      next()
    }
  })
}
