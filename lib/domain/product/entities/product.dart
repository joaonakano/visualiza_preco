import '../value_objects/barcode.dart';

// entidade produto representando um produto no DDD
class Product {
  final Barcode barcode;
  final String name;
  final String? brand;
  final String? imageUrl;
  final double? price;
  final double? costPrice;
  final int? stockQuantity;

  const Product({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
    this.price,
    this.costPrice,
    this.stockQuantity,
  });

  // metodo que faz uma copia da instancia com os valores alterados
  Product copyWith({
    Barcode? barcode,
    String? name,
    String? brand,
    String? imageUrl,
    double? price,
    double? costPrice,
    int? stockQuantity,
  }) {
    return Product(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}