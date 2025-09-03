import 'dart:convert';

import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';
import 'package:http/http.dart' as http;

class KeanuService {
  static const String _baseUrl = "https://whoa.onrender.com/whoas/random";

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(
      Uri.parse(_baseUrl)
    );

    if (response.statusCode == 200) {
      // response OK
      // Esse code da b.o: return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      List<dynamic> list = jsonDecode(response.body);
      return list.map((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception("Falha ao carregar o Whoa");
    }
  }
}