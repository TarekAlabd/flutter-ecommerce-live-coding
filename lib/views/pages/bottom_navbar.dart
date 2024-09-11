import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/cart/cart_cubit.dart';
import 'package:flutter_ecommerce/controllers/home/home_cubit.dart';
import 'package:flutter_ecommerce/views/pages/cart_page.dart';
import 'package:flutter_ecommerce/views/pages/home_page.dart';
import 'package:flutter_ecommerce/views/pages/profle_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) {
          final cubit = HomeCubit();
          cubit.getHomeContent();
          return cubit;
        },
        child: const HomePage(),
      ),
      Container(),
      BlocProvider(
        create: (context) {
          final cubit = CartCubit();
          cubit.getCartItems();
          return cubit;
        },
        child: const CartPage(),
      ),
      Container(),
      const ProfilePage()
    ];
  }

  // List<PersistentTabConfig> _navBarsItems() {
  //   return [
  //     PersistentTabConfig(
  //       icon: const Icon(CupertinoIcons.home),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentTabConfig(
  //       icon: const Icon(CupertinoIcons.bag),
  //       title: ("Shop"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentTabConfig(
  //       icon: const Icon(CupertinoIcons.shopping_cart),
  //       title: ("Cart"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentTabConfig(
  //       icon: const Icon(Icons.favorite_border),
  //       title: ("Favorites"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentTabConfig(
  //       icon: const Icon(CupertinoIcons.profile_circled),
  //       title: ("Profile"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _bottomNavbarController,
        tabs: [
          PersistentTabConfig(
            screen: _buildScreens()[0],
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.home),
              title: ("Home"),
              activeForegroundColor: Colors.redAccent,
              // activeColorPrimary: CupertinoColors.activeBlue,
              // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ),
          PersistentTabConfig(
            screen: _buildScreens()[1],
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.bag),
              title: ("Shop"),
              activeForegroundColor: Colors.redAccent,
              // activeColorPrimary: CupertinoColors.activeBlue,
              // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ),
          PersistentTabConfig(
            screen: _buildScreens()[2],
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.shopping_cart),
              title: ("Cart"),
              activeForegroundColor: Colors.redAccent,
              // activeColorPrimary: CupertinoColors.activeBlue,
              // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ),
          PersistentTabConfig(
            screen: _buildScreens()[3],
            item: ItemConfig(
              icon: const Icon(Icons.favorite_border),
              title: ("Favorites"),
              activeForegroundColor: Colors.redAccent,
              // activeColorPrimary: CupertinoColors.activeBlue,
              // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ),
          PersistentTabConfig(
            screen: _buildScreens()[4],
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.profile_circled),
              title: ("Profile"),
              activeForegroundColor: Colors.redAccent,
              // activeColorPrimary: CupertinoColors.activeBlue,
              // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ),
        ],
        navBarBuilder: (navbarConfig) => Style1BottomNavBar(
          navBarConfig: navbarConfig,
        ),
        // screens: _buildScreens(),
        // items: _navBarsItems(),
        // confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        // hideNavigationBarWhenKeyboardShows:
        //     true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        // decoration: NavBarDecoration(
        //   borderRadius: BorderRadius.circular(10.0),
        //   colorBehindNavBar: Colors.white,
        // ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        // itemAnimationProperties: ItemAnimationProperties(
        //   // Navigation Bar's items animation properties.
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.ease,
        // ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          // animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        // navBarStyle:
        //     NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
