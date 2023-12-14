import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  Future<bool> loginPage(
    String username,
    String password,
  ) async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
          email: username, password: password);
      print('login successfull');
      return true;
    } on FirebaseAuthException catch (e) {
      throw e.code;
      print('login failed');
    }
  }
}
