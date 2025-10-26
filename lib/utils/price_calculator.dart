/// Utilitário para cálculos relacionados a preços
class PriceCalculator {
  /// Calcula o desconto aplicado a um preço
  ///
  /// [originalPrice] - Preço original do produto
  /// [discountPercentage] - Percentual de desconto (0-100)
  ///
  /// Retorna o preço final com desconto aplicado
  static double calculateDiscount(
    double originalPrice,
    double discountPercentage,
  ) {
    if (originalPrice < 0) {
      throw ArgumentError('Preço original não pode ser negativo');
    }
    if (discountPercentage < 0 || discountPercentage > 100) {
      throw ArgumentError('Percentual de desconto deve estar entre 0 e 100');
    }

    double discount = originalPrice * (discountPercentage / 100);
    return originalPrice - discount;
  }

  /// Formata um valor monetário para o padrão brasileiro
  ///
  /// [value] - Valor a ser formatado
  ///
  /// Retorna a string formatada (ex: "R$ 10,50")
  static String formatPrice(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  /// Calcula o total de uma compra com múltiplos itens
  ///
  /// [prices] - Lista de preços dos produtos
  ///
  /// Retorna a soma total dos preços
  static double calculateTotal(List<double> prices) {
    if (prices.isEmpty) return 0.0;
    return prices.reduce((sum, price) => sum + price);
  }
}
