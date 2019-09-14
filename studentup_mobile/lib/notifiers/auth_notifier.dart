import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class AuthNotifier extends BaseNetworkNotifier {
  FirebaseUser _user;

  AuthNotifier() : _user = Locator.of<AuthService>().currentUser;

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

  Future signUpWithEmail({
    @required bool isStartup,
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
      if (isStartup) {
        StartupInfoModel model = StartupInfoModel(
          name: name,
          imageUrl: defaultImageUrl,
          creation: DateTime.now(),
        );
        await Locator.of<BaseAPIWriter>().createStartup(user.uid, model);
      } else {
        UserInfoModel model = UserInfoModel(
          givenName: name,
          mediaRef: defaultImageUrl,
        );
        await Locator.of<BaseAPIWriter>().createUser(user.uid, model);
      }
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

  Future loginWithGoogle(bool isStartup) async {
    isLoading = true;
    try {
      user = await Locator.of<AuthService>()
          .loginWithGoogle(isSignedUp: isRegistered);
      if (user == null) return;
      if (Locator.of<AuthService>().currentUserisNew) {
        if (isStartup) {
          StartupInfoModel model = StartupInfoModel(
            name: user.displayName,
            imageUrl: user.photoUrl,
            creation: DateTime.now(),
          );
          await Locator.of<BaseAPIWriter>().createStartup(user.uid, model);
        } else {
          UserInfoModel model = UserInfoModel(
            givenName: user.displayName,
            mediaRef: user.photoUrl,
          );
          await Locator.of<BaseAPIWriter>().createUser(user.uid, model);
        }
      }
      isLoadingWithoutNotifiers = false;
    } catch (e) {
      print(e);
      error = NetworkError(message: e.runtimeType.toString());
      isLoading = false;
    }
  }

  Future logout() async {
    try {
      user = await Locator.of<AuthService>().logout();
    } catch (e) {
      return;
    }
  }
}
