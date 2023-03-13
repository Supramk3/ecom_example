import 'dart:math';

import 'package:ecom_example_project/src/constrants/test_products.dart';
import 'package:ecom_example_project/src/models/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository makeProductsRepository() =>
      FakeProductsRepository(addDelay: false);
  group('FakeProductsRepository', () {
    test('getProductsList return global List', () {
      final productsRepository = makeProductsRepository();
      expect(productsRepository.getProductsList(), kTestProducts);
    });

    test('getProduct(1) returns first item', () {
      final productsRepository = makeProductsRepository();
      expect(productsRepository.getProduct('1'), kTestProducts[0]);
    });

    // test('getProduct(100) returns null', () {
    //   final productsRepository = FakeProductsRepository();
    //   expect(() => productsRepository.getProduct('100'), null);
    // });
  });
  test('fetchProductsList returns global test', () async {
    final productsRepository = makeProductsRepository();
    expect(
      await productsRepository.fetchProductList(),
      kTestProducts,
    );
  });

  test('watchProductList emits global list', () {
    final productsRepository = makeProductsRepository();
    expect(productsRepository.watchProductList(), emits(kTestProducts));
  });
  test('watchProduct(1) emits first item', () {
    final productsRepository = makeProductsRepository();
    expect(productsRepository.watchProduct('1'), emits(kTestProducts[0]));
  });
  // test('watchProduct(100) emits 100', () {
  //   final productsRepository = FakeProductsRepository();
  //   expect(productsRepository.watchProduct('100'), emits(null));
  // });
}
