import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/domain/product/value_objects/barcode.dart';

/// TU-01: Teste Unitário - Validação de Código de Barras
/// Verifica se a validação de barcode funciona corretamente
void main() {
  group('TU-01 - Validação de Barcode', () {
    test('Deve criar barcode válido com números', () {
      // Arrange (Preparação)
      const String codigoValido = '7891000100103';

      // Act (Execução)
      final resultado = Barcode.create(codigoValido);

      // Assert (Verificação)
      resultado.fold(
        (failure) => fail('Não deveria falhar com código válido'),
        (barcode) {
          expect(barcode.value, equals(codigoValido));
          expect(barcode.toString(), equals(codigoValido));
        },
      );
    });

    test('Deve rejeitar barcode vazio', () {
      // Arrange
      const String codigoVazio = '';

      // Act
      final resultado = Barcode.create(codigoVazio);

      // Assert
      resultado.fold((failure) {
        expect(failure.message, contains('não pode estar vazio'));
      }, (barcode) => fail('Deveria ter falhado com código vazio'));
    });
  });
}
