import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/input_blocs/signup_form_bloc.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/disclaimer.dart';

class SignUpButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SignUpFormBloc bloc;
  final bool isStartup;
  SignUpButton({
    Key key,
    @required this.formKey,
    @required this.bloc,
    this.isStartup,
  }) : super(key: key);
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Consumer<AuthNotifier>(
            builder: (context, auth, child) {
              return StreamBuilder<bool>(
                stream: widget.bloc.signup,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: const Text('Register'),
                    onPressed: ((snapshot.data ?? false) && !auth.isLoading)
                        ? () async {
                            bool _proceed =
                                await Navigator.of(context).push<bool>(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            Disclaimer(type: AuthType.email),
                                      ),
                                    ) ??
                                    false;
                            if (!_proceed) return;
                            if (!widget.formKey.currentState.validate()) return;
                            await auth.signUpWithEmail(
                              isStartup: widget.isStartup,
                              name: widget.bloc.nameValue,
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
