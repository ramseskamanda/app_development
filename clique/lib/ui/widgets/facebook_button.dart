import 'package:clique/router.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/util/env.dart';
import 'package:clique/util/login_types.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FacebookButton extends StatefulWidget {
  @override
  _FacebookButtonState createState() => _FacebookButtonState();
}

class _FacebookButtonState extends State<FacebookButton> {
  Future<void> _onPressed(BuildContext context) async {
    bool _proceed = await Navigator.of(context).pushNamed(
      Router.disclaimer,
      arguments: LoginType.facebook,
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
      child: const Text('Facebook'),
      color: Color(0xFF3b5998),
      onPressed: () => _onPressed(context),
    );
  }
}
