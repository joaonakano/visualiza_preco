import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class TextStyles {
  static final TextStyle title = GoogleFonts.outfit(
    color: AppColors.lightGrey,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle subtitle = GoogleFonts.outfit(
    color: AppColors.textSubtitleGrey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle button = GoogleFonts.outfit(
    color: AppColors.successSoft,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle label = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );
}
