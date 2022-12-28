const dotenv = require('dotenv');
dotenv.config();

const mongoose = require("mongoose");
mongoose.Promise = global.Promise;

const db = {};
db.mongoose = mongoose;
db.url = process.env.DB_URL;
db.libros = require("./modeloLibro.js")(mongoose);
db.user = require("./modeloUser.js")(mongoose);
db.usuario = require("./modeloUsLog");
db.role = require("./modeloRol");

db.ROLES = ["user", "admin", "moderator"];

module.exports = db;