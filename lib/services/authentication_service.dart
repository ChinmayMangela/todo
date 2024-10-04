import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/services/user_service.dart';
import 'package:todo/utils/helper_functions.dart';

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userService = UserService();

  Future<UserCredential?> logInWithEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar('Wrong password provided for that user.');
      } else {
        Utils.showSnackBar('Error signing in: ${e.message}');
      }
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _userService.addUser(email: email);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      Utils.showSnackBar('Reset password link has been set to the email');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> sendEmailVerificationLink() async {
    try {
      _firebaseAuth.currentUser!.sendEmailVerification();
      Utils.showSnackBar('Email verification link has been sent to the email');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
