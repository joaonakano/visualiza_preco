import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacings.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;

  const AppFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacings.borderRadius8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(AppSpacings.borderRadius8),
        ),
      ),
      validator: validator,
    );
  }
}
