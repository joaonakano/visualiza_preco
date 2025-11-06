//aqui vai juntar tudo que criei

import '../models/product_model.dart';
import '../models/product_off_model.dart';
import '../services/OpenFoodFacts_service.dart';
import '../services/stock_service.dart';

class ProductRepository {
  final OpenfoodfactsService _offService = OpenfoodfactsService();
  final StockService _stockService = StockService();

  Future<Product> getFullProductDetails(String barcode) async {
    print(
      "🔍 BARCODE LIDO: $barcode",
    ); // Debug: ver qual código está sendo escaneado
    late ProductOFF offData;
    Map<String, dynamic>? storeData;

    try {
      offData = await _offService.fetchProduct(barcode);
      print(" Dados OFF encontrados: ${offData.name}");
    } catch (e) {
      offData = ProductOFF(
        barcode: barcode,
        name: "Produto não encontrado",
        brand: null,
        imageUrl: null,
      );
      print(" Erro ao buscar na API: $e");
    }

    try {
      storeData = await _stockService.fetchStoreDetails(barcode);
      if (storeData != null) {
        print(" Dados de estoque encontrados: $storeData");
      } else {
        print(" Produto não encontrado no banco de dados local");
      }
    } catch (e) {
      storeData = null;
      print(" Erro ao buscar no Estoque: $e");
    }

    return Product(
      barcode: barcode,
      name: offData.name,
      brand: offData.brand,
      imageUrl: offData.imageUrl,
      price: storeData?['price'],
      costPrice: storeData?['costPrice'],
      stockQuantity: storeData?['stockQuantity'],
    );
  }
}
