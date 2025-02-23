import 'package:clique/bloc/signup_form_bloc.dart';
import 'package:clique/router.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/ui/signup/signup_button.dart';
import 'package:clique/ui/widgets/name_text_form_field.dart';
import 'package:clique/ui/widgets/widgets.dart';
import 'package:clique/util/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpFormBloc bloc;

  GlobalKey<FormState> _key;

  FocusNode _emailNode;
  FocusNode _passwordNode;
  FocusNode _passwordConfirmNode;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    bloc = locator<SignUpFormBloc>();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _passwordConfirmNode = FocusNode();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _passwordConfirmNode.dispose();
    bloc.dispose();
    super.dispose();
  }

  Widget _buildLogo(BuildContext context) {
    return Hero(
      tag: Environment.logoHeroTag,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.134,
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Register',
          style: TextStyle(fontSize: 28.0),
        ),
      ],
    );
  }

  Widget _buildAccountReminder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Already have an account? '),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(Router.loginRoute),
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
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: _key,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.86,
              child: Column(
                children: <Widget>[
                  Spacer(flex: 3),
                  _buildLogo(context),
                  Spacer(flex: 2),
                  _buildTitle(context),
                  Spacer(),
                  NameTextFormField(
                    sink: bloc.name,
                    nextNode: _emailNode,
                  ),
                  SizedBox(height: 16.0),
                  EmailTextFormField(
                    sink: bloc.email,
                    nextNode: _passwordNode,
                  ),
                  SizedBox(height: 16.0),
                  PasswordTextFormField(
                    sink: bloc.password,
                    nextNode: _passwordConfirmNode,
                  ),
                  SizedBox(height: 16.0),
                  PasswordTextFormField(
                    confirm: true,
                    sink: bloc.confirm,
                    validator: bloc.passwordValidator,
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GoogleButton(),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FacebookButton(),
                      ),
                    ],
                  ),
                  SignUpButton(formKey: _key, bloc: bloc),
                  _buildAccountReminder(context),
                  Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
