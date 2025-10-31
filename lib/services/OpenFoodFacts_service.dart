import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_off_model.dart';

class OpenfoodfactsService {
  static const String _baseUrl = "https://world.openfoodfacts.org/api/v2/product";
  // função assincrona pra receber o barcode e retornar um produto
  Future<ProductOFF> fetchProduct(String barcode) async{
    final uri = Uri.parse("$_baseUrl/$barcode.json");
    print("Buscando dados em: $uri"); // vou deixar aqui enquanto esta em fase de desenvolvimento, depois a gnt pode tira
    final response = await http.get(uri);

    if (response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      // pelo oq procurei (chat ajudou a entender essa parte), a api tem status "0" e "1" onde "1" ele achou o produto e "0" nao achou o produto porem o barcode é valido (resumindo nao tem no DB deles)
      if (data['status'] == 1 && data['product'] != null){
        return ProductOFF.fromProductJson(data['product'], barcode);
      } else {
        print("Produto nao encontrado no OFF (Barcode: $barcode)");
        throw Exception("Prodduto não encontrado no Open Food Facts");
      }
    } else{
      print("Erro na API do OFF: ${response.statusCode}");
      throw Exception("Falha ao carregar os dados do Open Food Facts");
    }
  }
}