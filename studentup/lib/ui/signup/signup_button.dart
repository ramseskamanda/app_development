import 'package:provider/provider.dart';
import 'package:studentup/bloc/signup_form_bloc.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/routers/global_router.dart';
import 'package:studentup/ui/widgets/flushbars.dart';
import 'package:studentup/util/enums/login_types.dart';
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
  Future<void> _handleRegistration(AuthenticationNotifier auth) async {
    bool _proceed = await Navigator.of(context).pushNamed<bool>(
          GlobalRouter.disclaimer,
          arguments: AuthType.email,
        ) ??
        false;
    if (!_proceed) return;
    bool _validated = widget.formKey.currentState.validate();
    bool _signedUp = await auth.signUpWithEmail(
      name: widget.bloc.nameValue,
      email: widget.bloc.emailValue,
      password: widget.bloc.passwordValue,
    );
    if (_validated && _signedUp)
      Navigator.of(context).pushReplacementNamed(GlobalRouter.homeRoute);
    else
      showFailedRegistration(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier _auth = Provider.of<AuthenticationNotifier>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<bool>(
            stream: widget.bloc.signup,
            builder: (context, snapshot) {
              return RaisedButton(
                child: const Text('Register'),
                onPressed: ((snapshot.data ?? false) && !_auth.isLoading)
                    ? () => _handleRegistration(_auth)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
