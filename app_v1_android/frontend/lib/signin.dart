import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/menup.dart';
import 'package:frontend/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
export 'package:frontend/signin.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

var token;

class _SigninState extends State<Signin> {
  void login(String email, String password) {
    Dio().post(
      //(10.0.2.2) para emulador android, (localhost o 127.0.0.1) para web
      //'http://localhost:8080/api/auth/signin',
      'http://10.0.2.2:8080/api/auth/signin',
      data: {'email': email, 'password': password},
    ).then((response) {
      if (response.statusCode == 200) {
        // si el servidor retorna respuesta 200 OK, revisa el JSON y guarda el token
        Map<String, dynamic> responseJson = response.data;
        token = responseJson['accessToken'];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Menup()));
        print(token);
      } else {
        // si el servidor recibe señal 4xx o 5xx, manda error.
        print("algo no funciona bien");
      }
    }).catchError((e) {
      //print(e);
      alertaError(context);
    });
  }

  final _formKey = GlobalKey<FormState>();

  User user = User('', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            child: SvgPicture.asset(
              'images/top.svg',
              width: 400,
              height: 150,
            )),
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  "Biblio Movil",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  // cuadro para ingresar email
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.email = value;
                    },
                    validator: (value) {
                      // confirmar que es un formato de correo valido
                      if (value!.isEmpty) {
                        return 'Escriba algo';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Ingrese un correo valido';
                      }
                    },
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese correo electrónico',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  //cuadro para ingresar contraseña
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.password),
                    onChanged: (value) {
                      user.password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Escriba algo';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.vpn_key,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese contraseña',
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
                Padding(
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
                          if (_formKey.currentState!.validate()) {
                            login(user.email, user.password);
                          } else {
                            print("not ok");
                          }
                        },
                        child: const Text(
                          "Ingresar",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
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

  // boton de alerta
  void alertaError(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Combinación de usuario y contraseña invalidos"),
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
