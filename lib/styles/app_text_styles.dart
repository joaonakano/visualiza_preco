import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle titulo = GoogleFonts.outfit(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle subtitulo = GoogleFonts.outfit(
    color: const Color(0xFFE0E0E0),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle botao = GoogleFonts.outfit(
    color: const Color(0xFF4B986C),
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle label = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF0B191E),
  );
}
