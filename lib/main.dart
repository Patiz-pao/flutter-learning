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
      debugShowCheckedModeBanner: false,
      title: "Patipat",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 155, 65),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
        "Book Store",
        style: GoogleFonts.kanit(color: Colors.white, fontSize: 24),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 155, 65),
          centerTitle: true,
          actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
          ],
        ),
        body: const Center(
          child: Home(),
        ),
      ),
    );
  }
}
