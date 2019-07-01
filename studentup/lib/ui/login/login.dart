import 'dart:async';

import 'package:studentup/bloc/login_form_bloc.dart';
import 'package:studentup/router.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/ui/login/login_button.dart';
import 'package:studentup/ui/widgets/widgets.dart';
import 'package:studentup/util/env.dart';
import 'package:studentup/util/error_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  final ErrorMessage error;
  Login({Key key, this.error}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginFormBloc bloc;

  GlobalKey<FormState> _key;

  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    if (widget.error != null) {
      Timer(const Duration(seconds: 1), _showErrorDialog);
    }
    _key = GlobalKey<FormState>();
    bloc = locator<LoginFormBloc>();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordNode.dispose();
    bloc.dispose();
    super.dispose();
  }

  void _showErrorDialog() {
    if (widget.error.importance == ErrorImportance.fatal) {
      Timer(
        const Duration(seconds: 30),
        () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      );
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('A Fatal Error Occured.'),
            content: Text(Environment.fatalErrorMessage),
            actions: <Widget>[
              FlatButton(
                child: const Text('O.K.'),
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              )
            ],
          );
        },
      );
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${widget.error.code}'),
            content: Text('${widget.error.details}'),
            actions: <Widget>[
              FlatButton(
                child: const Text('O.K.'),
                onPressed: Navigator.of(context).pop,
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildHeroLogo() {
    return Hero(
      tag: Environment.logoHeroTag,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.134,
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildRegistrationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Don\'t have an account yet? '),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(Router.signupRoute),
          child: Text(
            'Register now!',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: _key,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.86,
              child: Column(
                children: <Widget>[
                  Spacer(flex: 3),
                  _buildHeroLogo(),
                  Spacer(),
                  EmailTextFormField(
                    sink: bloc.email,
                    nextNode: _passwordNode,
                  ),
                  SizedBox(height: 16.0),
                  PasswordTextFormField(
                    sink: bloc.password,
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GoogleButton(),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FacebookButton(),
                      ),
                    ],
                  ),
                  LoginButton(
                    bloc: bloc,
                    formKey: _key,
                  ),
                  _buildRegistrationButton(),
                  Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
