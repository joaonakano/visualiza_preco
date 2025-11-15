import 'package:dartz/dartz.dart';
import '../../domain/auth/entities/user.dart';
import '../../domain/auth/repositories/i_auth_repository.dart';
import '../../domain/auth/value_objects/email.dart';
import '../../domain/auth/value_objects/password.dart';

/// Use Case para registrar novo usuário
class RegisterUseCase {
  final IAuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<AuthFailure, User>> call({
    required String emailStr,
    required String passwordStr,
    String? displayName,
  }) async {
    // Valida email
    final emailOrFailure = Email.create(emailStr);
    if (emailOrFailure.isLeft()) {
      return left(const AuthFailure('Email inválido'));
    }

    // Valida password
    final passwordOrFailure = Password.create(passwordStr);
    if (passwordOrFailure.isLeft()) {
      return left(const AuthFailure('Senha inválida'));
    }

    final email = emailOrFailure.getOrElse(() => throw Error());
    final password = passwordOrFailure.getOrElse(() => throw Error());

    return _repository.register(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
