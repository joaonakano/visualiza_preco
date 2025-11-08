import 'package:dartz/dartz.dart';
import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import './get_product_use_case.dart';
import './get_products_use_case.dart';

// servico que facilita a chamada dos caso de uso
class ProductService {
  final GetProductUseCase _getProductUseCase;
  final GetProductsUseCase _getProductsUseCase;

  // fazendo a inicializacao das variaveis de forma um pouco diferente
  ProductService({
    required GetProductUseCase getProductUseCase,
    required GetProductsUseCase getProductsUseCase,
  }) : _getProductUseCase = getProductUseCase,
        _getProductsUseCase = getProductsUseCase;

  // metodo para obter um produto
  Future<Either<ProductFailure, Product>> getProduct(String barcode) {
    return _getProductUseCase.call(barcode);
  }

  // PRECISA IMPLEMENTAR!!!!!!!!!
  // metodo para obter varios produtos  
  Future<Either<ProductFailure, List<Product>>> getProducts() {
    return _getProductsUseCase.call();
  }
}