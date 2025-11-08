import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
// Importando do DDD
import 'package:flutter_visualizador_de_precos/domain/product/entities/product.dart';

class ProductViewOrganism extends StatelessWidget {
  // 3. Mude de 'Quote' para 'Product'
  final Product product;

  // 4. Atualize o construtor
  const ProductViewOrganism({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 5. Esta é a UI de detalhes do produto, usando seus estilos
    return Scaffold(
      // Usei seu AppBarWidget como exemplo, mas pode ser um AppBar normal
      appBar: AppBar(
        title: Text(product.brand ?? "Detalhes do Produto"),
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- A FOTO ---
            if (product.imageUrl != null)
              Center(
                child: Image.network(
                  product.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.backgroundLight,
                            ),
                          );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 200,
                      color: AppColors.grey,
                    );
                  },
                ),
              ),

            SizedBox(height: 24),

            // --- NOME E MARCA ---
            Text(
              product.name,
              style: TextStyles.title.copyWith(
                // Usando seu TextStyles
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            if (product.brand != null)
              Text(
                product.brand!,
                style: TextStyles.subtitle.copyWith(
                  color: AppColors.backgroundLight.withOpacity(
                    0.7,
                  ), // Usando seu AppColors
                  fontSize: 18,
                ),
              ),

            SizedBox(height: 8),
            Text(
              "CÓDIGO: ${product.barcode}",
              style: TextStyles.label.copyWith(
                color: AppColors.grey,
              ), // Usando seus estilos
            ),

            Divider(
              height: 32,
              thickness: 1,
              color: AppColors.grey.withOpacity(0.5),
            ),

            // --- PREÇO, CUSTO E ESTOQUE (Seus dados) ---
            Text(
              "Preço de Venda:",
              style: TextStyles.label.copyWith(
                color: AppColors.grey,
                fontSize: 18,
              ),
            ),
            Text(
              "R\$ ${product.price?.toStringAsFixed(2) ?? 'Não cadastrado'}",
              style: TextStyles.title.copyWith(
                color: Colors.blue, // Cor de destaque para preço
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Preço de Custo: R\$ ${product.costPrice?.toStringAsFixed(2) ?? 'N/A'}",
              style: TextStyles.label.copyWith(
                color: AppColors.backgroundLight.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            Text(
              "Estoque: ${product.stockQuantity ?? 'N/A'} unidades",
              style: TextStyles.label.copyWith(
                color: AppColors.backgroundLight.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
