import 'package:dartz/dartz.dart';
import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import './get_product_use_case.dart';
import './get_products_use_case.dart';
import './update_price_use_case.dart';
import './update_stock_use_case.dart';

// servico que facilita a chamada dos caso de uso
class ProductService {
  final GetProductUseCase _getProductUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final UpdatePriceUseCase _updatePriceUseCase;
  final UpdateStockUseCase _updateStockUseCase;

  // fazendo a inicializacao das variaveis de forma um pouco diferente
  ProductService({
    required GetProductUseCase getProductUseCase,
    required GetProductsUseCase getProductsUseCase,
    required UpdatePriceUseCase updatePriceUseCase,
    required UpdateStockUseCase updateStockUseCase,
  })  : _getProductUseCase = getProductUseCase,
        _getProductsUseCase = getProductsUseCase,
        _updatePriceUseCase = updatePriceUseCase,
        _updateStockUseCase = updateStockUseCase;

  // metodo para obter um produto
  Future<Either<ProductFailure, Product>> getProduct(String barcode) {
    return _getProductUseCase.call(barcode);
  }

  // PRECISA IMPLEMENTAR!!!!!!!!!
  // metodo para obter varios produtos  
  Future<Either<ProductFailure, List<Product>>> getProducts() {
    return _getProductsUseCase.call();
  }

  // metodo para atualizar o preço de venda
  Future<Either<ProductFailure, Product>> updatePrice(
    String barcode,
    double newPrice,
  ) {
    return _updatePriceUseCase.call(barcode, newPrice);
  }

  // metodo para atualizar a quantidade em estoque
  Future<Either<ProductFailure, Product>> updateStock(
    String barcode,
    int newQuantity,
  ) {
    return _updateStockUseCase.call(barcode, newQuantity);
  }
}