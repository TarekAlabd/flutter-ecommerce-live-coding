import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/custom_buttons/dark_button.dart';
import 'package:flutter_ecommerce/views/widgets/custom_buttons/primary_button.dart';
import '../../../utilities/colors.dart';
import '../product_widgets/add_to_cart_button.dart';
import '../product_widgets/delete_button.dart';
import '../product_widgets/discount_span.dart';
import '../product_widgets/rate_stars_.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../pages/category_page.dart';
import 'quantity_button.dart';

class ListViewCartWidget extends StatefulWidget {
  const ListViewCartWidget({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ListViewCartWidget> createState() => _ListViewCartWidgetState();
}

class _ListViewCartWidgetState extends State<ListViewCartWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool hasDiscount = widget.product.discount > 0;
    int qty = 1;
    final totalPrice = hasDiscount
        ? widget.product.price
        : widget.product.price -
            (widget.product.price * widget.product.discount / 100);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 135,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                widget.product.imageUrl,
                                fit: BoxFit.fitHeight,
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.product.title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        //fontSize: 18,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Size',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    ' XL',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Color',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        ' black',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(color: Colors.black),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            qty--;
                                          });
                                        },
                                        child: QuantityButton.build(
                                            context, false),
                                      ),
                                      SizedBox(
                                          width: 30,
                                          child: Text(
                                            qty.toString(),
                                            textAlign: TextAlign.center,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            qty++;
                                          });
                                        },
                                        child: QuantityButton.build(
                                            context, true),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            DeleteButton.build(),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, right: 10.0),
                              child: Text(
                                totalPrice.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                // textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
