import 'package:http/http.dart' as http;
import 'dart:convert';
import './product_datasource.dart';

// adaptando o servico do OpenFoodFacts para um datasource
class OpenFoodFactsDatasource implements IProductDatasource {
  final String baseUrl = 'https://world.openfoodfacts.org/api/v0/product/';

  @override
  Future<Map<String, dynamic>> getProductByBarcode(String barcode) async {
    final response = await http.get(Uri.parse('$baseUrl$barcode.json'));

    // se der boa a requisicao
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // se o produto existir, retornar os dados em um dicionario
      if (data['status'] == 1) {
        return data['product'];
      }
      throw Exception('Produto não encontrado na API');
    }
    // se nao der boa a requisicao
    throw Exception('Falha ao carregar produto');
  }

  // nao faco ideia, procurar dps, possivelmente implementar uma forma de pegar todos os cadastros
  @override
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    throw UnimplementedError();
  }
}