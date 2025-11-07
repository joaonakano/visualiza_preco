import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../../../domain/product/entities/product.dart';

class ProductDetailPage extends StatelessWidget {
  final String barcode;

  const ProductDetailPage({Key? key, required this.barcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes Produto')),
      body: Consumer<ProductController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(child: Text('Erro: ${controller.error}'));
          }

          final product = controller.product;
          if (product == null) {
            return const Center(child: Text('Produto não encontrado'));
          }

          return _buildProductDetails(product);
        }
      )
    );
  }
}

Widget _buildProductDetails(Product product) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.imageUrl != null)
          Image.network(
            product.imageUrl!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        
        const SizedBox(height: 16),
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        if (product.brand != null) ...[
          const SizedBox(height: 8),
          Text('Marca: ${product.brand}'),
        ],

        if (product.price != null) ...[
          const SizedBox(height: 8),
          Text('Preços: ${product.price?.toStringAsFixed(2)}'),
        ],

        if (product.stockQuantity != null) ...[
          const SizedBox(height: 8),
          Text('Descrição: ${product.stockQuantity}'),
        ],
      ],
    )
  );
}