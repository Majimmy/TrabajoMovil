import 'package:flutter/material.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/creaLibro.dart';
import 'package:google_fonts/google_fonts.dart';

class Menup extends StatefulWidget {
  Menup({super.key});

  @override
  _MenupState createState() => _MenupState();
}

class _MenupState extends State<Menup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Biblio Mini'), backgroundColor: Colors.blue),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //titulo de pagina
                    Text("Menu principal",
                        style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.blue),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 25,
                    ),
                    /*  //si tubiese tenido tiempo, me gusatria haber hecho 
                        //un boton para ver la lista de libros.
                    Padding(
                      //segmento: boton hacia lista de libros
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //hacia paginna que muestra libros
                                      builder: (context) => Signin()));
                            },
                            child: const Text(
                              "Lista de libros",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    */
                    Padding(
                      // segmento:: boton hacia creacion de libro
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //hacia pagina de ingreso de libros
                                      builder: (context) => Crealib()));
                            },
                            child: const Text(
                              "Ingresar nuevo libro",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      //segmanto: boton para salir de secion
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 209, 203, 202),
                                  width: 1),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              token = null;
                            },
                            child: const Text(
                              "Salir",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
