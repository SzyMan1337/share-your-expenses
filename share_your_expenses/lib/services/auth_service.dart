import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_your_expenses/shared/alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog(l10n!.userNotFoundEmail, context);
      } else if (e.code == 'wrong-password') {
        showAlertDialog(l10n!.wrongPassword, context);
      } else {
        showAlertDialog(e.message ?? l10n!.signInFailed, context);
      }
    } catch (e) {
      showAlertDialog(e.toString(), context);
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDialog(
          l10n!.weakPassword,
          context,
        );
      } else if (e.code == 'email-already-in-use') {
        showAlertDialog(
          l10n!.accountExistsEmail,
          context,
        );
      } else {
        showAlertDialog(
          e.message ?? l10n!.signUpFailed,
          context,
        );
      }
    } catch (e) {
      showAlertDialog(e.toString(), context);
    }
    return null;
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
