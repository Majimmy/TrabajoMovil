module.exports = mongoose => {
  var schema = mongoose.Schema(
    {
      titulo: String,
      descripcion: String,
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
  return Libro;
};