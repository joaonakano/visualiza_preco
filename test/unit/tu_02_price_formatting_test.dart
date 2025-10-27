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
      
      const double valor = 49.99;
      const String formatoEsperado = 'R\$ 49,99';

   
      final String resultado = PriceCalculator.formatPrice(valor);

     
      expect(resultado, equals(formatoEsperado));
    });

    test('Deve formatar valores pequenos corretamente', () {
     
      const double valor = 0.50;
      const String formatoEsperado = 'R\$ 0,50';

     
      final String resultado = PriceCalculator.formatPrice(valor);

    
      expect(resultado, equals(formatoEsperado));
    });

    test('Deve calcular total de lista de preços vazia como zero', () {
    
      final List<double> precos = [];
      const double totalEsperado = 0.0;

   
      final double resultado = PriceCalculator.calculateTotal(precos);

 
      expect(resultado, equals(totalEsperado));
    });

    test('Deve calcular total de múltiplos preços corretamente', () {
    
      final List<double> precos = [10.0, 20.0, 30.0];
      const double totalEsperado = 60.0;

      
      final double resultado = PriceCalculator.calculateTotal(precos);

     
      expect(resultado, equals(totalEsperado));
    });
  });
}
