module.exports = app => {
    const users = require("../controllers/mongo.controller.js");
    var router = require("express").Router();
    //crea nuevo user
    router.post("/", users.creaU);
    //muestra todos los user 
    router.get("/", users.buscaU);
    //borra user por id
    router.delete("/:id", users.borraIdU);
    //muestra user por id
    router.get("/:id", users.buscaIdU);
    //actualiza user por id
    router.put("/:id", users.actualizaIdU);
    app.use('/api/users', router);
  };
