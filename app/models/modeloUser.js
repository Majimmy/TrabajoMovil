module.exports = mongoose => {
    var schema = mongoose.Schema(
      {
        nombre: String,
        rut: {type: String, unique: true, required: true, dropDups: true}, // convierte el atributo en unico y rechaza una duplicacion
        correo: {type: String, unique: true, required: true, dropDups: true},
        devolver: Number
      },
      { timestamps: true }
    );
    schema.method("toJSON", function() {
      const { __v, _id, ...object } = this.toObject();
      object.id = _id;
      return object;
    });
    const User = mongoose.model("user", schema);
    return User;
  };
