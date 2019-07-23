import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/routers/global_router.dart';
import 'package:studentup/ui/widgets/flushbars.dart';
import 'package:studentup/util/enums/login_types.dart';
import 'package:flutter/material.dart';

/// Button that takes care of all the signup logic related to Google Auth
/// ⚠️ Row widget!!
class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationNotifier _auth =
        Provider.of<AuthenticationNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GoogleSignInButton(
            onPressed: _auth.isLoading
                ? null
                : () async {
                    bool _proceed = await Navigator.of(context).pushNamed<bool>(
                          GlobalRouter.disclaimer,
                          arguments: AuthType.google,
                        ) ??
                        false;
                    if (!_proceed) return;
                    bool _success = await _auth.loginWithGoogle();
                    if (_success)
                      Navigator.of(context)
                          .pushReplacementNamed(GlobalRouter.homeRoute);
                    else
                      showAuthenticationErrorMessage(context);
                  },
          ),
        ),
      ],
    );
  }
}
