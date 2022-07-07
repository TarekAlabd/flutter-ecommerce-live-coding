import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product_model.dart';
import '../../utilities/assets.dart';
 import '../widgets/product_widgets/gridview_product_widget.dart';
import 'shop_page.dart';
 
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * 0.3,
                color: Colors.grey.withOpacity(0.9),
                colorBlendMode: BlendMode.modulate,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 25.0),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _buildListViewHeader(
                    context,
                    "Sale",
                    "Super Summer Sale",
                    "View All",
                    () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopPage()),
                        (r) => false)),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.salesPproductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final productslist = snapshot
                              .data; //?.where((element) => element.discount > 0);
                          if (productslist == null || productslist.isEmpty) {
                            return const Center(
                              child: Text('No Data Avilable'),
                            );
                          }
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: productslist
                                  .map((e) => GridViewProductWidget(product: e))
                                  .toList());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
                // _buildListViewContent(),
                _buildListViewHeader(context, "New",
                    "You haven\'t never seen before !", "View All", () {}),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.newProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final productslist = snapshot
                              .data; //?.where((element) => element.discount > 0);
                          if (productslist == null || productslist.isEmpty) {
                            return const Center(
                              child: Text('No Data Avilable'),
                            );
                          }
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: productslist
                                  .map((e) => GridViewProductWidget(product: e))
                                  .toList());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _buildListViewHeader(BuildContext context, String title,
      String subTitle, String subTitleLink, VoidCallback subTitleLinkEvent) {
    return Row(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
          Text(subTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.grey, fontSize: 15)),
        ]),
        const Spacer(),
        InkWell(
          child: Text(
            subTitleLink,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.black87, fontSize: 15),
          ),
          onTap: subTitleLinkEvent,
        )
      ],
    );
  }

  static Widget _buildListViewContent() {
    final List<Widget> listItems = [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [])
    ];
    return Column(
      children: [
        ListView(scrollDirection: Axis.horizontal, children: [Text('data')]),
      ],
    );
  }
}
