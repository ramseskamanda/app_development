import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/account_reminder.dart';
import 'package:studentup_mobile/ui/signup/signin_button.dart';
import 'package:studentup_mobile/ui/widgets/buttons/google_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/email_text_form_field.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/password_text_form_field.dart';

export './disclaimer.dart';

class SignIn extends StatefulWidget {
  final void Function() signupCallback;

  const SignIn({Key key, this.signupCallback}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key;
  FocusNode _emailNode;
  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthNotifier auth = Provider.of(context);

    return SingleChildScrollView(
      child: Form(
        autovalidate: true,
        key: _key,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 28.0),
              ),
            ),
            const SizedBox(height: 16.0),
            EmailTextFormField(
              sink: auth.bloc.email,
              nextNode: _passwordNode,
            ),
            const SizedBox(height: 16.0),
            PasswordTextFormField(
              sink: auth.bloc.password,
            ),
            GoogleButton(),
            SignInButton(formKey: _key),
            AccountReminder(
              reminder: 'Don\'t have an account yet?',
              link: 'Register!',
              callback: widget.signupCallback,
            ),
          ],
        ),
      ),
    );
  }
}
