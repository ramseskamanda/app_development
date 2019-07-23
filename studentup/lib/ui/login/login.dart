import 'package:flutter/scheduler.dart';
import 'package:studentup/bloc/login_form_bloc.dart';
import 'package:studentup/routers/global_router.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/ui/login/login_button.dart';
import 'package:studentup/ui/widgets/dialogs.dart';
import 'package:studentup/ui/widgets/widgets.dart';
import 'package:studentup/util/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final bool error;
  Login({Key key, this.error}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginFormBloc _bloc;

  GlobalKey<FormState> _key;

  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    if (widget.error != null &&
        widget.error == true &&
        SchedulerBinding.instance.schedulerPhase ==
            SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showAutoLoginErrorMessage(context));
    }

    _key = GlobalKey<FormState>();
    _bloc = locator<LoginFormBloc>();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordNode.dispose();
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildHeroLogo() {
    return Hero(
      tag: Environment.logoHeroTag,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.134,
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  Widget _buildRegistrationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Don\'t have an account yet? '),
        GestureDetector(
          onTap: () => Navigator.of(context, rootNavigator: true)
              .pushNamed(GlobalRouter.homeRoute),
          child: Text(
            'Register now!',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  _buildHeroLogo(),
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
                  LoginButton(bloc: _bloc, formKey: _key),
                  _buildRegistrationButton(),
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
