import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../repositories/product_repository.dart';
import './product/product_detail_screen.dart';

class NewDashBoard extends StatefulWidget {
  const NewDashBoard({super.key});

  @override
  State<NewDashBoard> createState() => _NewDashBoardState();
}

class _NewDashBoardState extends State<NewDashBoard> {
  final ProductRepository _productRepository = ProductRepository();
  bool _isProcessingScan = false;

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

  void _handleBarcode(String code) {
    setState(() {
      _isProcessingScan = true;
    });

    _productRepository
        .getFullProductDetails(code)
        .then((product) {
          setState(() {
            _isProcessingScan = false;
          });

          // Navega para a tela de detalhes do produto escaneado
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        })
        .catchError((error) {
          setState(() {
            _isProcessingScan = false;
          });
          _showErrorDialog("Erro ao buscar produto: $error");
        });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Erro"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(ctx).pop(),
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
            onPressed: () => debugPrint("Search Button Pressed!!"),
            icon: const Icon(Icons.search),
            tooltip: 'Buscar',
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
              ],
            ),
          ),

          if (_isProcessingScan)
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
