import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../domain/auth/entities/user.dart' as domain;
import '../../../domain/auth/repositories/i_auth_repository.dart';
import '../../../domain/auth/value_objects/email.dart';
import '../../../domain/auth/value_objects/password.dart';

/// Implementação do repositório de autenticação usando Firebase
class FirebaseAuthRepository implements IAuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<Either<AuthFailure, domain.User>> register({
    required Email email,
    required Password password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (credential.user == null) {
        return left(const AuthFailure('Falha ao criar usuário'));
      }

      // Atualiza o displayName se fornecido
      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }

      final user = _mapFirebaseUserToDomain(credential.user!);
      return right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure(_getErrorMessage(e.code)));
    } catch (e) {
      return left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, domain.User>> signIn({
    required Email email,
    required Password password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (credential.user == null) {
        return left(const AuthFailure('Falha ao fazer login'));
      }

      final user = _mapFirebaseUserToDomain(credential.user!);
      return right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure(_getErrorMessage(e.code)));
    } catch (e) {
      return left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(unit);
    } catch (e) {
      return left(AuthFailure('Erro ao fazer logout: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, domain.User?>> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return right(null);
      }

      final user = _mapFirebaseUserToDomain(firebaseUser);
      return right(user);
    } catch (e) {
      return left(AuthFailure('Erro ao obter usuário: $e'));
    }
  }

  @override
  Stream<domain.User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return _mapFirebaseUserToDomain(firebaseUser);
    });
  }

  /// Mapeia um FirebaseUser para User do domínio
  domain.User _mapFirebaseUserToDomain(firebase.User firebaseUser) {
    final emailOrFailure = Email.create(firebaseUser.email ?? '');

    return emailOrFailure.fold(
      (failure) => throw Exception('Email inválido do Firebase'),
      (email) => domain.User(
        id: firebaseUser.uid,
        email: email,
        displayName: firebaseUser.displayName,
      ),
    );
  }

  /// Retorna mensagens de erro amigáveis
  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este email já está em uso';
      case 'invalid-email':
        return 'Email inválido';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      case 'weak-password':
        return 'Senha muito fraca';
      case 'user-disabled':
        return 'Usuário desabilitado';
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'invalid-credential':
        return 'Credenciais inválidas';
      default:
        return 'Erro de autenticação: $code';
    }
  }
}
