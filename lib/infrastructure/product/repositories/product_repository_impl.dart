import 'package:dartz/dartz.dart';
import 'package:flutter_visualizador_de_precos/domain/core/failures.dart';
import 'package:flutter_visualizador_de_precos/domain/product/entities/product.dart';
import 'package:flutter_visualizador_de_precos/domain/product/repositories/i_product_repository.dart';
import 'package:flutter_visualizador_de_precos/domain/product/value_objects/barcode.dart';

import '../datasources/product_datasource.dart';
import '../datasources/stock_datasource.dart';

// implementação da interface do repositorio
// aqui vai juntar os dados da API (OpenFoodFacts) com os dados locais (Stock)
class ProductRepositoryImpl implements IProductRepository {
  final IProductDatasource _datasource;
  final StockDatasource _stockDatasource;

  ProductRepositoryImpl(this._datasource, this._stockDatasource);

  // fetch de produto por codigo de barras
  @override
  Future<Either<ProductFailure, Product>> getByBarcode(Barcode barcode) async {
    late Map<String, dynamic> productData;
    Map<String, dynamic>? storeData;

    // primeiro tenta validar se é possivel pegar os dados da api
    try {
      productData = await _datasource.getProductByBarcode(barcode.value);
      print(" Dados OFF encontrados: ${productData['product_name']}");
    } catch (e) {
      print(" Erro ao buscar na API: $e");
      return left(ProductFailure(e.toString()));
    }

    // depois busca os dados de estoque local (preço, custo, quantidade)
    try {
      storeData = await _stockDatasource.getStockByBarcode(barcode.value);
      if (storeData != null) {
        print(" Dados de estoque encontrados: $storeData");
      } else {
        print(" Produto não encontrado no banco de dados local");
      }
    } catch (e) {
      storeData = null;
      print(" Erro ao buscar no Estoque: $e");
    }

    // retorna o produto com todos os dados combinados
    return right(
      Product(
        barcode: barcode,
        name: productData['product_name'] ?? 'Nome não informado',
        brand: productData['brands'],
        imageUrl: productData['image_url'],
        price: storeData?['price'],
        costPrice: storeData?['costPrice'],
        stockQuantity: storeData?['stockQuantity'],
      ),
    );
  }

  // fetch de todos os produtos
  @override
  Future<Either<ProductFailure, List<Product>>> getAll() async {
    try {
      final productsData = await _datasource.getAllProducts();
      final products = productsData.map((data) {
        final barcodeOrFailure = Barcode.create(
          data['code'] ?? '',
        ); // cria o codigo de barras com validação
        return barcodeOrFailure.fold(
          (failure) => throw Exception(
            failure.message,
          ), // se falhar, retorna uma mensagem de erro
          (barcode) => Product(
            // se der certo, cria uma instancia do produto
            barcode: barcode,
            name: data['product_name'] ?? 'Nome não informado',
            brand: data['brands'],
            imageUrl: data['image_url'],
            price: null,
            costPrice: null,
            stockQuantity: null,
          ),
        );
      }).toList();

      // retorna toda a lista de produtos
      return right(products);
    } catch (e) {
      // retorna uma falha se nao conseguir
      return left(ProductFailure(e.toString()));
    }
  }

  // Atualiza o preço de venda de um produto
  @override
  Future<Either<ProductFailure, Product>> updatePrice(
    Barcode barcode,
    double newPrice,
  ) async {
    try {
      // Atualiza o preço no datasource local
      final success = await _stockDatasource.updatePrice(
        barcode.value,
        newPrice,
      );

      if (!success) {
        return left(
          ProductFailure('Produto não encontrado no estoque'),
        );
      }

      // Busca o produto atualizado
      return await getByBarcode(barcode);
    } catch (e) {
      return left(ProductFailure(e.toString()));
    }
  }

  // Atualiza a quantidade em estoque de um produto
  @override
  Future<Either<ProductFailure, Product>> updateStock(
    Barcode barcode,
    int newQuantity,
  ) async {
    try {
      // Atualiza o estoque no datasource local
      final success = await _stockDatasource.updateStock(
        barcode.value,
        newQuantity,
      );

      if (!success) {
        return left(
          ProductFailure('Produto não encontrado no estoque'),
        );
      }

      // Busca o produto atualizado
      return await getByBarcode(barcode);
    } catch (e) {
      return left(ProductFailure(e.toString()));
    }
  }
}
