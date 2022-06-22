import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/models/product_model.dart';
import 'package:flutter_ecommerce/views/pages/home_page/widgets/home_header.dart';
import 'package:flutter_ecommerce/views/pages/home_page/widgets/top_banner.dart';
import 'package:flutter_ecommerce/views/widgets/product_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const TopBanner(),
          HomeHeader(
            mainTitle: 'Sale',
            subTitle: 'Super summer sale',
            viewAll: () {
              debugPrint('pressed');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: size.height * 0.38,
              child: ListView.builder(
                  itemCount: dummyProducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProductItem(
                        product: dummyProducts[index],
                        isNew: false,
                        isFavorite: index % 2 == 0 ? true : false,
                        addToFavorites: () {
                          debugPrint('pressed');
                        });
                  }),
            ),
          ),
          HomeHeader(
            mainTitle: 'New',
            subTitle: 'You’ve never seen it before!',
            viewAll: () {
              debugPrint('pressed');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: size.height * 0.38,
              child: ListView.builder(
                  itemCount: dummyProducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProductItem(
                        product: dummyProducts[index],
                        isNew: true,
                        addToFavorites: () {
                          debugPrint('pressed');
                        });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
