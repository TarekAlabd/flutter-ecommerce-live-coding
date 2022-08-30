import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product_model.dart';
import '../widgets/cart/listview_cart_widget.dart';
import '../widgets/product_widgets/listview_product_widget.dart';
import '../widgets/shared/custom_app_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    Key? key,
    required this.orderNo,
    required this.orderDate,
    required this.trackingNo,
    required this.orderStatusWidget,
    required this.totalItems,
    required this.discount,
    required this.totalPrice,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.shippingAddress,
  }) : super(key: key);
  final String orderNo;
  final String orderDate;
  final String trackingNo;
  final Widget orderStatusWidget;
  final int totalItems;
  final double discount;
  final double totalPrice;
  final Widget paymentMethod;
  final String deliveryMethod;
  final String shippingAddress;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Order Details",
        hasBackNav: true,
        backNavEvent: () => Navigator.of(context).pop(),
        hasBottomContent: false,
        hasIcon: true,
        icon: const Icon(Icons.search_outlined),
        iconEvent: () {},
      ).build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'orderNo $orderNo',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  Text(
                    orderDate,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Tracking No. ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        trackingNo,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  orderStatusWidget
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '$totalItems Items',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              LimitedBox(
                maxHeight: 350,
                child: StreamBuilder<List<Product>>(
                    stream: database.allProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final productslist = snapshot
                            .data; //?.where((element) => element.discount > 0);
                        if (productslist == null || productslist.isEmpty) {
                          return const Center(
                            child: Text('No Data Avilable'),
                          );
                        }
                        return ListView(
                            shrinkWrap: true,
                            //scrollDirection: Axis.horizontal,
                            children: productslist
                                .map(
                                  (e) => ListViewCartWidget(
                                    product: e,
                                    cardType: orderCardTypes.orderDetail,
                                    itemUnit: 2,
                                    size: ' XL',
                                    color: ' black',
                                  ),
                                )
                                .toList());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method. ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  paymentMethod
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address. ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      shippingAddress,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Method. ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  Text(
                    deliveryMethod,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Discount. ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  Text(
                    discount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Total. ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  Text(
                    totalPrice.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Positioned(
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //  width: 150,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.95,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Reorder',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          //  width: 160,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.95,
                                )),
                            child: Center(
                              child: Text(
                                'Leave Feedback',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
