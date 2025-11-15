import 'package:dartz/dartz.dart';
import '../../domain/auth/entities/user.dart';
import '../../domain/auth/repositories/i_auth_repository.dart';
import '../../domain/auth/value_objects/email.dart';
import '../../domain/auth/value_objects/password.dart';

/// Use Case para fazer login
class SignInUseCase {
  final IAuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<AuthFailure, User>> call(String emailStr, String passwordStr) async {
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

    return _repository.signIn(email: email, password: password);
  }
}
