let fs = require('fs');
let parse = require('csv-parse')
let axios = require('axios')
let blob = require('blob')

exports.odkToBdmer = (req, res) => {
  console.log(req.body)
  return res.status(200).send()
}

function convert() {
  // pgStructure({
  //     database: 'aggregate',
  //     user: 'postgres',
  //     password: 'docker',
  //     host: '193.51.249.49',
  //     port: 5432
  //   }, ['odk_prod'])
  //   .then((db) => {
  //     // Basic
  //     var tables = db.schemas.get('odk_prod').tables; // Map of Table objects.
  //
  //     // List of table names
  //     let test = null;
  //     for (let table of tables.values()) {
  //       if (test === null) {
  //         test = ta
  //       }
  //       console.log(db.get('odk_prod.' + table.name));
  //     }
  //
  //     console.log(tables[1][1])
  //
  //   })
  //   .catch(err => console.log(err.stack));
  // pool.on('error', (err, client) => {
  //   console.error('Unexpected error on idle client', err)
  //   process.exit(-1)
  // })

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
