import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'Detalhes do Produto',
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do produto
            if (product.imageUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.imageUrl!,
                    height: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: AppColors.grey,
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: AppColors.veryLightGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.veryLightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: AppColors.grey,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Nome do produto
            Text(
              product.name,
              style: TextStyles.title.copyWith(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 8),

            // Marca
            if (product.brand != null)
              Text(
                product.brand!,
                style: TextStyles.subtitle.copyWith(
                  color: AppColors.backgroundLight.withOpacity(0.7),
                  fontSize: 18,
                ),
              ),

            const SizedBox(height: 24),

            // Código de barras
            _buildInfoCard(
              icon: Icons.qr_code,
              label: 'Código de Barras',
              value: product.barcode,
            ),

            const SizedBox(height: 16),

            // Preço de venda
            if (product.price != null)
              _buildInfoCard(
                icon: Icons.attach_money,
                label: 'Preço de Venda',
                value: 'R\$ ${product.price!.toStringAsFixed(2)}',
                valueColor: AppColors.success,
              ),

            const SizedBox(height: 16),

            // Preço de custo
            if (product.costPrice != null)
              _buildInfoCard(
                icon: Icons.shopping_cart,
                label: 'Preço de Custo',
                value: 'R\$ ${product.costPrice!.toStringAsFixed(2)}',
              ),

            const SizedBox(height: 16),

            // Quantidade em estoque
            if (product.stockQuantity != null)
              _buildInfoCard(
                icon: Icons.inventory,
                label: 'Estoque',
                value: '${product.stockQuantity} unidades',
                valueColor: product.stockQuantity! > 0
                    ? AppColors.success
                    : AppColors.error,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.backgroundLight, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.label.copyWith(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyles.label.copyWith(
                    color: valueColor ?? AppColors.borderColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
