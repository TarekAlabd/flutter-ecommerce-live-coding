import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/models/product_model.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.isNew,
    required this.addToFavorites,
  }) : super(key: key);
  final Product product;
  final bool isNew;
  final VoidCallback addToFavorites;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.42,
      height: size.height * 0.38,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: size.width * 0.4,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  color: ColorManager.kLightGrey,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.imgUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 60.0,
                height: 30.0,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: isNew ? ColorManager.kBlack : ColorManager.kRed,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    isNew ? 'New' : '- ${product.discountValue} %',
                    style: const TextStyle(
                      color: ColorManager.kWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 125,
            bottom: 95,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: ColorManager.kGrey,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: ColorManager.kWhite,
                radius: 25.0,
                child: InkWell(
                  onTap: addToFavorites,
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    size: 20.0,
                    color: ColorManager.kGrey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  itemSize: 25.0,
                  initialRating: product.rate!,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    debugPrint(rating.toString());
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: ColorManager.kGrey,
                        fontSize: 12.0,
                      ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: ColorManager.kBlack,
                        fontSize: 18.0,
                      ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                isNew
                    ? Text(
                        '${product.price}\$',
                        style: const TextStyle(
                          color: ColorManager.kBlack,
                          fontSize: 14.0,
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${product.price}\$  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: ColorManager.kGrey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '  ${product.price * (product.discountValue) / 100}\$',
                              style: const TextStyle(
                                color: ColorManager.kRed,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
