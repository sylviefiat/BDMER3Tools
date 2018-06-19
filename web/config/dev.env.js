"use strict";
const merge = require("webpack-merge");
const prodEnv = require("./prod.env");

function randomToken(length) {
  var a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".split(
    ""
  );
  var b = [];
  for (var i = 0; i < length; i++) {
    var j = (Math.random() * (a.length - 1)).toFixed(0);
    b[i] = a[j];
  }
  b[0] = '"';
  b.push('"');
  return b.join("");
}

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  TOKEN: randomToken(65)
});
