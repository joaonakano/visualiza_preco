import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  bool _isProcessing = false;

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  void _startScan() {
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
            ],
          ),
        );
      },
    );
  }

  void _showManualInputDialog() {
    _barcodeController.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        title: Text(
          'Buscar Produto',
          style: TextStyles.title.copyWith(
            color: AppColors.textDark,
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
              style: TextStyles.label.copyWith(
                color: AppColors.textDark.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: TextStyles.label.copyWith(
                color: AppColors.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Ex: 7894900011517',
                hintStyle: TextStyles.label.copyWith(
                  color: AppColors.textDark.withOpacity(0.4),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 2,
                  ),
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
              style: TextStyles.label.copyWith(
                color: AppColors.textDark.withOpacity(0.6),
                fontSize: 16,
              ),
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
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: Text(
              'Buscar',
              style: TextStyles.label.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBarcode(String barcode) {
    setState(() {
      _isProcessing = true;
    });

    final controller = context.read<ProductController>();
    controller.getProduct(barcode).then((_) {
      setState(() {
        _isProcessing = false;
      });

      if (controller.error != null) {
        _showErrorDialog("Erro ao buscar produto: ${controller.error}");
      } else if (controller.product != null) {
        // Navega para a tela de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(barcode: barcode),
          ),
        );
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        title: Text(
          "Erro",
          style: TextStyles.title.copyWith(
            color: AppColors.error,
            fontSize: 20,
          ),
        ),
        content: Text(
          message,
          style: TextStyles.label.copyWith(
            color: AppColors.textDark,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              "OK",
              style: TextStyles.label.copyWith(
                color: AppColors.primaryBlue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'Visualizador de Preços',
        actions: [
          IconButton(
            onPressed: _showManualInputDialog,
            icon: const Icon(Icons.search),
            tooltip: 'Buscar por código',
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  size: 120,
                  color: AppColors.backgroundLight.withOpacity(0.3),
                ),
                const SizedBox(height: 24),
                Text(
                  'Escaneie um Produto',
                  style: TextStyles.title.copyWith(
                    color: AppColors.backgroundLight,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Toque no botão abaixo para\nescanear o código de barras',
                  textAlign: TextAlign.center,
                  style: TextStyles.label.copyWith(
                    color: AppColors.backgroundLight.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _showManualInputDialog,
                  icon: const Icon(Icons.keyboard),
                  label: const Text('Ou digite o código'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.backgroundLight,
                    side: BorderSide(
                      color: AppColors.backgroundLight.withOpacity(0.5),
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.backgroundLight,
                  strokeWidth: 6,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startScan,
        tooltip: 'Escanear Produto',
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.backgroundDark,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
