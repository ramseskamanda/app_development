import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';

class SignInButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  SignInButton({Key key, @required this.formKey}) : super(key: key);
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
                stream: auth.bloc.signin,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: const Text('Sign In'),
                    onPressed: ((snapshot.data ?? false) && !auth.isLoading)
                        ? () async {
                            if (!widget.formKey.currentState.validate()) return;
                            print(auth.bloc.emailValue);
                            print(auth.bloc.passwordValue);
                            await auth.authenticate(AuthType.email, false);
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
