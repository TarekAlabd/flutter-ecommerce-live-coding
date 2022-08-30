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
  const ListViewCartWidget(
      {Key? key,
      required this.product,
      this.cardType = orderCardTypes.cart,
      this.itemUnit = 0,
      this.brandName = "Mango",
      required this.size,
      required this.color})
      : super(key: key);
  final Product product;
  final orderCardTypes cardType;
  final int itemUnit;
  final String brandName;
  final String size;
  final String color;
  @override
  State<ListViewCartWidget> createState() => _ListViewCartWidgetState();
}

class _ListViewCartWidgetState extends State<ListViewCartWidget> {
  @override
  Widget build(BuildContext context) {
    int qty = widget.cardType == orderCardTypes.cart ? 1 : widget.itemUnit;
    var size = MediaQuery.of(context).size;
    bool hasDiscount = widget.product.discount > 0;

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
                height: 140,
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
                              if (widget.cardType == orderCardTypes.orderDetail)
                                Text(
                                  widget.brandName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                ),
                              if (widget.cardType == orderCardTypes.orderDetail)
                                const SizedBox(
                                  height: 10,
                                ),
                              Row(
                                children: [
                                  Text(
                                    'Size:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    widget.size,
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
                                        'Color:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                         widget.color,
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
                                  widget.cardType == orderCardTypes.cart
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                        )
                                      : Row(children: [
                                          Text(
                                            'Unit',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                          Text(
                                            ' $qty',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ]),
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
                            if (widget.cardType == orderCardTypes.cart)
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

enum orderCardTypes { cart, orderDetail }
