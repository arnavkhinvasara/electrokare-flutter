import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Get the current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // Check if user is logged in
  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Sign up a new user
  Future<String> signup({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Signup successful';
    } on FirebaseAuthException catch (e) {
      return "Email already in use";
    }
  }

  // Login a user
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login successful';
    } on FirebaseAuthException catch (e) {
      return "Login credentials are incorrect";
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //Deletes the currently authenticated user account
  Future<String> deleteAccount() async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return 'No user is currently logged in';
      }

      // Delete the user account
      await user.delete();
      return 'Account deleted successfully';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return 'Please log in again before deleting your account';
      } else {
        return 'Error deleting account: ${e.message}';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }
}
