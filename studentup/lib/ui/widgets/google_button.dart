import 'package:studentup/router.dart';
import 'package:studentup/services/authentication_service.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/util/env.dart';
import 'package:studentup/util/login_types.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  Future<void> _onPressed(BuildContext context) async {
    bool _proceed = await Navigator.of(context).pushNamed(
      Router.disclaimer,
      arguments: LoginType.google,
    );
    if (!_proceed) return;

    AuthService _auth = locator<AuthService>();
    bool _success = await _auth.loginWithGoogle();
    if (_success)
      Navigator.pushReplacementNamed(context, Router.homeRoute);
    else
      _showErrorMessage(context);
  }

  void _showErrorMessage(BuildContext context) {
    Flushbar(
      duration: const Duration(seconds: 2),
      title: 'Authentication Failure',
      message: Environment.failedAuthenticationMessage,
      icon: Icon(Icons.error),
      leftBarIndicatorColor: Colors.amberAccent,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      child: const Text('Google'),
      onPressed: () => _onPressed(context),
    );
  }
}
