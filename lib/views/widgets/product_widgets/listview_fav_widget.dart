import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utilities/colors.dart';
import 'add_to_cart_button.dart';
import 'delete_button.dart';
import 'discount_span.dart';
import 'fav_button.dart';
import 'rate_stars_.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../pages/category_page.dart';

class ListViewFavWidget extends StatelessWidget {
  const ListViewFavWidget({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool hasDiscount = product.discount > 0;
    final totalPrice = hasDiscount
        ? product.price
        : product.price - (product.price * product.discount / 100);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 13),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryPage(
                          categoryObj: Category("", "", ""),
                        ))),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                    product.imageUrl,
                                    fit: BoxFit.fitHeight,
                                    width: 170,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                DiscountSpan.build(
                          context, hasDiscount, product.discount),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.category.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                            color: Colors.grey,
                                            // fontSize: 15,
                                          )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    product.title.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            //fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                    height: 10,
                                  ),

                                  //if(product.rate == 0)
                                  RateStars.build(product.rate!, context),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: ' $totalPrice SR',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                      text: '${product.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            DeleteButton.build(),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        AddToCartButton.build(context)
      ],
    );
  }
}
