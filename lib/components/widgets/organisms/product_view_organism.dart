import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_text.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/image_card.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/templates/main_layout_template.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';

class ProductViewOrganism extends StatelessWidget {
  final Quote quote;

  const ProductViewOrganism({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    // Uso de Templates
    return MainLayoutTemplate(
      appBar: AppBarWidget(title: "Detalhes do CU"),  // Uso de Molecules
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(24),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: ImageCard(
                      imagePath: quote.poster,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AppText(
                  content: quote.fullLine,
                  fontSize: 34,
                  color: AppColors.backgroundLight,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                AppText(
                  content: quote.movie,
                  fontSize: 22,
                  color: AppColors.backgroundLight.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                AppText(
                  content: quote.year.toString(),
                  fontSize: 18,
                  color: AppColors.backgroundLight.withValues(alpha: 0.65),
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      AppText(
                        content: "Curiosidades Keanu-Reeveanas",
                        color: AppColors.grey,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 3,
                        width: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.backgroundLight.withValues(alpha: 0.6),
                              AppColors.grey.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoCard("Character", quote.character),
                _buildInfoCard("Timestamp", quote.timestamp),
                _buildInfoCard("Release Date", quote.releaseDate),
                _buildInfoCard(
                  "É o ${quote.currentWhoaInMovie}° Whoa dito no filme!",
                  "",
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, {bool isFullWidth = false}) {
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
                    color: Colors.black.withValues(alpha: 0.1),
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
                    color: Colors.black.withValues(alpha: 0.08),
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
