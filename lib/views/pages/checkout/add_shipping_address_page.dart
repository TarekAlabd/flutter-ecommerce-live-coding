import 'package:flutter/material.dart';

class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({super.key});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adding Shipping Address',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
    );
  }
}