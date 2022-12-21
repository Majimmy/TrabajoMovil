import 'package:flutter/material.dart';
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
      body: Stack(children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Text("Menu principal",
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.blue),
                textAlign: TextAlign.center)),
      ]),
    );
  }
}
