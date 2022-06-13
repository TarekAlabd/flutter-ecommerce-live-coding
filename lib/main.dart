import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/theme_manager.dart';
import 'package:flutter_ecommerce/utilities/router.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeManager.lightTheme,
      onGenerateRoute: onGenerate,
      initialRoute: AppRoutes.navBottomContainerPageRoute,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
