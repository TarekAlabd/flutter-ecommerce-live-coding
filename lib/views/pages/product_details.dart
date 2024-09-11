import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/product_details/product_details_cubit.dart';
import 'package:flutter_ecommerce/views/widgets/drop_down_menu.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropdownValue;

  // Future<void> _addToCart(Database database) async {
  //   try {
  //     final addToCartProduct = AddToCartModel(
  //       id: documentIdFromLocalData(),
  //       title: widget.product.title,
  //       price: widget.product.price,
  //       productId: widget.product.id,
  //       imgUrl: widget.product.imgUrl,
  //       size: dropdownValue,
  //     );
  //     await database.addToCart(addToCartProduct);
  //   } catch (e) {
  //     return MainDialog(
  //       context: context,
  //       title: 'Error',
  //       content: 'Couldn\'t adding to the cart, please try again!',
  //     ).showAlertDialog();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    product.imgUrl,
                    width: double.infinity,
                    height: size.height * 0.55,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 60,
                                child: DropDownMenuComponent(
                                  items: const ['S', 'M', 'L', 'XL', 'XXL'],
                                  hint: 'Size',
                                  onChanged: (String? newValue) => productDetailsCubit.setSize(newValue!),
                                ),
                              ),
                            ),
                            const Spacer(),
                            // TODO: Create one component for the favorite button
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: isFavorite
                                          ? Colors.redAccent
                                          : Colors.black45,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          product.category,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24.0),
                        BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                          bloc: productDetailsCubit,
                          listenWhen: (previous, current) =>
                              current is AddedToCart ||
                              current is AddToCartError,
                          listener: (context, state) {
                            if (state is AddedToCart) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product added to the cart!'),
                                ),
                              );
                            } else if (state is AddToCartError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AddingToCart) {
                              return MainButton(
                                child: const CircularProgressIndicator.adaptive(),
                              );
                            }
                            return MainButton(
                              text: 'Add to cart',
                              onTap: () async =>
                                  await productDetailsCubit.addToCart(product),
                              hasCircularBorder: true,
                            );
                          },
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
