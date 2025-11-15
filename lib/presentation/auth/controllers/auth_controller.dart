import 'package:flutter/material.dart';

import '../../../application/auth/register_use_case.dart';
import '../../../application/auth/sign_in_use_case.dart';
import '../../../application/auth/sign_out_use_case.dart';
import '../../../domain/auth/entities/user.dart';

/// Controller/Service para gerenciar autenticação
class AuthController extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final RegisterUseCase _registerUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthController({
    required SignInUseCase signInUseCase,
    required RegisterUseCase registerUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _signInUseCase = signInUseCase,
       _registerUseCase = registerUseCase,
       _signOutUseCase = signOutUseCase;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  /// Faz login
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _signInUseCase.call(email, password);

    result.fold(
      (failure) {
        _error = failure.message;
        _user = null;
      },
      (user) {
        _user = user;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();

    return result.isRight();
  }

  /// Registra novo usuário
  Future<bool> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _registerUseCase.call(
      emailStr: email,
      passwordStr: password,
      displayName: displayName,
    );

    result.fold(
      (failure) {
        _error = failure.message;
        _user = null;
      },
      (user) {
        _user = user;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();

    return result.isRight();
  }

  /// Faz logout
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await _signOutUseCase.call();

    _user = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Define o usuário (usado pelo stream do Firebase)
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  /// Limpa o erro
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
