import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/controllers/product_details/product_details_cubit.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/pages/bottom_navbar.dart';
import 'package:flutter_ecommerce/views/pages/checkout/add_shipping_address_page.dart';
import 'package:flutter_ecommerce/views/pages/checkout/checkout_page.dart';
import 'package:flutter_ecommerce/views/pages/checkout/payment_methods_page.dart';
import 'package:flutter_ecommerce/views/pages/checkout/shipping_addresses_page.dart';
import 'package:flutter_ecommerce/views/pages/auth_page.dart';
import 'package:flutter_ecommerce/views/pages/product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
    case AppRoutes.checkoutPageRoute:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.getCheckoutData();
            return cubit;
          },
          child: const CheckoutPage(),
        ),
        settings: settings,
      );
    case AppRoutes.productDetailsRoute:
      final productId = settings.arguments as String;

      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = ProductDetailsCubit();
            cubit.getProductDetails(productId);
            return cubit;
          },
          child: const ProductDetails(),
        ),
        settings: settings,
      );

    case AppRoutes.shippingAddressesRoute:
      final checkoutCubit = settings.arguments as CheckoutCubit;
      return CupertinoPageRoute(
        builder: (_) => BlocProvider.value(
          value: checkoutCubit,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
    case AppRoutes.paymentMethodsRoute:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.fetchCards();
            return cubit;
          },
          child: const PaymentMethodsPage(),
        ),
        settings: settings,
      );
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final checkoutCubit = args.checkoutCubit;
      final shippingAddress = args.shippingAddress;

      return CupertinoPageRoute(
        builder: (_) => BlocProvider.value(
          value: checkoutCubit,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
  }
}
