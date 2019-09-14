import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  bool _isNewUser = false;

  FirebaseUser get currentUser => _currentUser;
  Stream<bool> get isUserLoggedOut =>
      _auth.onAuthStateChanged.map((user) => user == null);
  bool get currentUserisNew => _isNewUser;

  Future<void> attemptAutoLogin() async =>
      _currentUser = await _auth.currentUser();

  Future<FirebaseUser> signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
        Locator.of<AnalyticsService>().logger.logSignUp(signUpMethod: 'Email');
        _isNewUser = true;
        _currentUser = result.user;
      }
      return result.user;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> loginWithEmail({
    @required String email,
    @required String password,
    bool isSignedUp = false,
  }) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result?.additionalUserInfo?.isNewUser ?? false || !isSignedUp)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
      Locator.of<AnalyticsService>().logger.logLogin(loginMethod: 'Email');
      _currentUser = result.user;
      return result.user;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> loginWithGoogle({bool isSignedUp = false}) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      if (result?.additionalUserInfo?.isNewUser ?? false) _isNewUser = true;
      if (!isSignedUp)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);

      if (_isNewUser)
        Locator.of<AnalyticsService>().logger.logSignUp(signUpMethod: 'Google');
      Locator.of<AnalyticsService>().logger.logLogin(loginMethod: 'Google');
      _currentUser = result.user;
      return result.user;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _currentUser = null;
    return null;
  }
}
