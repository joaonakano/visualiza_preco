import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/presentation/product/pages/product_scanner_page.dart';
import 'package:provider/provider.dart';

import 'application/auth/register_use_case.dart';
import 'application/auth/sign_in_use_case.dart';
import 'application/auth/sign_out_use_case.dart';
import 'application/product/get_product_use_case.dart';
import 'application/product/get_products_use_case.dart';
import 'application/product/product_service.dart';
import 'application/product/update_price_use_case.dart';
import 'application/product/update_stock_use_case.dart';
import 'firebase_options.dart';
import 'infrastructure/auth/repositories/firebase_auth_repository.dart';
import 'infrastructure/product/datasources/openfoodfacts_datasource.dart';
import 'infrastructure/product/datasources/stock_datasource.dart';
import 'infrastructure/product/repositories/product_repository_impl.dart';
import 'presentation/auth/controllers/auth_controller.dart';
import 'presentation/auth/pages/auth_page.dart';
import 'presentation/product/controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // Product Provider
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
            final updatePriceUseCase = UpdatePriceUseCase(repository);
            final updateStockUseCase = UpdateStockUseCase(repository);
            
            return ProductService(
              getProductUseCase: getProductUseCase,
              getProductsUseCase: getProductsUseCase,
              updatePriceUseCase: updatePriceUseCase,
              updateStockUseCase: updateStockUseCase,
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProductController(context.read<ProductService>()),
        ),

        // Auth Provider
        ChangeNotifierProvider(
          create: (context) {
            final firebaseAuth = firebase_auth.FirebaseAuth.instance;
            final authRepository = FirebaseAuthRepository(firebaseAuth);
            final signInUseCase = SignInUseCase(authRepository);
            final registerUseCase = RegisterUseCase(authRepository);
            final signOutUseCase = SignOutUseCase(authRepository);

            return AuthController(
              signInUseCase: signInUseCase,
              registerUseCase: registerUseCase,
              signOutUseCase: signOutUseCase,
            );
          },
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
      home: Consumer<AuthController>(
        builder: (context, authController, _) {
          // Se estiver autenticado, vai para o scanner
          if (authController.isAuthenticated) {
            return const ProductScannerPage();
          }
          // Senão, vai para a tela de login
          return const AuthPage();
        },
      ),
    );
  }
}
