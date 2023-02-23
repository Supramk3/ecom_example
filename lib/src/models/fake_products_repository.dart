import 'package:ecom_example_project/src/constrants/test_products.dart';
import 'package:ecom_example_project/src/models/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();
  static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;
  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}
