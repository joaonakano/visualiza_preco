import '../../../domain/product/entities/product.dart';
import '../../../domain/product/value_objects/barcode.dart';

class ProductDto {
  final String barcode;
  final String name;
  final String? brand;
  final String? imageUrl;

  ProductDto({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      barcode: json['code'] ?? '',
      name: json['product_name'] ?? json['generic_name'] ?? 'Produto sem nome',
      brand: json['brands'],
      imageUrl: json['image_url'],
    );
  }

  Product toDomain() {
    final barcodeOrFailure = Barcode.create(barcode);

    return barcodeOrFailure.fold(
      // caso inválido, ainda retornamos um Product, mas com barcode vazio
      (_) => Product(
        barcode: Barcode.create("0").getOrElse(() => throw Exception("Codigo de barra inválido")),
        name: name,
        brand: brand,
        imageUrl: imageUrl,
        price: null,
        costPrice: null,
        stockQuantity: null,
      ),
      // caso válido
      (validBarcode) => Product(
        barcode: validBarcode,
        name: name,
        brand: brand,
        imageUrl: imageUrl,
        price: null,
        costPrice: null,
        stockQuantity: null,
      ),
    );
  } 
}
