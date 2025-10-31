

class ProductOFF {
  final String barcode;
  final String name;
  final String? brand;
  final String? imageUrl;

  ProductOFF({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
    
  });
  /*
  factory é o construtor responsavel por decodificar o JSON da API
  ele ta recebendo o map 'productJson' (seria o product dentro da resposta) e recebe o 'originalBarcode que foi lido 
   */

  factory ProductOFF.fromProductJson(Map<String, dynamic> productJson, String originalBarcode){
    return ProductOFF(
      barcode: originalBarcode,
      name: productJson['product_name_pt'] ??
            productJson['product_name'] ??
            'Nome não encontrado na API(OFF)',

      brand: productJson['brands'],
      imageUrl: productJson['imafe_front_url'],
      );
  }
  @override
  String toString() {
    return 'ProductOFF(barcode: $barcode, name: $name, brand: $brand, imageUrl: $imageUrl)';
  }
}