import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/image_card.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/organisms/product_view_organism.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/templates/main_layout_template.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';

class ProductScreen extends StatelessWidget {
  final Quote quote;

  const ProductScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    // Uso de Templates
    return ProductViewOrganism(quote: quote);
  }
}


/*return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'Detalhes da Quote',
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          IconButton(
            onPressed: () => print("Icon search button pressed! =["),
            icon: const Icon(Icons.search_off_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCard(imagePath: quote.poster),
                
              ],
            ),
          ),
        ),
      ),
    );*/