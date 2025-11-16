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
      return const Center(child: CircularProgressIndicator());
    }

    // ERRO
    if (controller.error != null && controller.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.getProducts,
              child: const Text("Tentar novamente"),
            ),
          ],
        ),
      );
    }

    // LISTA DE PRODUTOS
    final List<Product> items = controller.products;

    if (items.isEmpty) {
      return const Center(child: Text("Nenhum produto disponível."));
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final p = items[index];
          return ListTile(
            leading: p.imageUrl != null
                ? Image.network(
                    p.imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(width: 56, height: 56),
            title: Text(p.name),
            subtitle: Text(p.brand ?? ""),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    barcode: p.barcode.value,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
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
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}