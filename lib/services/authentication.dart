/*External dependencies */
import 'package:firebase_auth/firebase_auth.dart';
/*Local dependencies */
import 'package:finik/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create user
  Future<UserModel?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  //login user
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
    return null;
  }

  //forgot password
  Future<UserModel?> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
    return null;
  }

  //signOut user
  Future<void> signOut() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
