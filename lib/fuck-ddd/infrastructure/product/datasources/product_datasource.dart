import 'package:flutter_visualizador_de_precos/fuck-ddd/domain/product/entities/product.dart';

// interface do datasource (regras ou operacoes disponiveis)
abstract class IProductDatasource {
  Future<Map<String, dynamic>> getProductByBarcode(String barcode);
  Future<List<Map<String, dynamic>>> getAllProducts();
}