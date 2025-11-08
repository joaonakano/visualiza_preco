import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/main.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/product_scanner_page.dart';

/// TI-01: Teste de Integração - Navegação do App
/// Verifica se a navegação principal funciona corretamente
void main() {
  group('TI-01 - Navegação do Aplicativo', () {
    testWidgets('Deve iniciar app na tela de scanner', (
      WidgetTester tester,
    ) async {
      // Arrange & Act (Preparação e Execução)
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Assert - Verifica tela inicial
      expect(find.byType(ProductScannerPage), findsOneWidget);
      expect(find.text('Escaneie um Produto'), findsOneWidget);
      expect(find.text('Ou digite o código'), findsOneWidget);
    });

    testWidgets('Deve abrir dialog de busca manual', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Clica no botão de busca manual
      await tester.tap(find.text('Ou digite o código'));
      await tester.pumpAndSettle();

      // Assert - Verifica dialog aberto
      expect(find.text('Buscar Produto'), findsOneWidget);
      expect(find.text('Digite o código de barras:'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
