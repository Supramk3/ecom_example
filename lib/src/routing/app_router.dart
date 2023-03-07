import 'package:ecom_example_project/src/features/account/account_screen.dart';
import 'package:ecom_example_project/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecom_example_project/src/features/checkout/checkout_screen.dart';
import 'package:ecom_example_project/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecom_example_project/src/features/orders_list/orders_list_screen.dart';
import 'package:ecom_example_project/src/features/product_page/product_screen.dart';
import 'package:ecom_example_project/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecom_example_project/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecom_example_project/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:ecom_example_project/src/models/product.dart';
import 'package:ecom_example_project/src/routing/go_router_refresh_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/not_found/not_found_screen.dart';
import '../features/products_list/products_list_screen.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;

      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/';
        }
      } else {
        if (state.location == '/account' || state.location == '/orders') {
          return '/';
        }
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const ProductsListScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.params['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              GoRoute(
                  path: 'review',
                  name: AppRoute.leaveReview.name,
                  pageBuilder: (context, state) {
                    final productId = state.params['id']!;
                    return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: LeaveReviewScreen(productId: productId));
                  }),
            ],
          ),
          GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            pageBuilder: ((context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ShoppingCartScreen(),
                )),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                pageBuilder: (context, state) => MaterialPage(
                    key: ValueKey(state.location),
                    fullscreenDialog: true,
                    child: const CheckoutScreen()),
              )
            ],
          ),
          GoRoute(
            path: 'orders',
            name: AppRoute.orders.name,
            pageBuilder: ((context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const OrdersListScreen())),
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: ((context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const AccountScreen())),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: ((context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ))),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
// added this change for branch