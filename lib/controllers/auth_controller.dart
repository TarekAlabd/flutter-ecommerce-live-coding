import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/utilities/constants.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;
  // TODO: It's not a best practice thing but it's temporary
  final database = FirestoreDatabase('123');

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        final user = await auth.signUpWithEmailAndPassword(email, password);
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: email,
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
