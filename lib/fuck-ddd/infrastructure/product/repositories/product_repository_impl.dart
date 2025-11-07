import 'package:dartz/dartz.dart';
import 'package:flutter_visualizador_de_precos/fuck-ddd/domain/core/failures.dart';
import 'package:flutter_visualizador_de_precos/fuck-ddd/domain/product/entities/product.dart';
import 'package:flutter_visualizador_de_precos/fuck-ddd/domain/product/repositories/i_product_repository.dart';
import 'package:flutter_visualizador_de_precos/fuck-ddd/domain/product/value_objects/barcode.dart';
import '../datasources/product_datasource.dart';

// implementação da interface do repositorio
class ProductRepositoryImpl implements IProductRepository {
  final IProductDatasource _datasource;

  ProductRepositoryImpl(this._datasource);
  
  // fetch de produto por codigo de barras
  @override
  Future<Either<ProductFailure, Product>> getByBarcode(Barcode barcode) async {
    // primeiro tenta validar se é possivel pegar os dados da api
    try {
      final productData = await _datasource.getProductByBarcode(barcode.value);

      return right(Product(
        barcode: barcode,
        name: productData['product_name'] ?? 'Nome não informado',
        brand: productData['brands'],
        imageUrl: productData['image_url'],
        price: null,          // vamo preencher isso tudo dps com o servico de estoque
        costPrice: null,
        stockQuantity: null,
      ));
    // senao retorna uma falha
    } catch (e) {
      return left(ProductFailure(e.toString()));
    }
  }
  
  // fetch de todos os produtos
  @override
  Future<Either<ProductFailure, List<Product>>> getAll() async {
    try {
      final productsData = await _datasource.getAllProducts();
      final products = productsData.map((data) {
        final barcodeOrFailure = Barcode.create(data['code'] ?? '');    // cria o codigo de barras com validação
        return barcodeOrFailure.fold(
          (failure) => throw Exception(failure.message),    // se falhar, retorna uma mensagem de erro
          (barcode) => Product(   // se der certo, cria uma instancia do produto
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
}