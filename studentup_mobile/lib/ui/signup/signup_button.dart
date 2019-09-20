import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/disclaimer.dart';

class SignUpButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isStartup;
  SignUpButton({
    Key key,
    @required this.formKey,
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
                stream: auth.bloc.signup,
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
                            await auth.authenticate(
                              AuthType.email,
                              true,
                              isStartup: widget.isStartup,
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
