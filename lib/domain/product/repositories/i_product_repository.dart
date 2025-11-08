import 'package:dartz/dartz.dart';
import '../../core/failures.dart';
import '../entities/product.dart';
import '../value_objects/barcode.dart';

// repositorio que armazena as operações disponiveis para produtos
abstract class IProductRepository {
  Future<Either<ProductFailure, Product>> getByBarcode(Barcode barcode);    // future = operacao assincrona, either = pode ter dois tipos de dados falha(erro) ou sucesso(produto) / vem do dartz
  Future<Either<ProductFailure, List<Product>>> getAll();
}