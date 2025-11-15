import 'package:dartz/dartz.dart';
import '../../core/failures.dart';

/// Value Object para Password
class Password {
  final String value;

  const Password._(this.value);

  /// Factory para criar Password com validação
  static Either<ValueFailure, Password> create(String input) {
    if (input.isEmpty) {
      return left(const ValueFailure('Senha não pode estar vazia'));
    }
    
    if (input.length < 6) {
      return left(const ValueFailure('Senha deve ter no mínimo 6 caracteres'));
    }
    
    return right(Password._(input));
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Password &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
