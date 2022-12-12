const db = require("../models"); //utiliza los modelos creados en esa carpeta, en este caso el modelo libros
const Libro = db.libros;
const User = db.user;
// Crea y guarda Libro
exports.crea = (req, res) => {
            // para validar elemento no vacio
  if (!req.body.titulo) {
    res.status(400).send({ message: "error: No se admite elemento vacio" });
    return;
  }
            // Crea un libro
  const libro = new Libro({
    titulo: req.body.titulo,
    descripcion: req.body.descripcion,
    disponible: req.body.disponible ? req.body.disponible : false,
    usuario: req.body.usuario
  })
            // guarda Libro
  libro
    .save(libro)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "un error ha sucedido al guardar."
      });
    });
};
// muestra todos los Libros que contengan el titulo entregado
exports.buscaT = (req, res) => {
  const titulo = req.query.titulo;
            //condicion de titulo
  var condition = titulo ? { titulo: { $regex: new RegExp(titulo), $options: "i" } } : {};
  Libro.find(condition)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "un error ha sucedido al buscar por titulo."
      });
    });
};
// busca Libro con un id
exports.buscaId = (req, res) => {
  const id = req.params.id;
  Libro.findById(id)
    .then(data => {
      if (!data)
        res.status(404).send({ message: "No se encuentra libro con id: "+id });
      else res.send(data);
    })
    .catch(err => {
      res
        .status(500)
        .send({ message: "Error buscando libro con la id=" + id });
    });
};
// actualiza Libro por id
exports.actualizaId = (req, res) => {
            //validar elemento no vacio
  if (!req.body) {
    return res.status(400).send({
      message: "Los datos para actualizar no pueden ser vacios."
    });
  }
  const id = req.params.id;
  Libro.findByIdAndUpdate(id, req.body, { useFindAndModify: false })
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: "No se puede actualizar el libro con id = "+id+". Quizas el libro no exista."
        });
      } else res.send({ message: "Libro acualizado correctamaente." });
    })
    .catch(err => {
      res.status(500).send({
        message: "Error al actualizar libro con la id = " + id
      });
    });
};
// borra Libro por id
exports.borraId = (req, res) => {
  const id = req.params.id;
  Libro.findByIdAndRemove(id)
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: "No se pudo borrar el libro con la id = "+id+". Probablemente el libro no exista."
        });
      } else {
        res.send({
          message: "Libro removido de la base de datos correctamente."
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error al tratar de borrar libro con id = " + id
      });
    });
};
// borra todos los Libros
exports.deleteAll = (req, res) => {
  Libro.deleteMany({})
    .then(data => {
      res.send({
        message: "La cantidad de "+data.deletedCount+" libros, han sido borrados correctamente."
      });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Surgio un error al tratar de borrar todos los elementos."
      });
    });
};
// busca todos los Libros publicados
exports.buscaDisponibles = (req, res) => {
  Libro.find({ disponible: true })
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Ha ocurrido un error mientras se buscaban los datos."
      });
    });
};
// los de user empiezan aca
// crear usuario
exports.creaU = (req, res) => {
  // para validar
  if (!req.body.nombre) {
    res.status(400).send({ message: "error: No se admite elemento vacio" });
    return;
  }
  if (!req.body.rut) {
    res.status(400).send({ message: "error: No se admite elemento vacio" });
    return;
  }
  // Crea usuario
  const user = new User({
    nombre: req.body.nombre,
    rut: req.body.rut,
    correo: req.body.correo,
    devolver:req.body.devolver
  })
  // guarda usuario
  user
    .save(user)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
      message:
      err.message || "un error ha sucedido al guardar."
    });
  });
};
// muestra todos los usuarios por nombre entregado
exports.buscaU = (req, res) => {
  const nombre = req.query.nombre;
            //condicion de nombre
  var condition = nombre ? { nombre: { $regex: new RegExp(nombre), $options: "i" } } : {};
  User.find(condition)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "un error ha sucedido al buscar por titulo."
      });
    });
};
// borrar usuario
exports.borraIdU = (req, res) => {
  const id = req.params.id;
  User.findByIdAndRemove(id)
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: "No se pudo borrar el usuario con la id = "+id+". Probablemente no exista."
        });
      } else {
        res.send({
          message: "usuario removido de la base de datos correctamente."
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error al tratar de borrar usuario con id = " + id
      });
    });
};
exports.buscaIdU = (req, res) => {
  const id = req.params.id;
  User.findById(id)
    .then(data => {
      if (!data)
        res.status(404).send({ message: "No se encuentra user con id: "+id });
      else res.send(data);
    })
    .catch(err => {
      res
        .status(500)
        .send({ message: "Error buscando user con la id=" + id });
    });
};
exports.actualizaIdU = (req, res) => {
  if (!req.body) {
    return res.status(400).send({
      message: "Los datos para actualizar no pueden ser vacios."
    });
  }
  const id = req.params.id;
  User.findByIdAndUpdate(id, req.body, { useFindAndModify: false })
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: "No se puede actualizar el user con id = "+id+". Quizas el user no exista."
        });
      } else res.send({ message: "User acualizado correctamaente." });
    })
    .catch(err => {
      res.status(500).send({
        message: "Error al actualizar user con la id = " + id
      });
    });
};
