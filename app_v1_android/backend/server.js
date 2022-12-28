const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const cookieSession = require("cookie-session");
const app = express();
const dotenv = require('dotenv');
dotenv.config()
// ruta coneccion (cambiar modo de presentacion)
var corsOptions = {
  origin: '*'
};
app.use(cors(corsOptions));

// requests para los tipo - aplicacion/json
app.use(bodyParser.json({ limit: "50mb" }));
// requests para los tipo - aplicacion/x-www-(forma de url)
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true, parameterLimit: 50000 }));
// 
app.use(
  cookieSession({
    name: process.env.COOKIE_SESSION_NAME,
    secret: process.env.COOKIE_SESSION_SECRET, // variable secreto
    httpOnly: true
  })
);
// ruta simple
app.get("/", (req, res) => {
  res.json({ message: "Bienvenido a el Back-end. Si ves este mensaje es porque el backend esta activo" });
});

// integracion de mongoDB 
const db = require("./app/models");
const Role = db.role;
db.mongoose
  .connect(db.url, {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log("Conectado a Base de datos");
    initial();
  })
  .catch(err => {
    console.log("No se puede entablar coneccion", err);
    process.exit();
  });
function initial() {
  Role.estimatedDocumentCount((err, count) => {
    if (!err && count === 0) {
      new Role({
        name: "user"
      }).save(err => {
        if (err) {
          console.log("error", err);
        }
        console.log("agregado 'user' a la coleccion de roles");
      });
      new Role({
        name: "moderator"
      }).save(err => {
        if (err) {
          console.log("error", err);
        }          console.log("agregado 'moderator' a la coleccion de roles");
      });
      new Role({
        name: "admin"
      }).save(err => {
          if (err) {
          console.log("error", err);
        }
        console.log("agregado 'admin' a la coleccion de roles");
      });
    }
  });
}
//rutas de los datos biblioteca
require("./app/routes/libro.routes")(app);
require("./app/routes/user.routes")(app);
//rutas para autorizacion
require('./app/routes/autoriza.routes')(app);
require('./app/routes/usLog.routes')(app);
// puerto para escuchar los requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server corre en el puerto: ${PORT}.`);
});