import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/shared/custom_app_bar.dart';

import '../../models/category_model.dart';
import '../../utilities/colors.dart';
import 'category_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //backgroundColor: Colors.white,
        // drawerScrimColor: primaryColor,
        // resizeToAvoidBottomInset :false,
        appBar: CustomAppBar(
            title: 'Categories',
            hasIcon: true,
            icon: const Icon(Icons.search_outlined),
            iconEvent: () {},
            hasBackNav: true,
            backNavEvent: () => Navigator.of(context).pop(),
            hasBottomContent: true,
            bottomContent: const TabBar(
              labelColor: Colors.black,
              indicatorColor: primaryColor,
              indicatorWeight: 4.5,
              tabs: [
                Tab(
                  //icon: Icon(Icons.female),
                  text: 'Women',
                ),
                Tab(
                  // icon: Icon(Icons.male),
                  text: 'Men',
                ),
                Tab(
                  // icon: Icon(Icons.chi),
                  text: 'Kids',
                ),
              ],
            )).build(context),
        body: TabBarView(
          children: [
            CustomTabBarView.build('Women', context),
            CustomTabBarView.build('Men', context),
            CustomTabBarView.build('Kids', context),
          ],
        ),
      ),
    );
  }
}

class CustomTabBarView {
  static Widget build(String categoryName, BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Summer Sales',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Up Tp 50% offer',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              CategoryItemView.build(
                  Category("", "Shoes",
                      "https://images.footway.com/'wt_media'/1654256348960_SUMMER_SHOES.jpg?auto=format%2Ccompress&ar=100%3A100&dpr=1&fit=crop&ixlib=react-13.0.4&w=1076"),
                  context),
              CategoryItemView.build(
                  Category("", "Clothes",
                      "https://media.istockphoto.com/photos/women-clothes-hanging-on-hangers-clothing-rails-fashion-design-picture-id916092484?s=612x612"),
                  context),
              CategoryItemView.build(
                  Category("", "Accessories",
                      "https://cf2.s3.souqcdn.com/item/2018/08/19/37/06/48/43/item_XL_37064843_145037135.jpg"),
                  context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItemView {
  static Widget build(Category model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      categoryObj: model,
                    ))),
        child: SizedBox(
          height: 130,
          width: double.infinity,
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        model.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1.0),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        model.imageUrl,
                        fit: BoxFit.fill,

                        //  width: 120,
                        height: double.infinity,
                        // color: Colors.grey.withOpacity(0.9),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
