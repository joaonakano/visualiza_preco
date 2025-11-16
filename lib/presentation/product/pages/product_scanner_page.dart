import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_button.dart';
import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import 'product_detail_page.dart';

class ProductScannerPage extends StatefulWidget {
  const ProductScannerPage({super.key});

  @override
  State<ProductScannerPage> createState() => _ProductScannerPageState();
}

class _ProductScannerPageState extends State<ProductScannerPage> {
  final TextEditingController _barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carrega todos os produtos ao iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getProducts();
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  void _searchProduct() async {
    final barcode = _barcodeController.text.trim();
    if (barcode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite um código de barras'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final controller = context.read<ProductController>();
    await controller.getProduct(barcode);

    if (mounted && controller.product != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailPage(barcode: barcode)),
      );
    } else if (mounted && controller.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.error!), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Dashboard - Produtos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Implementar logout
            },
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Busca manual
                  _buildSearchSection(),
                  const SizedBox(height: 30),

                  // Lista de produtos
                  _buildProductsList(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buscar Produto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _barcodeController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Digite o código de barras',
              hintStyle: TextStyle(color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(height: 15),
          AppButton(
            label: 'Buscar',
            onPressed: _searchProduct,
            backgroundColor: Colors.green[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(ProductController controller) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    if (controller.products.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'Nenhum produto encontrado',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Produtos em Estoque (${controller.products.length})',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return _buildProductCard(product);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(dynamic product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: product.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : Icon(Icons.inventory_2, color: Colors.grey[600]),
        ),
        title: Text(
          product.name ?? 'Produto sem nome',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Código: ${product.barcode.value}',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(height: 4),
              if (product.stockQuantity != null)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Estoque: ${product.stockQuantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(barcode: product.barcode.value),
            ),
          );
        },
      ),
    );
  }
}
