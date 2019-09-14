import 'package:studentup_mobile/input_blocs/signup_form_bloc.dart';
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
  SignUpFormBloc _bloc;

  GlobalKey<FormState> _key;

  FocusNode _emailNode;
  FocusNode _passwordNode;
  FocusNode _passwordConfirmNode;

  bool _isStartup;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _bloc = SignUpFormBloc();
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
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildAccountReminder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Already have an account? '),
        GestureDetector(
          onTap: widget.loginCallback,
          child: Text(
            'Sign in!',
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
                Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Spacer(flex: 2),
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
                      onChanged: (value) {
                        setState(() {
                          _isStartup = value;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(),
                NameTextFormField(
                  hintText: _isStartup ? 'Startup Name' : 'Full Name',
                  sink: _bloc.name,
                  nextNode: _emailNode,
                ),
                SizedBox(height: 16.0),
                EmailTextFormField(
                  hintText: _isStartup ? 'Company Email' : 'Email',
                  sink: _bloc.email,
                  nextNode: _passwordNode,
                ),
                SizedBox(height: 16.0),
                PasswordTextFormField(
                  sink: _bloc.password,
                  nextNode: _passwordConfirmNode,
                ),
                SizedBox(height: 16.0),
                PasswordTextFormField(
                  confirm: true,
                  sink: _bloc.confirm,
                  validator: _bloc.passwordValidator,
                ),
                Spacer(),
                GoogleButton(isStartup: _isStartup),
                SignUpButton(formKey: _key, bloc: _bloc, isStartup: _isStartup),
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
