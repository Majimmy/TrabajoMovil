const jwt = require("jsonwebtoken");
const db = require("../models");
const dotenv = require('dotenv');
dotenv.config();
const Usuario = db.usuario;
const Role = db.role;

verifyToken = (req, res, next) => {
  let token = req.headers["x-access-token"]; ///////
  if (!token) {
    return res.status(403).send({ message: "No se ha dado token!" });
  }
  jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).send({ message: "Sin autorizacion!" });
    }
    req.userId = decoded.id;
    next();
  });
};
isAdmin = (req, res, next) => {
  Usuario.findById(req.userId).exec((err, user) => {
    if (err) {
      res.status(500).send({ message: err });
      return;
    }
    Role.find(
      {
        _id: { $in: user.roles },
      },
      (err, roles) => {
        if (err) {
          res.status(500).send({ message: err });
          return;
        }
        for (let i = 0; i < roles.length; i++) {
          if (roles[i].name === "admin") {
            next();
            return;
          }
        }
        res.status(403).send({ message: "Requiere Rol Admin!" });
        return;
      }
    );
  });
};
isModerator = (req, res, next) => {
  Usuario.findById(req.userId).exec((err, user) => {
    if (err) {
      res.status(500).send({ message: err });
      return;
    }
    Role.find(
      {
        _id: { $in: user.roles },
      },
      (err, roles) => {
        if (err) {
          res.status(500).send({ message: err });
          return;
        }
        for (let i = 0; i < roles.length; i++) {
          if (roles[i].name === "moderator") {
            next();
            return;
          }
        }
        res.status(403).send({ message: "Requiere Rol Moderador!" });
        return;
      }
    );
  });
};

const authJwt = {
  verifyToken,
  isAdmin,
  isModerator,
};
module.exports = authJwt;