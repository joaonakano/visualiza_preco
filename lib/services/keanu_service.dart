import 'dart:convert';

import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';
import 'package:http/http.dart' as http;

class KeanuService {
  static const String _baseUrl = "https://whoa.onrender.com/whoas/random";

  // Função assíncrona que solicita os dados da API
  Future<List<Quote>> fetchQuotes(int totalQuotes) async {
    final response = await http.get(
      Uri.parse("$_baseUrl?results=$totalQuotes")
    );

    if (response.statusCode == 200) {
      // Se a response for OK (200),
      // Desempacotar o json em objetos Quote
      List<dynamic> list = jsonDecode(response.body);
      return list.map((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception("Falha ao carregar o Whoa");
    }
  }
}