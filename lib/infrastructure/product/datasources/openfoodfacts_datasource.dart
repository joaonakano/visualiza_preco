import 'package:http/http.dart' as http;
import 'dart:convert';
import './product_datasource.dart';
import '../dto/product_dto.dart';

// adaptando o servico do OpenFoodFacts para um datasource
class OpenFoodFactsDatasource implements IProductDatasource {
  @override
  Future<Map<String, dynamic>> getProductByBarcode(String barcode) async {
    final response = await http.get(Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'));

    if (response.statusCode != 200) {
      throw Exception("Falha ao carregar produto da API");
    }

    final data = json.decode(response.body);
    if (data["status"] != 1) {
      throw Exception("Produto não encontrado");
    }

    return data["product"];
  }

  // busca por uma lista de produtos
  @override
  Future<List<ProductDto>> getProducts() async {
    final url = Uri.parse(
      "https://world.openfoodfacts.org/cgi/search.pl"
      "?search_simple=1&action=process&page_size=20&page=1&json=1",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar produtos');
    }

    final data = json.decode(response.body);

    final list = data["products"] as List;

    // retornando a lista de produtos como DTO pro repository
    return list
      .map((item) => ProductDto.fromJson(item))
      .toList();
  }
}