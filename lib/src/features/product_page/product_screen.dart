import 'package:ecom_example_project/src/features/product_page/product_average_rating.dart';
import 'package:ecom_example_project/src/features/product_page/product_reviews/product_reviews_list.dart';
import 'package:ecom_example_project/src/localization/string_hardcoded.dart';
import 'package:ecom_example_project/src/models/fake_products_repository.dart';
import 'package:ecom_example_project/src/widgets/async_value_widget.dart';
import 'package:ecom_example_project/src/widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constrants/app_sizes.dart';
import '../../constrants/test_products.dart';
import '../../models/product.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/resonsive_two_column_layout.dart';
import '../../widgets/responsive_center.dart';
import '../home_app_bar/home_app_bar.dart';
import '../not_found/empty_placeholder_widget.dart';
import 'add_to_cart/add_to_cart_widget.dart';
import 'leave_review_action.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final productValue = ref.watch(productProvider(productId));
          return AsyncValueWidget<Product?>(
            value: productValue,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(
                    message: 'Product not found'.hardcoded,
                  )
                : CustomScrollView(slivers: [
                    ResponsiveSliverCenter(
                      padding: const EdgeInsets.all(Sizes.p16),
                      child: ProductDetails(product: product),
                    ),
                    ProductReviewsList(productId: productId),
                  ]),
          );

          // final productsRepository = ref.watch(productsRepositoryProvider);
          // final product = productsRepository.getProduct(productId);
        },
      ),
    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final priceFormatted = kCurrencyFormatter.format(product.price);
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: product.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title,
                  style: Theme.of(context).textTheme.titleLarge),
              gapH8,
              Text(product.description),
              // Only show average if there is at least one rating
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH8,
              const Divider(),
              gapH8,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headlineSmall),
              gapH8,
              LeaveReviewAction(productId: product.id),
              const Divider(),
              gapH8,
              AddToCartWidget(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
