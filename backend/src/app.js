const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");
const app = express();
let apiRoutes = express.Router();
app.use(morgan("combined"));
app.use(bodyParser.json());
app.use(cors());

let authController = require("../controllers/authController");
let synchronisationController = require("../controllers/synchronisationController");

app.post("/signinODK", authController.signinODK);
app.post("/signinBdmer", authController.signinBdmer);
app.post("/import", synchronisationController.seacuseyToBdmer);
app.listen(process.env.PORT || 8081);
