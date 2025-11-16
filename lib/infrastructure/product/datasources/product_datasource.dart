import 'package:flutter_visualizador_de_precos/domain/product/entities/product.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/dto/product_dto.dart';

// interface do datasource (regras ou operacoes disponiveis)
abstract class IProductDatasource {
  Future<Map<String, dynamic>> getProductByBarcode(String barcode);
  Future<List<ProductDto>> getProducts();
}