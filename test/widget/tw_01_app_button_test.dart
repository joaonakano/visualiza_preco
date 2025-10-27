import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_button.dart';

/// TW-01: Teste de Widget de Botão
/// Verifica se o botão é renderizado corretamente e responde a cliques
void main() {
  group('TW-01 - Teste de Widget AppButton', () {
    testWidgets('Deve renderizar botão com o texto correto', (WidgetTester tester) async {
      // Arrange (Preparação)
      const String textoEsperado = 'Clique Aqui';
      bool foiClicado = false;

      // Act (Execução) - Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: textoEsperado,
              onPressed: () {
                foiClicado = true;
              },
            ),
          ),
        ),
      );

      // Assert (Verificação) - Verifica se o texto está presente
      expect(find.text(textoEsperado), findsOneWidget);
      
      // Verifica se ainda não foi clicado
      expect(foiClicado, isFalse);
    });

    testWidgets('Deve executar callback ao clicar no botão', (WidgetTester tester) async {
      
      const String textoBotao = 'Login';
      bool foiClicado = false;

      // Act - Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: textoBotao,
              onPressed: () {
                foiClicado = true;
              },
            ),
          ),
        ),
      );

      
      await tester.tap(find.text(textoBotao));
      await tester.pump();

      
      expect(foiClicado, isTrue);
    });

    testWidgets('Deve encontrar widget do tipo ElevatedButton', (WidgetTester tester) async {
     
      const String textoBotao = 'Enviar';

      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: textoBotao,
              onPressed: () {},
            ),
          ),
        ),
      );

      
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
