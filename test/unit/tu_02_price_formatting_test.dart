import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/domain/product/entities/product.dart';
import 'package:flutter_visualizador_de_precos/domain/product/value_objects/barcode.dart';

/// TU-02: Teste Unitário - Entidade Product
/// Verifica se a entidade Product funciona corretamente
void main() {
  group('TU-02 - Entidade Product', () {
    test('Deve criar produto com todos os dados', () {
      // Arrange (Preparação)
      final barcode = Barcode.create(
        '7891000100103',
      ).getOrElse(() => throw Error());

      // Act (Execução)
      final product = Product(
        barcode: barcode,
        name: 'Nescau',
        brand: 'Nestlé',
        imageUrl: 'https://example.com/image.png',
        price: 15.50,
        costPrice: 9.00,
        stockQuantity: 150,
      );

      // Assert (Verificação)
      expect(product.name, equals('Nescau'));
      expect(product.brand, equals('Nestlé'));
      expect(product.price, equals(15.50));
      expect(product.costPrice, equals(9.00));
      expect(product.stockQuantity, equals(150));
    });

    test('Deve criar cópia do produto com dados alterados', () {
      // Arrange
      final barcode = Barcode.create(
        '7891000100103',
      ).getOrElse(() => throw Error());
      final product = Product(barcode: barcode, name: 'Coca-Cola', price: 5.00);

      // Act - Cria cópia com preço alterado
      final productAlterado = product.copyWith(price: 6.50);

      // Assert
      expect(productAlterado.name, equals('Coca-Cola')); // Nome igual
      expect(productAlterado.price, equals(6.50)); // Preço alterado
      expect(product.price, equals(5.00)); // Original inalterado
    });
  });
}
