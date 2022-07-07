import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import '../../../utilities/colors.dart';
import 'fav_button.dart';
import 'rate_stars_.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../pages/category_page.dart';

class ListViewProductWidget extends StatelessWidget {
  const ListViewProductWidget({Key? key, required this.product})
      : super(key: key);
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
          padding: const EdgeInsets.only(top: 15.0,bottom: 13),
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
                  height: 150,
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
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
                              //_generateCornerSpan(context, hasDiscount, product.discount),
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
                                  height: 5,
                                ),
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
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        FavButton.build(context, true)
      ],
    );
  }
}
