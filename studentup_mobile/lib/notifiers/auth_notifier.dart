import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/local_storage_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isLoading;
  Object _error;
  FirebaseUser _user;

  AuthNotifier()
      : _user = Locator.of<AuthService>().currentUser,
        _isLoading = false;

  FirebaseUser get user => _user;
  bool get userIsAuthenticated => _user != null;
  bool get needsRegistration =>
      Locator.of<LocalStorageService>().getFromDisk(SIGNUP_STORAGE_KEY) ?? true;
  bool get isLoading => _isLoading;
  bool get hasError => _error != null;
  Object get error => _error;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set error(Object value) {
    _error = value;
    notifyListeners();
  }

  @protected
  set user(FirebaseUser value) {
    _user = value;
    notifyListeners();
  }

  Future signUpWithEmail({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>().signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      _isLoading = false;
    } catch (e) {
      print(e);
      error = e.runtimeType;
      isLoading = false;
    }
  }

  Future loginWithGoogle() async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>().loginWithGoogle();
      _isLoading = false;
    } catch (e) {
      print(e);
      error = e.runtimeType;
      isLoading = false;
    }
  }

  Future logout() async {
    try {
      user = await Locator.of<AuthService>().logout();
    } catch (e) {
      print(e);
    }
  }
}
