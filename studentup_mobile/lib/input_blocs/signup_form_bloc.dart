import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SignUpFormBloc {
  BehaviorSubject<String> _name = BehaviorSubject<String>();
  BehaviorSubject<String> _email = BehaviorSubject<String>();
  BehaviorSubject<String> _password = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordConfirm = BehaviorSubject<String>();

  Sink<String> get name => _name.sink;
  Sink<String> get email => _email.sink;
  Sink<String> get password => _password.sink;
  Sink<String> get confirm => _passwordConfirm.sink;

  String get nameValue => _name.value;
  String get emailValue => _email.value;
  String get passwordValue => _password.value;

  Stream<bool> get signup => Observable.combineLatest4(
        _name,
        _email,
        _password,
        _passwordConfirm,
        (String a, String b, String c, String d) =>
            (a != null && b != null && c != null && d != null) &&
            (a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty),
      );

  Stream<bool> get signin => Observable.combineLatest2(
        _email,
        _password,
        (String a, String b) =>
            (a != null && b != null) && (a.isNotEmpty && b.isNotEmpty),
      );

  String passwordValidator(String data) {
    if (_password.value != _passwordConfirm.value)
      return 'Passwords are not identical';
    return null;
  }

  void dispose() {
    _name.close();
    _email.close();
    _password.close();
    _passwordConfirm.close();
  }
}
