import 'dart:async';

import 'package:rxdart/rxdart.dart';

class LoginFormBloc {
  BehaviorSubject<String> _email = BehaviorSubject<String>();
  BehaviorSubject<String> _password = BehaviorSubject<String>();

  Sink<String> get email => _email.sink;
  Sink<String> get password => _password.sink;

  String get emailValue => _email.value;
  String get passwordValue => _password.value;

  Stream<bool> get login => Observable.combineLatest2(
        _email,
        _password,
        (String a, String b) =>
            (a != null && b != null) && (a.isNotEmpty && b.isNotEmpty),
      );

  void dispose() {
    _email.close();
    _password.close();
  }
}
