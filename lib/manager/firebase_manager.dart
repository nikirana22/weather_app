import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool get hasUserLogin => currentUser != null;

  static Future<void> loginWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signupWithEmail(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
