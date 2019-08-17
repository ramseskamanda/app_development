import 'package:studentup_mobile/input_blocs/signup_form_bloc.dart';
import 'package:studentup_mobile/ui/signup/signin_button.dart';
import 'package:studentup_mobile/ui/widgets/buttons/google_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/email_text_form_field.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/password_text_form_field.dart';
import 'package:studentup_mobile/util/config.dart';

export './disclaimer.dart';

class SignIn extends StatefulWidget {
  final void Function() signupCallback;

  const SignIn({Key key, this.signupCallback}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignUpFormBloc _bloc;

  GlobalKey<FormState> _key;

  FocusNode _emailNode;
  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _bloc = SignUpFormBloc();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _bloc.dispose();
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
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.86,
          child: Form(
            autovalidate: true,
            key: _key,
            child: Column(
              children: <Widget>[
                Spacer(flex: 3),
                Hero(
                  tag: HEADER_LOGO_HERO_TAG,
                  child: Image.asset(
                    'assets/logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
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
                  sink: _bloc.email,
                  nextNode: _passwordNode,
                ),
                SizedBox(height: 16.0),
                PasswordTextFormField(
                  sink: _bloc.password,
                ),
                Spacer(),
                GoogleButton(),
                SignInButton(formKey: _key, bloc: _bloc),
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
