let fs = require('fs');
let parse = require('csv-parse')
let axios = require('axios')
let blob = require('blob')

exports.odkToBdmer = (req, res) => {
  console.log(req.body)
  return res.status(200).send()
}

function convert() {

}
