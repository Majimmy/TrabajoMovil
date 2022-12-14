const dbConfig = require("../config/db.config.js");
const mongoose = require("mongoose");
mongoose.Promise = global.Promise;
const db = {};
db.mongoose = mongoose;
db.url = dbConfig.url;
db.libros = require("./modeloLibro.js")(mongoose);
db.user = require("./modeloUser.js")(mongoose);
module.exports = db; // aca se arma el elemento db el cual tiene elemento de mongo, url designado y el tipo objeto de la forma de los objetos en la DB.
