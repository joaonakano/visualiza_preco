import 'package:dartz/dartz.dart';
import '../../core/failures.dart';

class Barcode {
  final String value;

  // construtor privado para garantir a imutabilidade dos dados
  const Barcode._(this.value);

  // fábrica para criar uma instancia do barcode com uma validação basica
  static Either<ValueFailure, Barcode> create(String input) {
    if (input.isEmpty) {
      return left(const ValueFailure('Código de barras não pode estar vazio'));
    }
    if (!RegExp(r'^\d+$').hasMatch(input)) {
      return left(const ValueFailure('Código de barras deve conter apenas números'));
    }
    return right(Barcode._(input));
  }

  // obter valor do codigo de barras
  @override
  String toString() => value;
}