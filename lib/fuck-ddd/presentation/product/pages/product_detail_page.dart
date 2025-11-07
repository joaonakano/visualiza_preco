import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/product/entities/product.dart';
import '../controllers/product_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final String barcode;

  const ProductDetailPage({super.key, required this.barcode});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ProductController>();
      controller.getProduct(widget.barcode);
    });
  }

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
      body: Consumer<ProductController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.backgroundLight,
              ),
            );
          }

          if (controller.error != null) {
            return Center(
              child: Text(
                'Erro: ${controller.error}',
                style: TextStyles.label.copyWith(
                  color: AppColors.error,
                  fontSize: 16,
                ),
              ),
            );
          }

          final product = controller.product;
          if (product == null) {
            return Center(
              child: Text(
                'Produto não encontrado',
                style: TextStyles.label.copyWith(
                  color: AppColors.backgroundLight,
                  fontSize: 16,
                ),
              ),
            );
          }

          return _buildProductDetails(product);
        },
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do produto
          if (product.imageUrl != null)
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageUrl!,
                    height: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(12),
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
                          borderRadius: BorderRadius.circular(12),
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
          _buildInfoCard(title: 'Nome', value: product.name, icon: Icons.label),

          const SizedBox(height: 16),

          // Marca
          if (product.brand != null)
            _buildInfoCard(
              title: 'Marca',
              value: product.brand!,
              icon: Icons.business,
            ),

          if (product.brand != null) const SizedBox(height: 16),

          // Código de barras
          _buildInfoCard(
            title: 'Código de Barras',
            value: product.barcode.value,
            icon: Icons.qr_code,
          ),

          const SizedBox(height: 16),

          // Preço
          if (product.price != null)
            _buildInfoCard(
              title: 'Preço',
              value: 'R\$ ${product.price!.toStringAsFixed(2)}',
              icon: Icons.attach_money,
              valueColor: AppColors.success,
            ),

          if (product.price != null) const SizedBox(height: 16),

          // Custo
          if (product.costPrice != null)
            _buildInfoCard(
              title: 'Custo',
              value: 'R\$ ${product.costPrice!.toStringAsFixed(2)}',
              icon: Icons.price_change,
              valueColor: AppColors.accentBlue,
            ),

          if (product.costPrice != null) const SizedBox(height: 16),

          // Estoque
          if (product.stockQuantity != null)
            _buildInfoCard(
              title: 'Estoque',
              value: '${product.stockQuantity} unidades',
              icon: Icons.inventory,
              valueColor: AppColors.primaryBlue,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.backgroundLight, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.label.copyWith(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyles.title.copyWith(
                    color: valueColor ?? AppColors.backgroundLight,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
