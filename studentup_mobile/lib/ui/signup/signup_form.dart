import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/account_reminder.dart';
import 'package:studentup_mobile/ui/signup/signup_button.dart';
import 'package:studentup_mobile/ui/widgets/buttons/google_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/email_text_form_field.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/name_text_form_field.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/password_text_form_field.dart';

export './disclaimer.dart';

class SignUpForm extends StatefulWidget {
  final void Function() loginCallback;

  const SignUpForm({Key key, this.loginCallback}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _key;

  FocusNode _emailNode;
  FocusNode _passwordNode;
  FocusNode _passwordConfirmNode;

  bool _isStartup;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _passwordConfirmNode = FocusNode();
    _isStartup = false;
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _passwordConfirmNode.dispose();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 28.0),
                ),
                Spacer(),
                const Text(
                  'Startup?',
                  style: TextStyle(fontSize: 24.0),
                ),
                Switch.adaptive(
                  value: _isStartup,
                  onChanged: (value) => setState(() => _isStartup = value),
                ),
              ],
            ),
            NameTextFormField(
              hintText: _isStartup ? 'Startup Name' : 'Full Name',
              sink: auth.bloc.name,
              nextNode: _emailNode,
            ),
            const SizedBox(height: 16.0),
            EmailTextFormField(
              hintText: _isStartup ? 'Company Email' : 'Email',
              sink: auth.bloc.email,
              nextNode: _passwordNode,
            ),
            const SizedBox(height: 16.0),
            PasswordTextFormField(
              sink: auth.bloc.password,
              nextNode: _passwordConfirmNode,
            ),
            const SizedBox(height: 16.0),
            PasswordTextFormField(
              confirm: true,
              sink: auth.bloc.confirm,
              validator: auth.bloc.passwordValidator,
            ),
            const SizedBox(height: 24.0),
            GoogleButton(isStartup: _isStartup),
            SignUpButton(formKey: _key, isStartup: _isStartup),
            AccountReminder(
              reminder: 'Already have an account?',
              link: 'Sign in!',
              callback: widget.loginCallback,
            ),
          ],
        ),
      ),
    );
  }
}
