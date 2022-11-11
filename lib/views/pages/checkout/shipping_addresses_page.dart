import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:provider/provider.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Addresses',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: StreamBuilder<List<ShippingAddress>>(
              stream: database.getShippingAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final shippingAddresses = snapshot.data;
                  return Column(
                    children: shippingAddresses!
                        .map(
                          (shippingAddress) => ShippingAddressComponent(
                              shippingAddress: shippingAddress),
                        )
                        .toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
        ),
      ),
    );
  }
}
