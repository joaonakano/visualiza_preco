import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/screens/home_screen.dart';
import 'package:flutter_visualizador_de_precos/shared/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/shared/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/shared/widgets/atoms/app_button.dart';
import 'package:flutter_visualizador_de_precos/shared/widgets/molecules/app_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Formulário Válido!\nNome: ${_nomeController.text}\nEmail: ${_emailController.text}',
          ),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inválido!'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Material(
                color: Colors.transparent,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.veryLightGrey,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      'assets/images/product_1_lemon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('CONSULTA PREÇO', style: TextStyles.title),
              Text(
                'Acesse sua plataforma para consultar os preços.',
                textAlign: TextAlign.center,
                style: TextStyles.subtitle,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.veryLightGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppFormField(
                        label: "Nome Completo",
                        controller: _nomeController,
                        icon: Icons.person,
                        validator: (value) => value == null || value.isEmpty
                            ? "Informe seu nome"
                            : null,
                      ),
                      const SizedBox(height: 20),
                      AppFormField(
                        label: "E-mail",
                        controller: _emailController,
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O e-mail é obrigatório';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Digite um e-mail válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      AppFormField(
                        label: "Senha",
                        controller: _senhaController,
                        icon: Icons.lock,
                        isPassword: _isPasswordObscured,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A senha é obrigatória';
                          }
                          if (value.length < 6) {
                            return 'A senha deve conter ao menos 6 caracteres.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      AppButton(label: "Login", onPressed: _enviarFormulario),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
