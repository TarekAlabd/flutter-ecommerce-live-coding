import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';

class AddShippingAddressArgs {
  final ShippingAddress? shippingAddress;
  final CheckoutCubit checkoutCubit;

  AddShippingAddressArgs({this.shippingAddress, required this.checkoutCubit,});
}
