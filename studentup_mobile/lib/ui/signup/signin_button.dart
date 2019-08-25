import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/input_blocs/signup_form_bloc.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';

class SignInButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SignUpFormBloc bloc;
  SignInButton({Key key, @required this.formKey, @required this.bloc})
      : super(key: key);
  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Consumer<AuthNotifier>(
            builder: (context, auth, child) {
              return StreamBuilder<bool>(
                stream: widget.bloc.signin,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: const Text('Sign In'),
                    onPressed: ((snapshot.data ?? false) && !auth.isLoading)
                        ? () async {
                            if (!widget.formKey.currentState.validate()) return;
                            print(widget.bloc.emailValue);
                            print(widget.bloc.passwordValue);
                            await auth.loginWithEmail(
                              email: widget.bloc.emailValue,
                              password: widget.bloc.passwordValue,
                            );
                          }
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
