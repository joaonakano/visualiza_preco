import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/screens/user/login_screen.dart';
import 'package:flutter_visualizador_de_precos/shared/theme/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
