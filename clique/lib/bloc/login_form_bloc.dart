import 'dart:async';

import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginFormBloc {
  AuthService _auth;
  BehaviorSubject<String> _email = BehaviorSubject<String>();
  BehaviorSubject<String> _password = BehaviorSubject<String>();

  LoginFormBloc() {
    _auth = locator<AuthService>();
  }

  Sink<String> get email => _email.sink;
  Sink<String> get password => _password.sink;

  Stream<bool> get login => Observable.combineLatest2(
        _email,
        _password,
        (String a, String b) =>
            (a != null && b != null) && (a.isNotEmpty && b.isNotEmpty),
      );

  Future<bool> handleLogin(GlobalKey<FormState> formKey) async {
    bool _validated = formKey.currentState.validate();
    bool _loggedIn;
    if (_validated) {
      _loggedIn = await _auth.loginWithEmail(
        email: _email.value,
        password: _password.value,
      );
    }
    return _loggedIn ?? false;
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}
