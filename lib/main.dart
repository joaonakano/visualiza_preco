import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      title: 'Teste',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCampo = TextEditingController();
  final TextEditingController _senhaCampo = TextEditingController();

  void _login() {
    String email = _emailCampo.text;
    String senha = _senhaCampo.text;

    // validação bem crúa mas funcional
    if (email == 'admin' && senha == '1234') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com Sucesso!!')),
      );
    }
    if (email.isEmpty && senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos e tente novamente.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou Senha incorretos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('LOGIN'),
              const SizedBox(height: 20),

              TextField(
                controller: _emailCampo,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _senhaCampo,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Logar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
