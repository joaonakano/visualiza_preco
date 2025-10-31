//modelo principal que vamos usar 

class Product {
  final String barcode;
  String name;
  String? brand;
  String? imageUrl;

  double? price;
  double? costPrice;
  int? stockQuantity;

  Product({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
    this.price,
    this.costPrice,
    this.stockQuantity,

  });

  @override
  String toString() {
    return '''
  Product(
  barcode: $barcode,
  name: $name,
  brand: $brand,
  imageUrl: $imageUrl,
  price: $price,
  costPrice: $costPrice.
  stockQuantity: $stockQuantity,
  )''';
  }
}