import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final Color color;

  const AppBarWidget({
    required this.child,
    this.color = Colors.transparent,
    this.height = kToolbarHeight,
    super.key
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: color,
      child: child,
    );
  }
}