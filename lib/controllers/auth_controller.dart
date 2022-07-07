import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthTypes authFormType;

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFormType = AuthTypes.login,
  });

  Future<void> submit() async {
    try {
      if (authFormType == AuthTypes.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = authFormType == AuthTypes.login
        ? AuthTypes.register
        : AuthTypes.login;
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
    AuthTypes? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }
  Future<void> logout() async {
    try {
      await auth.logout;
    } catch (ex) {
      debugPrint('exception : $ex');
      rethrow;
    }
  }
}
