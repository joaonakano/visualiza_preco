import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_card.dart';

/// TW-02: Teste de Widget - Card
/// Verifica se o componente AppCard é renderizado corretamente
void main() {
  group('TW-02 - Widget AppCard', () {
    testWidgets('Deve renderizar card com conteúdo', (
      WidgetTester tester,
    ) async {
      // Arrange (Preparação)
      const String conteudoEsperado = 'Produto: Nescau';

      // Act (Execução) - Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppCard(child: Text(conteudoEsperado))),
        ),
      );

      // Assert (Verificação)
      expect(find.text(conteudoEsperado), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('Deve aplicar elevação customizada', (
      WidgetTester tester,
    ) async {
      // Arrange
      const double elevacaoCustomizada = 10.0;

      // Act - Renderiza
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              elevation: elevacaoCustomizada,
              child: const Text('Teste'),
            ),
          ),
        ),
      );

      // Assert - Verifica se o Card existe
      expect(find.byType(Card), findsOneWidget);

      // Verifica a elevação do Card
      final Card cardWidget = tester.widget(find.byType(Card));
      expect(cardWidget.elevation, equals(elevacaoCustomizada));
    });
  });
}
