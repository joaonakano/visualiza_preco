import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/application/product/get_product_use_case.dart';
import 'package:flutter_visualizador_de_precos/application/product/get_products_use_case.dart';
import 'package:flutter_visualizador_de_precos/application/product/product_service.dart';
import 'package:flutter_visualizador_de_precos/application/product/update_price_use_case.dart';
import 'package:flutter_visualizador_de_precos/application/product/update_stock_use_case.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/datasources/openfoodfacts_datasource.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/datasources/stock_datasource.dart';
import 'package:flutter_visualizador_de_precos/infrastructure/product/repositories/product_repository_impl.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/controllers/product_controller.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/dashboard_page.dart';
import 'package:provider/provider.dart';

/// TI-01: Teste de Integração - Navegação do App
/// Verifica se a navegação principal funciona corretamente
void main() {
  group('TI-01 - Navegação do Aplicativo', () {
    testWidgets('Deve iniciar app na dashboard', (
      WidgetTester tester,
    ) async {
      // Arrange - Cria app de teste sem autenticação
      final datasource = OpenFoodFactsDatasource();
      final stockDatasource = StockDatasource();
      final repository = ProductRepositoryImpl(datasource, stockDatasource);
      final getProductUseCase = GetProductUseCase(repository);
      final getProductsUseCase = GetProductsUseCase(repository);
      final updatePriceUseCase = UpdatePriceUseCase(repository);
      final updateStockUseCase = UpdateStockUseCase(repository);
      
      final productService = ProductService(
        getProductUseCase: getProductUseCase,
        getProductsUseCase: getProductsUseCase,
        updatePriceUseCase: updatePriceUseCase,
        updateStockUseCase: updateStockUseCase,
      );

      // Act (Execução)
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider.value(value: productService),
            ChangeNotifierProvider(
              create: (_) => ProductController(productService),
            ),
          ],
          child: const MaterialApp(
            home: DashboardPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Verifica tela inicial
      expect(find.byType(DashboardPage), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Deve navegar para scanner ao clicar no FAB', (
      WidgetTester tester,
    ) async {
      // Arrange
      final datasource = OpenFoodFactsDatasource();
      final stockDatasource = StockDatasource();
      final repository = ProductRepositoryImpl(datasource, stockDatasource);
      final getProductUseCase = GetProductUseCase(repository);
      final getProductsUseCase = GetProductsUseCase(repository);
      final updatePriceUseCase = UpdatePriceUseCase(repository);
      final updateStockUseCase = UpdateStockUseCase(repository);
      
      final productService = ProductService(
        getProductUseCase: getProductUseCase,
        getProductsUseCase: getProductsUseCase,
        updatePriceUseCase: updatePriceUseCase,
        updateStockUseCase: updateStockUseCase,
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider.value(value: productService),
            ChangeNotifierProvider(
              create: (_) => ProductController(productService),
            ),
          ],
          child: const MaterialApp(
            home: DashboardPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Clica no FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Assert - Verifica que navegou para scanner
      expect(find.text('Dashboard - Produtos'), findsOneWidget);
    });
  });
}
