const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");
const app = express();
let jwt = require("jsonwebtoken");
let bcrypt = require("bcryptjs");
let config = require("../config/config");
let apiRoutes = express.Router();
app.use(morgan("combined"));
app.use(bodyParser.json());
app.use(cors());

let authController = require("../controllers/authController");
let convertController = require("../controllers/convertController");

app.post("/signinODK", authController.signinODK);
app.post("/signinBdmer", authController.signinBdmer);
app.post("/import", convertController.odkToBdmer);
app.listen(process.env.PORT || 8081);
