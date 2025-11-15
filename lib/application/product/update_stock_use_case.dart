import 'package:dartz/dartz.dart';

import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import '../../domain/product/repositories/i_product_repository.dart';
import '../../domain/product/value_objects/barcode.dart';

/// Caso de uso para atualizar a quantidade em estoque de um produto
class UpdateStockUseCase {
  final IProductRepository _repository;

  UpdateStockUseCase(this._repository);

  Future<Either<ProductFailure, Product>> call(
    String barcodeStr,
    int newQuantity,
  ) async {
    // Valida o código de barras
    final barcodeOrFailure = Barcode.create(barcodeStr);

    return barcodeOrFailure.fold(
      // Se o barcode for inválido, retorna erro
      (failure) => left(ProductFailure(failure.message)),
      // Se válido, atualiza o estoque
      (barcode) async {
        // Valida se a quantidade não é negativa
        if (newQuantity < 0) {
          return left(ProductFailure('A quantidade não pode ser negativa'));
        }

        return await _repository.updateStock(barcode, newQuantity);
      },
    );
  }
}
