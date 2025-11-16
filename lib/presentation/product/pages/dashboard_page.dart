import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/product_scanner_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../domain/product/entities/product.dart';
import '../../product/controllers/product_controller.dart';
import '../../product/pages/product_detail_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _barcodeController = TextEditingController();

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

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final controller = context.read<ProductController>();
    await controller.getProducts();
  }

  // Abre o scanner de câmera
  void _openCameraScanner() {
    bool scanProcessing = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (ctx) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              MobileScanner(
                onDetect: (capture) {
                  if (scanProcessing) return;

                  final String? code = capture.barcodes.first.rawValue;
                  if (code != null) {
                    scanProcessing = true;
                    Navigator.of(ctx).pop();
                    _handleBarcode(code);
                  }
                },
              ),
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(ctx).pop(),
                  tooltip: 'Fechar Scanner',
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Aponte para o código de barras',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Abre dialog de busca manual
  void _openManualSearch() {
    _barcodeController.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Buscar Produto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Digite o código de barras:',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Ex: 7894900011517',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final barcode = _barcodeController.text.trim();
              if (barcode.isNotEmpty) {
                Navigator.of(ctx).pop();
                _handleBarcode(barcode);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Buscar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Processa o código de barras escaneado/digitado
  void _handleBarcode(String barcode) async {
    final controller = context.read<ProductController>();
    await controller.getProduct(barcode);

    if (mounted) {
      if (controller.product != null) {
        // Navega para detalhes do produto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(barcode: barcode),
          ),
        );
      } else if (controller.error != null) {
        // Mostra erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(controller.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Colors.grey[800]),
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
                    builder: (_) => ProductDetailPage(barcode: p.barcode.value),
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
        title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
        actions: [
          // Botão de busca manual
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _openManualSearch,
            tooltip: 'Buscar por código',
          ),
          // Botão de refresh
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              final controller = context.read<ProductController>();
              controller.getProducts();
            },
          ),
        ],
      ),
      body: Consumer<ProductController>(
        builder: (_, controller, __) => _buildBody(controller),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Botão para escanear com câmera
          FloatingActionButton(
            heroTag: 'camera_scan',
            onPressed: _openCameraScanner,
            backgroundColor: Colors.green[700],
            child: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          const SizedBox(height: 16),
          // Botão para ir para ProductScannerPage
          FloatingActionButton.extended(
            heroTag: 'scanner_page',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductScannerPage(),
                ),
              );
            },
            backgroundColor: Colors.blue[700],
            icon: const Icon(Icons.list_alt, color: Colors.white),
            label: const Text(
              'Ver Scanner',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
