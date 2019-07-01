import 'package:studentup/bloc/login_form_bloc.dart';
import 'package:studentup/router.dart';
import 'package:studentup/util/env.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final LoginFormBloc bloc;
  LoginButton({Key key, @required this.bloc, @required this.formKey})
      : super(key: key);
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  Future<void> _handleLogin() async {
    bool _success = await widget.bloc.handleLogin(widget.formKey);
    if (_success)
      Navigator.pushReplacementNamed(context, Router.homeRoute);
    else
      _showErrorMessage();
  }

  void _showErrorMessage() {
    Flushbar(
      duration: const Duration(seconds: 2),
      title: 'Failed Login',
      icon: Icon(Icons.error),
      leftBarIndicatorColor: Colors.deepOrangeAccent,
      message: Environment.failedLoginMessage,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<bool>(
              stream: widget.bloc.login,
              builder: (context, snapshot) {
                return RaisedButton(
                  child: const Text('Sign In'),
                  onPressed: (snapshot.data ?? false) ? _handleLogin : null,
                );
              }),
        ),
      ],
    );
  }
}
