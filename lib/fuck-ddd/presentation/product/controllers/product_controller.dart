import 'package:flutter/material.dart';
import '../../../application/product/product_service.dart';
import '../../../domain/product/entities/product.dart';

// controlador de produtos usando changenotifier
class ProductController extends ChangeNotifier {
  final ProductService _productService;

  ProductController(this._productService);

  Product? _product;
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  // configurando alguns getters pra pegar os produtos
  Product? get product => _product;
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getProduct(String barcode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _productService.getProduct(barcode);

    result.fold(
      (failure) {
        _error = failure.message;
        _product = null;
      },
      (product) {
        _product = product;
        _error = null;
      }
    );

    _isLoading = false;
    notifyListeners();
  }

  // PRECISA IMPLEMENTAR!!!!!
  Future<void> getProducts({int page = 1}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _productService.getProducts();

    result.fold(
      (failure) {
        _error = failure.message;
        _products = [];
      },
      (products) {
        _products = products;
        _error = null;
      }
    );

    _isLoading = false;
    notifyListeners();
  }
}