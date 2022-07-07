import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/product_widgets/add_to_cart_button.dart';
import 'package:flutter_ecommerce/views/widgets/product_widgets/delete_button.dart';
  import '../../../models/product_model.dart';
import '../../../utilities/colors.dart';
import 'discount_span.dart';
import 'fav_button.dart';
import 'rate_stars_.dart';

 
class GridViewFavWidget extends StatelessWidget {
  const GridViewFavWidget({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    bool hasDiscount = product.discount > 0;
    final totalPrice = hasDiscount
        ? product.price
        : product.price - (product.price * product.discount / 100);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 300,
            // width: 600,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    //alignment: Alignment.topLeft,
                    children: [
                      
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          height: 150,
                          width: 170,
                        ),
                      ),
                      //const SizedBox(height: 6.0),
                      Positioned(right: 0, child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DeleteButton.build(),
                      )),
                      DiscountSpan.build(
                          context, hasDiscount, product.discount),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RateStars.build(product.rate!, context),
                        Text(product.category.toString(),
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.grey,
                                      // fontSize: 15,
                                    )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.title.toString(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.black,
                                  //fontSize: 18,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
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
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        AddToCartButton.build(context)
      ],
    );
  }

   
}
