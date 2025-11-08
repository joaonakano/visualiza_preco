/* aqui vai ficar o banco de dados ficticio enquanto nao usamos um de vdd
ele vai fornecer o preço, custo e quantidade ja que a nossa API nao vai fornecer*/

class StockDatasource {
  final Map<String, Map<String, dynamic>> _fakeDatabase = {
    '7891000379691': {
      // Ex: Código de um "Nescau"
      'price': 15.50,
      'costPrice': 9.00,
      'stockQuantity': 150,
    },
    '7894900027013': {
      // Ex: Código de uma "Coca-Cola"
      'price': 7.99,
      'costPrice': 3.90,
      'stockQuantity': 300,
    },
    '7894900011517': {
      // Detergente Líquido Neutro 500ml (ta com imagem de cocaKKKKKKKKKK)
      'price': 8.99,
      'costPrice': 4.50,
      'stockQuantity': 200,
    },
    '7894900700046': {
      // Coca-Cola 350ml
      'price': 3.50,
      'costPrice': 1.80,
      'stockQuantity': 500,
    },
    '7894900530001': {
      // Coca-Cola Lata 350ml
      'price': 4.50,
      'costPrice': 2.20,
      'stockQuantity': 400,
    },
  };

  /* Esta função vai simula uma chamada de rede para o db.
     Por isso o 'Future' e tem um atraso (delay).
  */
  Future<Map<String, dynamic>?> getStockByBarcode(String barcode) async {
    // Simula o tempo de espera de uma chamada de rede
    await Future.delayed(Duration(milliseconds: 300));

    // Verifica se o db  contém o código de barras
    if (_fakeDatabase.containsKey(barcode)) {
      // se achar retorna os dados (preço, custo, quantidade)
      return _fakeDatabase[barcode];
    } else {
      return null;
    }
  }

  /// Retorna todos os produtos em estoque
  Future<List<Map<String, dynamic>>> getAllStock() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _fakeDatabase.entries.map((entry) {
      return {'barcode': entry.key, ...entry.value};
    }).toList();
  }
}
