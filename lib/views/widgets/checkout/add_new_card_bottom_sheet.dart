import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  final PaymentMethod? paymentMethod;
  const AddNewCardBottomSheet({super.key, this.paymentMethod,});

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameOnCardController,
      _expireDateController,
      _cardNumberController,
      _cvvController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameOnCardController = TextEditingController();
    _expireDateController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cvvController = TextEditingController();
    
    if (widget.paymentMethod != null) {
      _nameOnCardController.text = widget.paymentMethod!.name;
      _expireDateController.text = widget.paymentMethod!.expiryDate;
      _cardNumberController.text = widget.paymentMethod!.cardNumber;
      _cvvController.text = widget.paymentMethod!.cvv;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    return SizedBox(
      height: size.height * 0.7,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            Text(
              'Add New Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextFormField(
                controller: _nameOnCardController,
                keyboardType: TextInputType.name,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your name'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextFormField(
                controller: _cardNumberController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your card number'
                    : null,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  String newValue = value.replaceAll('-', '');
                  if (newValue.length % 4 == 0 && newValue.length < 16) {
                    _cardNumberController.text += '-';
                  }
                  if (value.length >= 20) {
                    _cardNumberController.text = value.substring(0, 19);
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextFormField(
                controller: _expireDateController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your expire date'
                    : null,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  if (value.length == 2 && !value.contains('/')) {
                    _expireDateController.text += '/';
                  }
                  if (value.length == 6 && value.contains('/')) {
                    _expireDateController.text = value.substring(0, 5);
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Expire Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextFormField(
                controller: _cvvController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your CVV'
                    : null,
                onChanged: (value) {
                  if (value.length >= 3) {
                    _cvvController.text = value.substring(0, 3);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 36.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: BlocConsumer<CheckoutCubit, CheckoutState>(
                bloc: checkoutCubit,
                listenWhen: (previous, current) =>
                    current is CardsAdded || current is CardsAddingFailed,
                listener: (context, state) {
                  if (state is CardsAdded) {
                    Navigator.pop(context);
                  } else if (state is CardsAddingFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is AddingCards ||
                    current is CardsAdded ||
                    current is CardsAddingFailed,
                builder: (context, state) {
                  if (state is AddingCards) {
                    return MainButton(
                      onTap: null,
                      child: const CircularProgressIndicator.adaptive(),
                    );
                  }
                  return MainButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final paymentMethod = PaymentMethod(
                          id: widget.paymentMethod != null ? widget.paymentMethod!.id : DateTime.now().toIso8601String(),
                          name: _nameOnCardController.text,
                          cardNumber: _cardNumberController.text,
                          expiryDate: _expireDateController.text,
                          cvv: _cvvController.text,
                        );
                        await checkoutCubit.addCard(paymentMethod);
                      }
                    },
                    text: widget.paymentMethod != null ? 'Edit Card' : 'Add Card',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
