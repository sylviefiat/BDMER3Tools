let pool = require("../config/postgres")
let PouchDB = require('pouchdb')
let PouchDBAuth = require("pouchdb-authentication")
let jwt = require('jsonwebtoken')
let bcrypt = require('bcryptjs')
let config = require('../config/config')
var pgStructure = require('pg-structure');

PouchDB.plugin(PouchDBAuth)

let db = new PouchDB('http://localhost:5984/_users', {
  skip_setup: true
})

exports.signinBdmer = (req, res) => {
  db.logIn(req.body.user.username, req.body.user.password).then((response) => {
    console.log(response)
    res.status(200).send(response)
  }).catch((err) => {
    res.status(401).send(err)
  })
}

exports.signinODK = (req, res) => {
  pgStructure({database: 'aggregate', user: 'postgres', password: 'docker', host: '193.51.249.49', port: 5432}, ['odk_prod'])
    .then((db) => {
        // Basic
        var tables = db.schemas.get('odk_prod').tables;  // Map of Table objects.

        // List of table names
        let test = null;
        for (let table of tables.values()) {
          if(test === null){
            test =ta
          }
            console.log(db.get('odk_prod.'+table.name));
        }

        console.log(tables[1][1])

    })
    .catch(err => console.log(err.stack));
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })

  // callback - checkout a client
  // pool.connect((err, client, done) => {
  //   client.query('SELECT * FROM odk_prod.BUILD_SEACUSEY_GALATE_1522901962_PHOTOS_BN', (err, res) => {
  //     if (err) {
  //       console.log(err.stack)
  //     } else {
  //       console.log(res.rows[0])
  //       // { name: 'brianc', email: 'brian.m.carlson@gmail.com' }
  //     }
  //   })
  // })

  // let user = {
  //   id: "dkqsjldkjoijkdnzsdkl"
  // }
  // var token = jwt.sign({
  //   id: user._id
  // }, config.secret, {
  //   expiresIn: 86400 // expires in 24 hours
  // });
  //
  // res.status(200).send({
  //   success: true,
  //   token: token
  // });
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
