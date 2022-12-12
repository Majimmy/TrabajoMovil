const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
var corsOptions = {
  origin: "http://localhost:8081" // puerto cual escucha
};
// utiliza cors
app.use(cors(corsOptions));
// requests para los tipo - aplicacion/json
app.use(bodyParser.json());
// requests para los tipo - aplicacion/x-www-(forma de url)
app.use(bodyParser.urlencoded({ extended: true }));
// ruta simple
app.get("/", (req, res) => {
  res.json({ message: "Bienvenido a el Back-end. Si ves este mensaje es porque el backend esta activo" });
});
// integracion de mongoDB 
const db = require("./app/models");
db.mongoose
.connect(db.url, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log("Conectado a Base de datos");
})
.catch(err => {
  console.log("No se puede entablar coneccion", err);
  process.exit();
});
// utiliza las rutas creadas
require("./app/routes/libro.routes")(app);
require("./app/routes/user.routes")(app);
// puerto en donde se aloja para escuchar los requests 
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server corre en el puerto: ${PORT}.`);
});
