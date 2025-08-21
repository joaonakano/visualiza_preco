import 'package:flutter/material.dart';
// import 'package:flutter_visualizador_de_precos/screens/login_screen.dart';
import 'package:flutter_visualizador_de_precos/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta Preço Login',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF1F4F8),
      ),
      home: ProductScreen(),
    );
  }
}
