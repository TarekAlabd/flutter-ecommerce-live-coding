import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/cart/listview_cart_widget.dart';
import 'package:flutter_ecommerce/views/widgets/cart/promocode_button.dart';
import 'package:flutter_ecommerce/views/widgets/shared/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product_model.dart';
import '../widgets/custom_buttons/primary_button.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: CustomAppBar(
              hasBackNav: false,
              hasBottomContent: false,
              hasIcon: true,
              icon: const Icon(Icons.search),
              title: "My Bag")
          .build(context),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 450,
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
                          children: productslist
                              .map((e) => ListViewCartWidget(product: e))
                              .toList());
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
              child: Column(
                children: [
                  Stack(alignment: Alignment.centerRight, children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Promocode',
                              hintText: 'Enter Promocode here'),
                        ),
                      ),
                    ),
                    PromocodeButton.build(context),
                  ]),

                  
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Text(
                        'Total Amount:',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        '500',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: PrimaryButton(
                        label_: "Check out",
                        onTapAction: () {},
                      ).build(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
