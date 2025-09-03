import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacings.dart';

class AppText extends StatelessWidget {
  final String content;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const AppText({
    super.key,
    required this.content,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacings.spacingXS),
      child: Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
