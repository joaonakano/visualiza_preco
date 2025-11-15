import 'package:dartz/dartz.dart';

import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import '../../domain/product/repositories/i_product_repository.dart';
import '../../domain/product/value_objects/barcode.dart';

/// Caso de uso para atualizar o preço de venda de um produto
class UpdatePriceUseCase {
  final IProductRepository _repository;

  UpdatePriceUseCase(this._repository);

  Future<Either<ProductFailure, Product>> call(
    String barcodeStr,
    double newPrice,
  ) async {
    // Valida o código de barras
    final barcodeOrFailure = Barcode.create(barcodeStr);

    return barcodeOrFailure.fold(
      // Se o barcode for inválido, retorna erro
      (failure) => left(ProductFailure(failure.message)),
      // Se válido, atualiza o preço
      (barcode) async {
        // Valida se o preço é positivo
        if (newPrice < 0) {
          return left(ProductFailure('O preço deve ser maior que zero'));
        }

        return await _repository.updatePrice(barcode, newPrice);
      },
    );
  }
}
