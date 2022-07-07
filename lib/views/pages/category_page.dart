import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/shared/custom_app_bar.dart';

import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../utilities/enums.dart';
import '../widgets/custom_buttons/dark_button.dart';
   import '../widgets/product_widgets/gridview_product_widget.dart';
import '../widgets/product_widgets/listview_product_widget.dart';
 
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key, required this.categoryObj}) : super(key: key);
  final Category categoryObj;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var viewType = ViewType.listView;
  FilterType filterType = FilterType.priceLowestToHigh;
  String? filterTypeLabel = "Price Lowest To High";
  @override
  Widget build(BuildContext context) {
    List<Category?> subCategoriesList = [
      Category("0", "T-shirts", "imageUrl"),
      Category("0", "Skirts", "imageUrl"),
      Category("0", "Tops", "imageUrl"),
      Category("0", "Dresses", "imageUrl"),
      Category("0", "Trousers", "imageUrl"),
    ];
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoryObj.name,
        hasBackNav: true,
        backNavEvent: () => Navigator.of(context).pop(),
        hasBottomContent: true,
        bottomContent:  _buildAppBarBottom(context, subCategoriesList),
        hasIcon: true,
        icon: const Icon(Icons.search_outlined),
        iconEvent: () {},
      ).build(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height: 900,
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
                        return viewType == ViewType.gridView
                            ? GridView.count(
                                // Create a grid with 2 columns. If you change the scrollDirection to
                                // horizontal, this produces 2 rows.
                                crossAxisCount: 2,

                                // Generate 100 widgets that display their index in the List.
                                children:
                                    List.generate(productslist.length, (index) {
                                  return GridViewProductWidget(
                                      product: productslist[index]);
                                }),
                              )
                            : ListView(
                                //scrollDirection: Axis.horizontal,
                                children: productslist
                                    .map((e) =>
                                        ListViewProductWidget(product: e))
                                    .toList());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBarBottom(
      BuildContext context, List<Category?> subCategoriesList) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
          110), // change height depending on the child height
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _buildSubCategoriesListView(context, subCategoriesList),
            _buildFilterSortView(context),
            const SizedBox(
              height: 7,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSubCategoriesListView(
      BuildContext context, List<Category?> subCategoriesList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Expanded(
        child: Row(
          children: subCategoriesList.map((option) {
            return Padding(
              padding: const EdgeInsets.all(
                7.0,
              ),
              child: DarkButton(
                onTapAction: () {},
                label_: option!.name,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterSortView(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 45,
      width: width,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.06)),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.35,
                child: InkWell(
                  child: Row(
                    children: const [
                      Icon(Icons.sort),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Filters'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: InkWell(
                  onTap: () => _showFilterList(context),
                  child: Row(
                    children: [
                      Stack(
                        children: const [
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 12),
                            child: Icon(Icons.arrow_downward),
                          )
                        ],
                      ),
                      Text(filterTypeLabel!),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    if (viewType == ViewType.listView) {
                      viewType = ViewType.gridView;
                    } else {
                      viewType = ViewType.listView;
                    }
                  });
                },
                child: Icon(
                  viewType == ViewType.listView ? Icons.grid_4x4 : Icons.list,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterList(BuildContext context) {
    //DISPLAY MODAL
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Sort By',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )),
                  const Spacer(),
                  _buildFilterListItem(context, 'Popular', FilterType.popular),
                  _buildFilterListItem(context, 'Newest', FilterType.newest),
                  _buildFilterListItem(
                      context, 'Customers Review', FilterType.customerReview),
                  _buildFilterListItem(context, 'Price :Lowest to High',
                      FilterType.priceLowestToHigh),
                  _buildFilterListItem(context, 'Price :Highest to Low',
                      FilterType.priceHighestToLow),
                ],
              ),
            ),
          );
        });
  
  }

  Widget _buildFilterListItem(
      BuildContext context, String key, FilterType value) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: SizedBox(
          height: 40,
          child: Text(
            key,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.grey),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          filterType = value;
          filterTypeLabel = key;
          //HIDE MODAL
          Navigator.pop(context);
        });
      },
    );
  }
}

