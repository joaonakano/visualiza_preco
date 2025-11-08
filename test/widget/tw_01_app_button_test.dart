import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/atoms/app_button.dart';

/// TW-01: Teste de Widget - Botao
/// Verifica se o botao e renderizado e responde a cliques
void main() {
  group('TW-01 - Widget AppButton', () {
    testWidgets('Deve renderizar botão com texto correto', (WidgetTester tester) async {
      // Arrange (Preparacao)
      const String textoEsperado = 'Buscar Produto';
      bool foiClicado = false;

      // Act (Execuçao) - Renderiza o widget
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

      // Assert (Verificaçao)
      expect(find.text(textoEsperado), findsOneWidget);
      expect(foiClicado, isFalse);
    });

    testWidgets('Deve executar callback ao clicar', (WidgetTester tester) async {
      // Arrange
      const String textoBotao = 'Escanear';
      bool foiClicado = false;

      // Act - Renderiza
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

      // Act - Clica no botao
      await tester.tap(find.text(textoBotao));
      await tester.pump();

      // Assert
      expect(foiClicado, isTrue);
    });
  });
}

