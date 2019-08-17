import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/local_storage_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class AuthNotifier extends NetworkNotifier {
  FirebaseUser _user;
  FirestoreWriter _firestoreWriter;
  StreamSubscription _stream;

  AuthNotifier()
      : _user = Locator.of<AuthService>().currentUser,
        _firestoreWriter = FirestoreWriter() {
    _stream = Locator.of<AuthService>().isUserLoggedOut.listen(logout);
  }

  FirebaseUser get user => _user;
  bool get userIsAuthenticated => _user != null;
  bool get isRegistered =>
      Locator.of<LocalStorageService>().getFromDisk(SIGNUP_STORAGE_KEY) ??
      false;

  @protected
  set user(FirebaseUser value) {
    _user = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _stream.cancel();
    super.dispose();
  }

  Future signUpWithEmail({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>().signUpWithEmail(
        email: email,
        password: password,
      );
      if (user == null) return;
      UserInfoModel model = UserInfoModel(
        givenName: name,
        experienceMonthly: 0,
        experienceOverall: 0,
      );
      await _firestoreWriter.createUser(user.uid, model);
      isLoadingWithoutNotifiers = false;
    } catch (e) {
      print(e);
      error = NetworkError(message: e.runtimeType.toString());
      isLoading = false;
    }
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>().loginWithEmail(
        email: email,
        password: password,
        isSignedUp: isRegistered,
      );
      isLoadingWithoutNotifiers = false;
    } catch (e) {
      print(e);
      error = NetworkError(message: e.runtimeType.toString());
      isLoading = false;
    }
  }

  Future loginWithGoogle() async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>()
          .loginWithGoogle(isSignedUp: isRegistered);
      isLoadingWithoutNotifiers = false;
    } catch (e) {
      print(e);
      error = NetworkError(message: e.runtimeType.toString());
      isLoading = false;
    }
  }

  Future logout(bool loggedOut) async {
    if (loggedOut) user = null;
  }

  @override
  Future fetchData() async {} //Just there for decoration

  @override
  Future onRefresh() async {} //Just there for decoration
}
