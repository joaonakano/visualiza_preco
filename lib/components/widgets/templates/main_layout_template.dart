import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class MainLayoutTemplate extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color backgroundColor;

  const MainLayoutTemplate({
    super.key,
    required this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.backgroundColor = AppColors.backgroundDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: appBar,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
