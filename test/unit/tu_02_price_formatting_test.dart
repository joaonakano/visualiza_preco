import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/utils/price_calculator.dart';

/// TU-02: Teste de formatação de preço
/// Verifica se a formatação de valores monetários está correta
void main() {
  group('TU-02 - Teste de Formatação de Preço', () {
    test('Deve formatar preço inteiro corretamente', () {
      // Arrange (Preparação)
      const double valor = 100.0;
      const String formatoEsperado = 'R\$ 100,00';

      // Act (Execução)
      final String resultado = PriceCalculator.formatPrice(valor);

      // Assert (Verificação)
      expect(resultado, equals(formatoEsperado));
    });

    test('Deve formatar preço com centavos corretamente', () {
      // Arrange
      const double valor = 49.99;
      const String formatoEsperado = 'R\$ 49,99';

      // Act
      final String resultado = PriceCalculator.formatPrice(valor);

      // Assert
      expect(resultado, equals(formatoEsperado));
    });

    test('Deve formatar valores pequenos corretamente', () {
      // Arrange
      const double valor = 0.50;
      const String formatoEsperado = 'R\$ 0,50';

      // Act
      final String resultado = PriceCalculator.formatPrice(valor);

      // Assert
      expect(resultado, equals(formatoEsperado));
    });

    test('Deve calcular total de lista de preços vazia como zero', () {
      // Arrange
      final List<double> precos = [];
      const double totalEsperado = 0.0;

      // Act
      final double resultado = PriceCalculator.calculateTotal(precos);

      // Assert
      expect(resultado, equals(totalEsperado));
    });

    test('Deve calcular total de múltiplos preços corretamente', () {
      // Arrange
      final List<double> precos = [10.0, 20.0, 30.0];
      const double totalEsperado = 60.0;

      // Act
      final double resultado = PriceCalculator.calculateTotal(precos);

      // Assert
      expect(resultado, equals(totalEsperado));
    });
  });
}
