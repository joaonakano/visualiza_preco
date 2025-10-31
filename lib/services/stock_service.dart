/* aqui vai ficar o banco de dados ficticio enquanto nao usamos um de vdd
ele vai fornecer o preço, custo e quantidade ja que a nossa API nao vai fornecer*/

class StockService {
  final Map<String, Map<String, dynamic>> _fakeDatabase = {
    '7891991010196': {
      // Ex: Código de um "Nescau" 
      'price': 15.50,
      'costPrice': 9.00,
      'stockQuantity': 150,
    },
    '7891000055018': {
      // Ex: Código de uma "Coca-Cola" 
      'price': 7.99,
      'costPrice': 3.90,
      'stockQuantity': 300,
    },
    '7896004000160': {
      // Ex: Código de um "Salgadinho" 
      'price': 12.90,
      'costPrice': 6.20,
      'stockQuantity': 80,
    },
  };

  /* Esta função vai simula uma chamada de rede para o db.
     Por isso o 'Future' e tem um atraso (delay).
  */
  Future<Map<String, dynamic>?> fetchStoreDetails(String barcode) async {
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
}
