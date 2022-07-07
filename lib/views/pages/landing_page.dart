import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/database_controller.dart';
import '../../services/auth.dart';
import 'auth_page.dart';
import 'bottom_navbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            var targetActivity;
            if (user == null) {
              targetActivity = const AuthPage();
            } else {
              targetActivity = Provider<Database>(
                  create: (_) => FirestoreDatabase(user.uid),
                  child: const BottomNavBar());
            }
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: targetActivity,
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
