import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/theme_manager.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/utilities/router.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeManager.lightTheme,
        
          initialRoute: AppRoutes.navBottomContainerPageRoute,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      ),

    );
  }
}
