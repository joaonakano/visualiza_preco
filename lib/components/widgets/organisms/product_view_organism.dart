import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_text.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/image_card.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/info_card.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/templates/main_layout_template.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';

class ProductViewOrganism extends StatelessWidget {
  final Quote quote;

  const ProductViewOrganism({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    // Uso de Templates
    return MainLayoutTemplate(
      appBar: AppBarWidget(title: "Detalhes do Produto"),  // Uso de Molecules
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
                InfoCard(label: "Character", value: quote.character),
                InfoCard(label: "Timestamp", value: quote.timestamp),
                InfoCard(label: "Release Date", value: quote.releaseDate),
                InfoCard(
                  label: "É o ${quote.currentWhoaInMovie}° Whoa dito no filme!",
                  value: "",
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
