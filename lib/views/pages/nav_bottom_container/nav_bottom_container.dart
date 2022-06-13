import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/pages/nav_bottom_container/widgets/nav_bottom_items.dart';
import 'package:flutter_ecommerce/views/pages/nav_bottom_container/widgets/nav_bottom_screens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavigationBottomContainer extends StatefulWidget {
  const NavigationBottomContainer({Key? key}) : super(key: key);

  @override
  State<NavigationBottomContainer> createState() =>
      _NavigationBottomContainerState();
}

class _NavigationBottomContainerState extends State<NavigationBottomContainer> {
  final PersistentTabController _controller = PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context,
          controller: _controller,
          screens: NavBottomScreen.buildScreens(),
          items: NavBottomItems.navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style11 // Choose the nav bar style with this property.
          ),
    );
  }
}
