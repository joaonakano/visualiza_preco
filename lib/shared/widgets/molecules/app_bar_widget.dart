import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double height;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = AppColors.gradientStart,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: AppColors.lightGrey)),
      backgroundColor: backgroundColor,
      actions: actions,
      iconTheme: IconThemeData(color: AppColors.lightGrey),
    );
  }
}
