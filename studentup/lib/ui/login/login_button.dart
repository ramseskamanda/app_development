import 'package:provider/provider.dart';
import 'package:studentup/bloc/login_form_bloc.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:flutter/material.dart';
import 'package:studentup/routers/global_router.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final LoginFormBloc bloc;
  LoginButton({Key key, @required this.bloc, @required this.formKey})
      : super(key: key);
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  Future<void> _handleLogin(AuthenticationNotifier auth) async {
    bool _validated = widget.formKey.currentState.validate();
    bool _loggedIn = await auth.loginWithEmail(
      email: widget.bloc.emailValue,
      password: widget.bloc.passwordValue,
    );
    if (_validated && _loggedIn)
      Provider.of<GlobalRouter>(context)
          .push(GlobalRouter.homeRoute, replaceCurrentView: true);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier _auth = Provider.of<AuthenticationNotifier>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<bool>(
              stream: widget.bloc.login,
              builder: (context, snapshot) {
                return RaisedButton(
                  child: const Text('Sign In'),
                  onPressed: ((snapshot.data ?? false) && !_auth.isLoading)
                      ? () => _handleLogin(_auth)
                      : null,
                );
              }),
        ),
      ],
    );
  }
}
