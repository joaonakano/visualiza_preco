import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/product_scanner_page.dart';
import 'package:provider/provider.dart';

import 'application/product/get_product_use_case.dart';
import 'application/product/get_products_use_case.dart';
import 'application/product/product_service.dart';
import 'infrastructure/product/datasources/openfoodfacts_datasource.dart';
import 'infrastructure/product/datasources/stock_datasource.dart';
import 'infrastructure/product/repositories/product_repository_impl.dart';
import 'presentation/product/controllers/product_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) {
            final datasource = OpenFoodFactsDatasource();
            final stockDatasource = StockDatasource();
            final repository = ProductRepositoryImpl(
              datasource,
              stockDatasource,
            );
            final getProductUseCase = GetProductUseCase(repository);
            final getProductsUseCase = GetProductsUseCase(repository);
            return ProductService(
              getProductUseCase: getProductUseCase,
              getProductsUseCase: getProductsUseCase,
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProductController(context.read<ProductService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visualizador de Preços',
      home: const ProductScannerPage(),
    );
  }
}
