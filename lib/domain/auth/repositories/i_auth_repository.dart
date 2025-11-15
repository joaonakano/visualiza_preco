import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/user.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

/// Failure específico para autenticação
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Interface do repositório de autenticação
abstract class IAuthRepository {
  /// Registra um novo usuário
  Future<Either<AuthFailure, User>> register({
    required Email email,
    required Password password,
    String? displayName,
  });

  /// Faz login com email e senha
  Future<Either<AuthFailure, User>> signIn({
    required Email email,
    required Password password,
  });

  /// Faz logout
  Future<Either<AuthFailure, Unit>> signOut();

  /// Obtém o usuário atual (se houver)
  Future<Either<AuthFailure, User?>> getCurrentUser();

  /// Stream para observar mudanças no estado de autenticação
  Stream<User?> get authStateChanges;
}
