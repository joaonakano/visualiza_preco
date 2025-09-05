import 'package:flutter/material.dart';

class AppColors {
  //Backgrounds
  static const Color backgroundDark = Color(0xFF212121);
  static const Color backgroundLight = Color(0xFFF1F4F8);

  //Pretos
  static const Color black = Colors.black;

  //Cinzas
  static const Color lightGrey = Colors.white60;
  static const Color grey = Colors.white54;
  static const Color veryLightGrey = Colors.white12;

  //Textos
  static const Color textDark = Color(0xFF0B191E);
  static const Color textSubtitleGrey = Color(0xFFE0E0E0);

  //Cores de Estado
  static const Color error = Colors.red;
  static const Color errorDark = Color(0xFFB71C1C);
  static const Color success = Colors.green;
  static const Color successSoft = Color(0xFF4B986C);

  //Borda
  static const Color borderColor = Colors.white;

  // Gradients
  static const Color gradientStart = Color(0xFF1A237E);
  static const Color gradientEnd = Color(0xFF3949AB);

  // Brand
  static const Color accentBlue = Colors.lightBlueAccent;
  static const Color primaryBlue = Color(0xFF1E88E5);

  // Placeholder do Chart
  static Color blueGradientAlpha1 = Colors.lightBlueAccent.withAlpha(90);
  static Color blueGradientAlpha2 = Colors.blue.shade800.withAlpha(60);
}
