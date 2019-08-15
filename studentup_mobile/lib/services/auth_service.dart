import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentup_mobile/services/local_storage_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;

  Future<void> attemptAutoLogin() async =>
      _currentUser = await _auth.currentUser();

  Future<FirebaseUser> signUpWithEmail({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
      return result.user;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      if (result.additionalUserInfo.isNewUser)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
      return result.user;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    return null;
  }
}
