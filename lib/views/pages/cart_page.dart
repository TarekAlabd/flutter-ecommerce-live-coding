import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/cart/cart_cubit.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return SafeArea(
      child: BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        buildWhen: (previous, current) =>
            current is CartLoaded ||
            current is CartLoading ||
            current is CartError,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CartLoaded) {
            final totalAmount = state.totalAmount;
            final cartProducts = state.cartProducts;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await cartCubit.getCartItems();
                },
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'My Cart',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    if (cartProducts.isEmpty)
                      Center(
                        child: Text(
                          'No Data Available!',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    if (cartProducts.isNotEmpty)
                      ListView.builder(
                        itemCount: cartProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          final cartItem = cartProducts[i];
                          return CartListItem(
                            cartItem: cartItem,
                          );
                        },
                      ),
                    const SizedBox(height: 24.0),
                    OrderSummaryComponent(
                      title: 'Total Amount',
                      value: totalAmount.toString(),
                    ),
                    const SizedBox(height: 32.0),
                    MainButton(
                      text: 'Checkout',
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.checkoutPageRoute,
                      ),
                      hasCircularBorder: true,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.labelMedium,
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
