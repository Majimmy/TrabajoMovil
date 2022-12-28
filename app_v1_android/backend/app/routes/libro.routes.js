module.exports = app => {
    const libros = require("../controllers/mongo.controller.js");
    var router = require("express").Router();
  
    //crea nuevo libro
    router.post("/", libros.crea);
    //muestra todos los libros 
    router.get("/", libros.buscaT);
    //muestra libro por id
    router.get("/:id", libros.buscaId);
    //actualiza libro por id
    router.put("/:id", libros.actualizaId);
    //borra libro por id
    router.delete("/:id", libros.borraId);
    //borra todos los libros ((precaucion al usar))
    router.delete("/", libros.deleteAll);
    //muestra todos los libros con caracteristica "disponible"
    router.get("/disponible", libros.buscaDisponibles);
  
    app.use('/api/libros', router);
  };