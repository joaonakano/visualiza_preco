import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_text.dart';

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isFullWidth;

  const InfoCard({
    super.key,
    required this.label,
    required this.value,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: isFullWidth
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AppText(
              content: label,
              fontSize: 20,
              color: AppColors.backgroundLight.withValues(alpha: 0.85),
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  content: "$label:",
                  fontSize: 18,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: AppText(
                    content: value,
                    fontSize: 18,
                    color: AppColors.backgroundLight.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
  );
  }
}