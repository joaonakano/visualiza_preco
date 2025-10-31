//aqui vai juntar tudo que criei

import '../models/product_model.dart';
import '../models/product_off_model.dart';
import '../services/OpenFoodFacts_service.dart';
import '../services/stock_service.dart';

class ProductRepository {
  final OpenfoodfactsService _offService = OpenfoodfactsService();
  final StockService _stockService = StockService();

  Future<Product> getFullProductDetails(String barcode) async{
    late ProductOFF offData;
    Map<String, dynamic>? storeData;

    try {
      offData = await _offService.fetchProduct(barcode);
    } catch (e) {
      offData = ProductOFF(barcode: barcode, name: "Produto não encontrado", brand: null, imageUrl: null);
      print("Erro ao buscar na API: $e");
    }

    try {
      storeData = await _stockService.fetchStoreDetails(barcode);

    } catch (e) {
      storeData = null;
      print("Erro ao buscar no Estoque: $e");
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