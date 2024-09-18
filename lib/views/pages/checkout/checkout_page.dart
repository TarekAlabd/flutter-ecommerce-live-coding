import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/models/delivery_method.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/checkout_order_details.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/delivery_method_item.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/payment_component.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    Widget shippingAddressComponent(ShippingAddress? shippingAddress) {
      if (shippingAddress == null) {
        return Center(
          child: Column(
            children: [
              const Text('No Shipping Addresses!'),
              const SizedBox(height: 6.0),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.addShippingAddressRoute,
                  arguments: AddShippingAddressArgs(
                    checkoutCubit: checkoutCubit,
                    shippingAddress: shippingAddress,
                  )
                ),
                child: Text(
                  'Add new one',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              ),
            ],
          ),
        );
      } else {
        return ShippingAddressComponent(shippingAddress: shippingAddress, checkoutCubit: checkoutCubit,);
      }
    }

    Widget deliveryMethodsComponent(List<DeliveryMethod> deliveryMethods) {
      if (deliveryMethods.isEmpty) {
        return const Center(
          child: Text('No delivery methods available!'),
        );
      }
      return SizedBox(
        height: size.height * 0.13,
        child: ListView.builder(
          itemCount: deliveryMethods.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: DeliveryMethodItem(deliveryMethod: deliveryMethods[i]),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        buildWhen: (previous, current) =>
            current is CheckoutLoading ||
            current is CheckoutLoaded ||
            current is CheckoutLoadingFailed,
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CheckoutLoadingFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CheckoutLoaded) {
            final shippingAddress = state.shippingAddress;
            final deliveryMethods = state.deliveryMethods;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8.0),
                    shippingAddressComponent(shippingAddress),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.paymentMethodsRoute);
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.redAccent,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const PaymentComponent(),
                    const SizedBox(height: 24.0),
                    Text(
                      'Delivery method',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8.0),
                    deliveryMethodsComponent(deliveryMethods),
                    const SizedBox(height: 32.0),
                    const CheckoutOrderDetails(),
                    const SizedBox(height: 64.0),
                    BlocConsumer<CheckoutCubit, CheckoutState>(
                      bloc: checkoutCubit,
                      listenWhen: (previous, current) =>
                          current is PaymentMakingFailed ||
                          current is PaymentMade,
                      listener: (context, state) {
                        if (state is PaymentMakingFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else if (state is PaymentMade) {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is PaymentMade ||
                          current is PaymentMakingFailed ||
                          current is MakingPayment,
                      builder: (context, state) {
                        if (state is MakingPayment) {
                          return MainButton(
                            hasCircularBorder: true,
                            child: const CircularProgressIndicator.adaptive(),
                          );
                        }
                        return MainButton(
                          text: 'Submit Order',
                          onTap: () async =>
                              await checkoutCubit.makePayment(300),
                          hasCircularBorder: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
