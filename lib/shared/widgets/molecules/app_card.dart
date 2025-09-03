import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacings.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double elevation;

  const AppCard({
    super.key,
    required this.child,
    this.elevation = AppSpacings.cardElevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.veryLightGrey,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacings.borderRadius20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.cardPadding),
        child: child,
      ),
    );
  }
}
