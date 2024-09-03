import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  User? get currentUser;

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password,);
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password,);
    return userCredential.user;
  }
}