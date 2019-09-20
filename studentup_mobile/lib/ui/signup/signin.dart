import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
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

  Widget _buildAccountReminder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Don\'t have an account yet? '),
        GestureDetector(
          onTap: widget.signupCallback,
          child: Text(
            'Register!',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthNotifier auth = Provider.of(context);

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          // widthFactor: 0.86,
          // heightFactor: 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.86,
          child: Form(
            autovalidate: true,
            key: _key,
            child: Column(
              children: <Widget>[
                Spacer(flex: 3),
                Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 28.0),
                    ),
                  ],
                ),
                Spacer(),
                EmailTextFormField(
                  sink: auth.bloc.email,
                  nextNode: _passwordNode,
                ),
                SizedBox(height: 16.0),
                PasswordTextFormField(
                  sink: auth.bloc.password,
                ),
                Spacer(),
                GoogleButton(),
                SignInButton(formKey: _key),
                _buildAccountReminder(context),
                Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
