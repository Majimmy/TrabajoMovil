module.exports = mongoose => {
  var schema = mongoose.Schema(
    {
      titulo: String,
      descripcion: String,   //atributos que se van a trabajar (aparte de la _id)
      disponible: Boolean,
      usuario: { type: mongoose.Schema.Types.ObjectId, ref: 'users' }
    },
    { timestamps: true }
  );
  schema.method("toJSON", function() {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    return object;
  });
  const Libro = mongoose.model("libro", schema);
  return Libro; //se termina creando un objeto con la forma deseada (la de un libro) y se retorna para su uso en multiples funciones
};
