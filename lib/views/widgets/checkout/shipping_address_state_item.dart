import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/checkout/checkout_cubit.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

class ShippingAddressStateItem extends StatefulWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressStateItem({
    super.key,
    required this.shippingAddress,
  });

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.shippingAddress.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    
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
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.addShippingAddressRoute,
                    arguments: AddShippingAddressArgs(
                      shippingAddress: widget.shippingAddress,
                      checkoutCubit: checkoutCubit
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              '${widget.shippingAddress.city}, ${widget.shippingAddress.state}, ${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            CheckboxListTile(
              title: const Text("Default shipping address"),
              value: checkedValue,
              onChanged: (newValue) async {
                setState(() {
                  checkedValue = newValue!;
                });
                // TODO: We need to add the business logic of adding the default address (one default)
                final newAddress =
                    widget.shippingAddress.copyWith(isDefault: newValue);
                await checkoutCubit.saveAddress(newAddress);
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )
          ],
        ),
      ),
    );
  }
}
