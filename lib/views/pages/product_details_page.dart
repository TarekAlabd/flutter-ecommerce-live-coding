import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/views/widgets/custom_buttons/primary_button.dart';
import 'package:flutter_ecommerce/views/widgets/product_widgets/fav_button.dart';
import 'package:flutter_ecommerce/views/widgets/shared/custom_app_bar.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
              title: widget.product.title,
              hasIcon: true,
              icon: const Icon(Icons.share),
              hasBackNav: true,
              backNavEvent: () => Navigator.of(context).pop(),
              hasBottomContent: false)
          .build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product.imageUrl,
                width: double.infinity,
                height: size.height * 0.5,
                fit: BoxFit.cover),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Align(
                      child: FavButton.build(context, isFavorite),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.product.category,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.grey),
                        //  textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text('${widget.product.price}',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: PrimaryButton(
                    label_: "Add to cart",
                    onTapAction: () {},
                  ).build(context)),
            )
          ],
        ),
      ),
    );
  }
}
