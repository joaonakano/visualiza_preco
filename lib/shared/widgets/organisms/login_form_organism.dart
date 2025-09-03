import 'package:flutter/material.dart';
import '../../widgets/atoms/app_button.dart';
import '../../widgets/molecules/app_form_field.dart';

class LoginFormOrganism extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginFormOrganism({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  _LoginFormOrganismState createState() => _LoginFormOrganismState();
}

class _LoginFormOrganismState extends State<LoginFormOrganism> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Nome Completo",
            controller: widget.nameController,
            icon: Icons.person,
          ),
          const SizedBox(height: 20),
          AppFormField(
            label: "E-mail",
            controller: widget.emailController,
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
            controller: widget.passwordController,
            icon: Icons.lock,
            isPassword: isPasswordObscured,
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
          AppButton(label: "Login", onPressed: widget.onSubmit),
        ],
      ),
    );
  }
}
