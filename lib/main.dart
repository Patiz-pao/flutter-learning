import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Patipat",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "List",
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 24),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 57, 143),
          centerTitle: true,
        ),
        body: const Home(),
      ),
    );
  }
}
