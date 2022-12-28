import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/libro.dart';

class Crealib extends StatefulWidget {
  Crealib({super.key});

  @override
  _CrealibState createState() => _CrealibState();
}

class _CrealibState extends State<Crealib> {
  String coderesult = 'En espera..';
  File? image;
  String? base64Image;

  void creaLibro(String titulo, String descripcion, String isbm) {
    Dio().post(
      //(10.0.2.2) para emulador android, (localhost o 127.0.0.1) para web
      //'http://localhost:8080/api/libros',
      'http://10.0.2.2:8080/api/libros',
      data: {
        'titulo': titulo,
        'descripcion': descripcion,
        'disponible': true,
        'usuario': null,
        'isbm': isbm,
        'image': base64Image
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // si el servidor retorna respuesta 200 OK, resive JSON
        Map<String, dynamic> responseJson = response.data;
        String id = responseJson['id'];
        alertaCorrecto(context);
      } else {
        // si el servidor recibe señal 4xx o 5xx, manda error.
        print("algo no funciona bien");
      }
    }).catchError((e) {
      print(e);
      alertaError(context);
    });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      Uint8List imagebytes = await image.readAsBytes();
      // using base64 encoder convert image into base64 string.
      base64Image = base64.encode(imagebytes);

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      Uint8List imagebytes = await image.readAsBytes();
      // using base64 encoder convert image into base64 string.
      base64Image = base64.encode(imagebytes);

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();
  Libro libro = Libro('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Biblio Mini'), backgroundColor: Colors.blue),
        body: Center(
            child: SingleChildScrollView(
                child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //titulo de pagina
                    Text("Agregar nuevo libro",
                        style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.blue),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Titulo",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Padding(
                      //cuadro para ingresar titulo
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: libro.titulo),
                        onChanged: (value) {
                          libro.titulo = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Debe llenar este campo';
                          }
                          return null;
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.description,
                              color: Colors.blue,
                            ),
                            hintText: 'Ingrese titulo de libro',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    const Text(
                      "Descripcion",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Padding(
                      //cuadro para ingresar descripcion
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller:
                            TextEditingController(text: libro.descripcion),
                        onChanged: (value) {
                          libro.descripcion = value;
                        },
                        minLines: 6,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.edit_note_outlined,
                              color: Colors.blue,
                            ),
                            hintText: 'Ingrese descripción de libro',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    const Text(
                      "Ingresar ISBN por código de barras",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Padding(
                      //segmento: scaner
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SimpleBarcodeScannerPage(),
                                  ));
                              setState(() {
                                if (res is String) {
                                  coderesult = res;
                                  libro.isbm = res;
                                }
                              });
                            },
                            child: const Text(
                              "Abrir Escaner",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text('Código obtenido: $coderesult'),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Agregar imagen de portada",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Padding(
                      // segmento:: boton hacia creacion de libro
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text(
                              "Desde Galería",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Padding(
                      // segmento:: boton hacia creacion de libro
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              pickImageC();
                            },
                            child: const Text(
                              "Desde Camara",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      // segmento:imagen
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        //height: 50,
                        width: 300,
                        child: image != null
                            ? Image.file(image!)
                            : const Text(
                                "                    (Imagen no selecconada)"),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      //segmanto: boton para enviar información
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                creaLibro(libro.titulo, libro.descripcion,
                                    libro.isbm);
                              } else {
                                print("not ok");
                              }
                            },
                            child: const Text(
                              "Enviar!",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ))));
  }

  // boton de alerta error
  void alertaError(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("No se han seleccionado bien o faltan parametros"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //alerta todo correcto
  void alertaCorrecto(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => Menup()));*/
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Información"),
      content: const Text("El libro se ha creado exitosamente"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
