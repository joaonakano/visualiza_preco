import 'package:dartz/dartz.dart';
import '../../domain/core/failures.dart';
import '../../domain/product/entities/product.dart';
import '../../domain/product/repositories/i_product_repository.dart';
import '../../domain/product/value_objects/barcode.dart';

// caso de uso para obter um produto por codigo de barras
class GetProductUseCase {
  // interface dos casos de uso
  final IProductRepository repository;

  GetProductUseCase(this.repository);
  
  Future<Either<ProductFailure, Product>> call(String barcodeStr) async {
    // validando cod de barras
    final barcodeOrFailure = Barcode.create(barcodeStr);
    
    // se der ruim, retorna falha
    // se der bom retorna o produto
    return barcodeOrFailure.fold(
      (failure) => left(ProductFailure('Código de barras inválido')),
      (barcode) => repository.getByBarcode(barcode),
    );
  }
}