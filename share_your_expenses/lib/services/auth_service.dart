import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_your_expenses/shared/alert_dialog.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService._();
  static final AuthService _service = AuthService._();
  factory AuthService() => _service;

  static AuthService get instance => _service;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        showAlertDialog('Wrong password provided for that user.', context);
      } else {
        showAlertDialog(e.message ?? 'SignIn failed', context);
      }
    } catch (e) {
      showAlertDialog(e.toString(), context);
    }
  }

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDialog(
          'The password provided is too weak.',
          context,
        );
      } else if (e.code == 'email-already-in-use') {
        showAlertDialog(
          'The account already exists for that email.',
          context,
        );
      } else {
        showAlertDialog(
          e.message ?? 'SignUp failed',
          context,
        );
      }
    } catch (e) {
      showAlertDialog(e.toString(), context);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
