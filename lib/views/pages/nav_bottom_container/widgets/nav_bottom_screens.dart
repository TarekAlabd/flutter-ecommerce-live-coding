import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/pages/screens.dart';

class NavBottomScreen {
  static List<Widget> buildScreens() {
    return _screens;
  }

  static final List<Widget> _screens = [
    HomePage(),
    ShopPage(),
    BagsPage(),
    FavoritesPage(),
    ProfilePage(),
  ];
}
