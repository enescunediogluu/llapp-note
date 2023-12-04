import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign Up
  Future signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      log('Error: $e');
    }
  }

// Sign In
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      log('Error: $e');
      return e.message;
    }
  }

// Sign Out
  Future<void> signOut() async {
    await auth.signOut();
  }
}
