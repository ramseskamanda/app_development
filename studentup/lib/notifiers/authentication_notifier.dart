import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentup/notifiers/base_notifier.dart';
import 'package:flutter/services.dart';
import 'package:studentup/services/local_storage_service.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/util/env.dart';

class AuthenticationNotifier extends BaseNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  LocalStorageService storageService;

  bool _hasSignedUp;
  bool _isLoggedIn;

  AuthenticationNotifier() {
    _init();
  }

  Future<void> _init() async {
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    storageService = locator<LocalStorageService>();
    _hasSignedUp = storageService.getFromDisk(Environment.signedUpKey) ?? false;
    _isLoggedIn = (await _auth.currentUser()) != null;
  }

  bool get hasSignedUp => _hasSignedUp;
  set hasSignedUp(bool value) =>
      storageService.saveToDisk(Environment.signedUpKey, value);
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> signUpWithEmail({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    try {
      isLoading = true;
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        UserUpdateInfo _updateInfo = UserUpdateInfo()..displayName = name;
        user?.updateProfile(_updateInfo);
        hasSignedUp = true;
      }
      isLoading = false;
      return user != null;
    } on PlatformException catch (e) {
      isLoading = false;
      error = e.code;
      return false;
    } catch (ue) {
      print(ue.runtimeType);
      isLoading = false;
      return false;
    }
  }

  Future<bool> handleAutoLogin() async {
    isLoading = true;
    FirebaseUser _user = await _auth.currentUser();
    isLoading = false;
    return _user != null;
  }

  Future<bool> loginWithGoogle() async {
    try {
      isLoading = true;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);

      if (user != null) hasSignedUp = true;
      isLoading = false;

      return user != null;
    } on PlatformException catch (e) {
      error = e.code;
      isLoading = false;
      return false;
    } catch (unexpectedError) {
      print(unexpectedError.runtimeType);
      isLoading = false;
      return false;
    }
  }

  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      isLoading = true;
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) hasSignedUp = true;
      return user != null;
    } on PlatformException catch (e) {
      isLoading = false;
      error = e.code;
      return false;
    } catch (unexpectedError) {
      print(unexpectedError.runtimeType);
      isLoading = false;
      return false;
    }
  }

  void logout() {
    _auth.signOut();
    _googleSignIn.signOut();
  }
}
