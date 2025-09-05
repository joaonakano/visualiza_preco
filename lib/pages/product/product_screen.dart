import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/organisms/product_view_organism.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';

class ProductScreen extends StatelessWidget {
  final Quote quote;

  const ProductScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    // Uso de Organismos
    return ProductViewOrganism(quote: quote);
  }
}