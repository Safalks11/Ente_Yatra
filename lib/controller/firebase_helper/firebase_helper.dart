import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  // To get the current user
  get user => FirebaseAuth.instance.currentUser;

  //Register User
  Future<String?> register(
      {required String regEmail, required String regPass}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: regEmail, password: regPass);
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  //Login User

  Future<String?> login(
      {required String loginEmail, required String loginPass}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: loginEmail, password: loginPass);
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<List<String>> checkEmailExistence(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      return signInMethods;
    } catch (e) {
      print("Error checking email existence: $e");
      // Handle error or return an empty list
      return [];
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    }
  }
}
