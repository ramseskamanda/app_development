import 'dart:async';

import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SignUpFormBloc {
  AuthService _auth;
  BehaviorSubject<String> _name = BehaviorSubject<String>();
  BehaviorSubject<String> _email = BehaviorSubject<String>();
  BehaviorSubject<String> _password = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordConfirm = BehaviorSubject<String>();

  SignUpFormBloc() {
    _auth = locator<AuthService>();
  }

  Sink<String> get name => _name.sink;
  Sink<String> get email => _email.sink;
  Sink<String> get password => _password.sink;
  Sink<String> get confirm => _passwordConfirm.sink;

  Stream<bool> get signup => Observable.combineLatest4(
        _name,
        _email,
        _password,
        _passwordConfirm,
        (String a, String b, String c, String d) =>
            (a != null && b != null && c != null && d != null) &&
            (a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty),
      );

  String passwordValidator(String data) {
    if (_password.value != _passwordConfirm.value)
      return 'Passwords are not identical';
    return null;
  }

  Future<bool> handleSignUp(GlobalKey<FormState> formKey) async {
    bool _validated = formKey.currentState.validate();
    bool _signedUp;
    if (_validated) {
      _signedUp = await _auth.signUpWithEmail(
        info: <String, String>{
          'name': _name.value,
          'email': _email.value,
          'password': _password.value,
        },
      );
    }
    return _signedUp ?? false;
  }

  void dispose() {
    _name.close();
    _email.close();
    _password.close();
    _passwordConfirm.close();
  }
}
