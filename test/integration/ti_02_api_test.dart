import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/datasources/openfoodfacts_datasource.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/datasources/stock_datasource.dart';

/// TI-02: Teste de Integração - APIs de Produtos
/// Verifica comunicação com APIs externas e internas
void main() {
  group('TI-02 - APIs de Produtos', () {
    test('Deve buscar produto da OpenFoodFacts', () async {
      // Arrange (Preparação)
      final datasource = OpenFoodFactsDatasource();
      const String codigoBarras = '7891000100103'; // Nescau

      // Act (Execução) - Faz requisição
      final produto = await datasource.getProductByBarcode(codigoBarras);

      // Assert (Verificação)
      expect(produto, isNotEmpty);
      expect(produto, isA<Map<String, dynamic>>());
      expect(
        produto.containsKey('product_name') ||
            produto.containsKey('product_name_pt'),
        isTrue,
      );
    });

    test('Deve buscar produtos do estoque local', () async {
      // Arrange
      final stockDatasource = StockDatasource();

      // Act - Busca estoque
      final produtos = await stockDatasource.getAllStock();

      // Assert - Verifica dados retornados
      expect(produtos, isA<List<Map<String, dynamic>>>());
      expect(produtos.length, greaterThan(0));

      // Verifica estrutura do produto
      final produto = produtos.first;
      expect(produto.containsKey('barcode'), isTrue);
      expect(produto.containsKey('price'), isTrue);
      expect(produto.containsKey('costPrice'), isTrue);
      expect(produto.containsKey('stockQuantity'), isTrue);

      // Verifica tipos
      expect(produto['barcode'], isA<String>());
      expect(produto['price'], isA<num>());
      expect(produto['costPrice'], isA<num>());
      expect(produto['stockQuantity'], isA<int>());
    });
  });
}
