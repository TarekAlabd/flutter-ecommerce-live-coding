import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/pages/landing_page.dart';
import 'package:flutter_ecommerce/views/pages/screens.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.navBottomContainerPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const NavigationBottomContainer(),
      );
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
      );
  }
}
