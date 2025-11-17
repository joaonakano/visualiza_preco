import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_button.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/dashboard_page.dart';

import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

/// Tela de Login e Registro
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  bool _isLogin = true; // true = login, false = registro
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = context.read<AuthController>();

    bool success;
    if (_isLogin) {
      success = await authController.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } else {
      success = await authController.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
      );
    }

    if (success && mounted) {
      // Navega para a tela principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo ou título
                Icon(
                  Icons.shopping_cart,
                  size: 80,
                  color: AppColors.backgroundLight,
                ),
                const SizedBox(height: 24),
                Text(
                  'Visualizador de Preços',
                  style: TextStyles.title.copyWith(
                    color: AppColors.backgroundLight,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 48),

                // Formulário
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de Nome (apenas no registro)
                      if (!_isLogin) ...[
                        TextFormField(
                          controller: _displayNameController,
                          decoration: InputDecoration(
                            labelText: 'Nome (opcional)',
                            labelStyle: TextStyle(
                              color: AppColors.backgroundLight,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.backgroundLight,
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundLight.withOpacity(
                              0.1,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.backgroundLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.backgroundLight.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primaryBlue,
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(color: AppColors.backgroundLight),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Campo de Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: AppColors.backgroundLight,
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.backgroundLight,
                          ),
                          filled: true,
                          fillColor: AppColors.backgroundLight.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.backgroundLight,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.backgroundLight.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryBlue,
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(color: AppColors.backgroundLight),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu email';
                          }
                          if (!value.contains('@')) {
                            return 'Email inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo de Senha
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            color: AppColors.backgroundLight,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.backgroundLight,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.backgroundLight,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: AppColors.backgroundLight.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.backgroundLight,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.backgroundLight.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryBlue,
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(color: AppColors.backgroundLight),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite sua senha';
                          }
                          if (value.length < 6) {
                            return 'Senha deve ter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Mensagem de erro
                      Consumer<AuthController>(
                        builder: (context, authController, _) {
                          if (authController.error != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                authController.error!,
                                style: TextStyles.label.copyWith(
                                  color: AppColors.error,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      // Botão de Login/Registro
                      Consumer<AuthController>(
                        builder: (context, authController, _) {
                          if (authController.isLoading) {
                            return const CircularProgressIndicator(
                              color: AppColors.primaryBlue,
                            );
                          }

                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: AppButton(
                              label: _isLogin ? 'Entrar' : 'Registrar',
                              onPressed: _submit,
                              backgroundColor: AppColors.primaryBlue,
                              textColor: Colors.white,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Alternar entre Login e Registro
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                            context.read<AuthController>().clearError();
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Não tem conta? Registre-se'
                              : 'Já tem conta? Faça login',
                          style: TextStyles.label.copyWith(
                            color: AppColors.backgroundLight,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
