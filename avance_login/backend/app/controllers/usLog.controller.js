exports.allAccess = (req, res) => {
    res.status(200).send("Contenido publico.");
  };
  
  exports.userBoard = (req, res) => {
    res.status(200).send("Contenido usuario.");
  };
  
  exports.adminBoard = (req, res) => {
    res.status(200).send(true);
  };
  
  exports.moderatorBoard = (req, res) => {
    res.status(200).send(true);
  };