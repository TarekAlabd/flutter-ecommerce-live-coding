import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBottomItems {
  static List<PersistentBottomNavBarItem> navBarsItems() {
    return _items;
  }

  static final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.home,
      ),
      title: ("Home"),
      activeColorPrimary: ColorManager.kRed,
      inactiveColorPrimary: ColorManager.kGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.shopping_cart,
      ),
      title: ("Shop"),
      activeColorPrimary: ColorManager.kRed,
      inactiveColorPrimary: ColorManager.kGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.bag,
      ),
      title: ("Bag"),
      activeColorPrimary: ColorManager.kRed,
      inactiveColorPrimary: ColorManager.kGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.heart,
      ),
      title: ("Favorite"),
      activeColorPrimary: ColorManager.kRed,
      inactiveColorPrimary: ColorManager.kGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.person_fill,
      ),
      title: ("Profile"),
      activeColorPrimary: ColorManager.kRed,
      inactiveColorPrimary: ColorManager.kGrey,
    ),
  ];
}
