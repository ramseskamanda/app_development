import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/disclaimer.dart';

class GoogleButton extends StatelessWidget {
  final bool isStartup;
  GoogleButton({Key key, this.isStartup = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Consumer<AuthNotifier>(
            builder: (context, auth, child) {
              return GoogleSignInButton(
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        bool _proceed = await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (_) =>
                                    Disclaimer(type: AuthType.google),
                              ),
                            ) ??
                            false;
                        if (!_proceed) return;
                        await auth.authenticate(
                          AuthType.google,
                          false,
                          isStartup: isStartup,
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
