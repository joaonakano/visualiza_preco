import 'package:flutter/material.dart';

import 'package:flutter_visualizador_de_precos/components/widgets/organisms/product_view_organism.dart';
// 1. Mude o import do modelo
import 'package:flutter_visualizador_de_precos/models/product_model.dart'; 

class ProductScreen extends StatelessWidget {
  // 2. Mude o tipo do objeto de Quote para Product
  final Product product;

  // 3. Atualize o construtor
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 4. Passe o 'product' para o organismo
    // (O 'Uso de Organismos' original se mantém)
    return ProductViewOrganism(product: product);
  }
}