import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/product_scanner_page.dart';
import 'package:provider/provider.dart';

import '../../product/controllers/product_controller.dart';
import '../../product/pages/product_detail_page.dart';
import '../../../domain/product/entities/product.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ProductController>();

      if (controller.products.isEmpty && !controller.isLoading) {
        controller.getProducts();
      }
    });
  }

  Future<void> _refresh() async {
    final controller = context.read<ProductController>();
    await controller.getProducts();
  }

  Widget _buildBody(ProductController controller) {
    // LOADING inicial
    if (controller.isLoading && controller.products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    // ERRO
    if (controller.error != null && controller.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.getProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
              child: const Text("Tentar novamente"),
            ),
          ],
        ),
      );
    }

    // LISTA DE PRODUTOS
    final List<Product> items = controller.products;

    if (items.isEmpty) {
      return Center(
        child: Text(
          "Nenhum produto disponível.",
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: Colors.green,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[800]),
        itemBuilder: (context, index) {
          final p = items[index];
          return Container(
            color: Colors.grey[900],
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: p.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          p.imageUrl!,
                          width: 56,
                          height: 56,
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
                p.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                p.brand ?? "Sem marca",
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      barcode: p.barcode.value,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              final controller = context.read<ProductController>();
              controller.getProducts();
            },
          )
        ],
      ),
      body: Consumer<ProductController>(
        builder: (_, controller, __) => _buildBody(controller),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProductScannerPage(),
            ),
          );
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }
}