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
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageCard(imagePath: quote.poster),
          SizedBox(height: 20),
          AppText(content: quote.fullLine, fontSize: 40, color: AppColors.backgroundLight, fontWeight: FontWeight.bold,)
        ],
        ),
      ),
    );
  }
}