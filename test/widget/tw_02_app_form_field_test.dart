import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_form_field.dart';

/// TW-02: Teste de Widget de Campo de Formulário
/// Verifica se o campo de texto é renderizado e valida entrada corretamente
void main() {
  group('TW-02 - Teste de Widget AppFormField', () {
    testWidgets('Deve renderizar campo de texto com label correto', (WidgetTester tester) async {
      // Arrange (Preparação)
      const String labelEsperado = 'E-mail';
      final TextEditingController controller = TextEditingController();

      // Act (Execução) - Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFormField(
              label: labelEsperado,
              controller: controller,
              icon: Icons.email,
            ),
          ),
        ),
      );

      // Assert (Verificação) - Verifica se o label está presente
      expect(find.text(labelEsperado), findsOneWidget);
      
      // Verifica se o ícone está presente
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('Deve aceitar entrada de texto', (WidgetTester tester) async {
      // Arrange
      const String labelCampo = 'Nome';
      const String textoDigitado = 'João Silva';
      final TextEditingController controller = TextEditingController();

      // Act - Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFormField(
              label: labelCampo,
              controller: controller,
              icon: Icons.person,
            ),
          ),
        ),
      );

      // Act - Digite texto no campo
      await tester.enterText(find.byType(TextFormField), textoDigitado);

      // Assert - Verifica se o texto foi inserido corretamente
      expect(controller.text, equals(textoDigitado));
      expect(find.text(textoDigitado), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro na validação', (WidgetTester tester) async {
     
      const String labelCampo = 'E-mail';
      const String mensagemErro = 'Digite um e-mail válido';
      final TextEditingController controller = TextEditingController();
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();

      // Act - Renderiza o widget dentro de um Form
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppFormField(
                label: labelCampo,
                controller: controller,
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return mensagemErro;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      
      formKey.currentState!.validate();
      await tester.pump();

      
      expect(find.text(mensagemErro), findsOneWidget);
    });

    testWidgets('Deve renderizar campo de senha obscurecido', (WidgetTester tester) async {
      
      const String labelCampo = 'Senha';
      final TextEditingController controller = TextEditingController();

      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFormField(
              label: labelCampo,
              controller: controller,
              icon: Icons.lock,
              isPassword: true,
            ),
          ),
        ),
      );

      // Assert - Verifica se o campo foi renderizado
      expect(find.text(labelCampo), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
