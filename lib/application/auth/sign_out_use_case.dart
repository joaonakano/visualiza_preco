import 'package:dartz/dartz.dart';
import '../../domain/auth/repositories/i_auth_repository.dart';

/// Use Case para fazer logout
class SignOutUseCase {
  final IAuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return _repository.signOut();
  }
}
