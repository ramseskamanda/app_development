import 'dart:async';
import 'package:studentup/services/local_storage_service.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/util/env.dart';
import 'package:studentup/util/error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class AuthService {
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;
  LocalStorageService storageService;

  bool _hasSignedUp;
  bool _isLoggedIn;

  AuthService() {
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    storageService = locator<LocalStorageService>();
    _hasSignedUp = storageService.getFromDisk(Environment.signedUpKey) ?? false;
    _isLoggedIn = _auth.currentUser() != null;
  }

  bool get hasSignedUp => _hasSignedUp;
  set hasSignedUp(bool value) =>
      storageService.saveToDisk(Environment.signedUpKey, value);
  bool get isLoggedIn => _isLoggedIn;
  Future<FirebaseUser> get currentUser async => _auth.currentUser();

  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        hasSignedUp = true;
        return true;
      } else
        return false;
    } on PlatformException catch (e) {
      //e.code is the actual indicator
      //e.details is null
      //e.message could be a useful message to show to users
      ErrorMessage _error = ErrorMessage(
        code: e.code,
        details: e.message,
        stack: 'AuthService.loginWithEmail',
        importance: ErrorImportance.none,
      );
      print(_error);
      return false;
    } catch (ue) {
      print(ue.runtimeType);
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);
      if (user != null) {
        hasSignedUp = true;
        return true;
      } else
        return false;
    } on PlatformException catch (e) {
      //e.code is the actual indicator
      //e.details is null
      //e.message could be a useful message to show to users
      ErrorMessage _error = ErrorMessage(
        code: e.code,
        details: e.message,
        stack: 'AuthService.loginWithGoogle',
        importance: ErrorImportance.none,
      );
      print(_error);
      return false;
    } catch (ue) {
      print(ue.runtimeType);
      return false;
    }
  }

  Future<bool> signUpWithEmail({@required Map<String, String> info}) async {
    assert(info.containsKey('name'));
    assert(info.containsKey('email'));
    assert(info.containsKey('password'));
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: info['email'],
        password: info['password'],
      );
      UserUpdateInfo _updateInfo = UserUpdateInfo()..displayName = info['name'];
      user?.updateProfile(_updateInfo);
      if (user != null) {
        hasSignedUp = true;
        return true;
      } else
        return false;
    } on PlatformException catch (e) {
      ErrorMessage _error = ErrorMessage(
        code: e.code,
        details: e.message,
        stack: 'AuthService.signUpWithEmail',
        importance: ErrorImportance.none,
      );
      print(_error);
      return false;
    } catch (ue) {
      print(ue.runtimeType);
      return false;
    }
  }

  Future<void> logout() async {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  void dispose() {
    print('disposing of AuthService');
  }
}
