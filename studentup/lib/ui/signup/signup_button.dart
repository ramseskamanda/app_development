import 'package:studentup/bloc/signup_form_bloc.dart';
import 'package:studentup/router.dart';
import 'package:studentup/util/env.dart';
import 'package:studentup/util/login_types.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SignUpFormBloc bloc;
  SignUpButton({Key key, @required this.formKey, @required this.bloc})
      : super(key: key);
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  Future<void> _handleRegistration() async {
    bool _proceed = await Navigator.of(context).pushNamed(
          Router.disclaimer,
          arguments: LoginType.email,
        ) ??
        false;
    if (!_proceed) return;
    bool _success = await widget.bloc.handleSignUp(widget.formKey);
    if (_success) {
      Navigator.of(context).pushReplacementNamed(Router.homeRoute);
    } else {
      _showFailedRegistration();
    }
  }

  void _showFailedRegistration() {
    Flushbar(
      duration: const Duration(seconds: 2),
      title: 'Failed Registration',
      icon: Icon(Icons.error),
      leftBarIndicatorColor: Colors.redAccent,
      message: Environment.failedRegistrationMessage,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<bool>(
            stream: widget.bloc.signup,
            builder: (context, snapshot) {
              return RaisedButton(
                child: const Text('Register'),
                onPressed:
                    (snapshot.data ?? false) ? _handleRegistration : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
