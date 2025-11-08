import 'package:dartz/dartz.dart';
import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import '../../domain/product/repositories/i_product_repository.dart';

// PRECISA IMPLEMENTAR ISSO DPS!!!!!
// caso de uso para obter todos os produtos
class GetProductsUseCase {
  // interface dos casos de uso
  final IProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<ProductFailure, List<Product>>> call() async {
    return _repository.getAll();
  }
}