import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';

class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressComponent({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: theme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.shippingAddressesRoute,
                    arguments: database,
                  ),
                  child: Text(
                    'Change',
                    style: theme.button!.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              shippingAddress.address,
              style: theme.titleLarge,
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: theme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
