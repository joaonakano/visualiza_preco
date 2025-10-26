import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/utils/price_calculator.dart';

/// TU-01: Teste de cálculo de desconto em preço
/// Verifica se o cálculo de desconto está correto
void main() {
  group('TU-01 - Teste de Cálculo de Desconto', () {
    test('Deve calcular desconto de 10% corretamente', () {
      // Arrange (Preparação)
      const double precoOriginal = 100.0;
      const double percentualDesconto = 10.0;
      const double precoEsperado = 90.0;

      // Act (Execução)
      final double resultado = PriceCalculator.calculateDiscount(
        precoOriginal,
        percentualDesconto,
      );

      // Assert (Verificação)
      expect(resultado, equals(precoEsperado));
    });

    test('Deve calcular desconto de 50% corretamente', () {
      // Arrange
      const double precoOriginal = 200.0;
      const double percentualDesconto = 50.0;
      const double precoEsperado = 100.0;

      // Act
      final double resultado = PriceCalculator.calculateDiscount(
        precoOriginal,
        percentualDesconto,
      );

      // Assert
      expect(resultado, equals(precoEsperado));
    });

    test('Deve lançar exceção para preço negativo', () {
      // Arrange
      const double precoOriginal = -10.0;
      const double percentualDesconto = 10.0;

      // Act & Assert
      expect(
        () => PriceCalculator.calculateDiscount(
          precoOriginal,
          percentualDesconto,
        ),
        throwsArgumentError,
      );
    });

    test('Deve lançar exceção para desconto maior que 100%', () {
      // Arrange
      const double precoOriginal = 100.0;
      const double percentualDesconto = 150.0;

      // Act & Assert
      expect(
        () => PriceCalculator.calculateDiscount(
          precoOriginal,
          percentualDesconto,
        ),
        throwsArgumentError,
      );
    });
  });
}
