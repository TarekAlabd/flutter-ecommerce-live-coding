import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/add_new_card_bottom_sheet.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    Future<void> showBottomSheet([PaymentMethod? paymentMethod]) async {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return BlocProvider.value(
              value: checkoutCubit,
              child: AddNewCardBottomSheet(paymentMethod: paymentMethod),
            );
          }).then((value) => checkoutCubit.fetchCards());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        listenWhen: (previous, current) =>
            current is PreferredMade || current is PreferredMakingFailed,
        listener: (context, state) {
          if (state is PreferredMade) {
            Navigator.of(context).pop();
          } else if (state is PreferredMakingFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is FetchingCards ||
            current is CardsFetched ||
            current is CardsFetchingFailed,
        builder: (context, state) {
          if (state is FetchingCards) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CardsFetchingFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CardsFetched) {
            final paymentMethods = state.paymentMethods;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your payment cards',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        final paymentMethod = paymentMethods[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: InkWell(
                            onTap: () async {
                              await checkoutCubit.makePreferred(paymentMethod);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.credit_card),
                                        const SizedBox(width: 8.0),
                                        Text(paymentMethod.cardNumber),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            showBottomSheet(paymentMethod);
                                          },
                                        ),
                                        BlocBuilder<CheckoutCubit,
                                            CheckoutState>(
                                          bloc: checkoutCubit,
                                          buildWhen: (previous, current) =>
                                              (current is DeletingCards &&
                                                  current.paymentId ==
                                                      paymentMethod.id) ||
                                              current is CardsDeleted ||
                                              current is CardsDeletingFailed,
                                          builder: (context, state) {
                                            if (state is DeletingCards) {
                                              return const CircularProgressIndicator
                                                  .adaptive();
                                            }
                                            return IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                await checkoutCubit
                                                    .deleteCard(paymentMethod);
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    MainButton(
                      onTap: () {
                        showBottomSheet();
                      },
                      text: 'Add New Card',
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
