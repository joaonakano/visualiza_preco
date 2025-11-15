import 'package:dartz/dartz.dart';
import '../../core/failures.dart';

/// Value Object para Email
class Email {
  final String value;

  const Email._(this.value);

  /// Factory para criar Email com validação
  static Either<ValueFailure, Email> create(String input) {
    if (input.isEmpty) {
      return left(const ValueFailure('Email não pode estar vazio'));
    }
    
    // Regex básico para validar email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return left(const ValueFailure('Email inválido'));
    }
    
    return right(Email._(input));
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Email && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
