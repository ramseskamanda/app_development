import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/ui/signup/onboarding/onboarding.dart';
import 'package:studentup_mobile/ui/signup/signin.dart';
import 'package:studentup_mobile/ui/signup/signup_form.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class SignupRoot extends StatefulWidget {
  final bool login;
  const SignupRoot({Key key, this.login = false}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignupRoot> {
  List<Widget> _pages;
  PageController _controller;
  bool _authPage;
  bool _goBack;

  void _goToSignUp() {
    _controller.animateToPage(
      _pages.length - 1,
      duration:
          kTabScrollDuration ~/ (_pages.length - _controller.page.toInt()),
      curve: Curves.easeInOutCirc,
    );
  }

  void _goToLogin() {
    _controller.animateToPage(
      _pages.length - 2,
      duration: kTabScrollDuration,
      curve: Curves.easeInOutCirc,
    );
  }

  void _onPageChanged(int index) {
    if (index >= _pages.length - 2)
      _authPage = true;
    else
      _authPage = false;
    if (index > 0)
      _goBack = true;
    else
      _goBack = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.login ? onboarding.length : 0,
    );
    _authPage = widget.login;
    _goBack = widget.login;
    _pages = <Widget>[
      ...onboarding,
      SignIn(signupCallback: _goToSignUp),
      SignUpForm(loginCallback: _goToLogin),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: !_goBack
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.previousPage(
                    duration: kTabScrollDuration,
                    curve: Curves.easeInOutCirc,
                  );
                },
              ),
        actions: <Widget>[
          if (!_authPage)
            FlatButton(
              child: const Text('Skip'),
              textColor: Platform.isIOS
                  ? CupertinoColors.activeBlue
                  : Theme.of(context).accentColor,
              onPressed: _goToLogin,
            ),
        ],
      ),
      body: ChangeNotifierProvider<AuthNotifier>(
        builder: (_) => AuthNotifier(),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.86,
            heightFactor: 0.9,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) => Center(child: _pages[index]),
                ),
                if (!_authPage)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: StadiumButton(
                      text: 'Next',
                      onPressed: () {
                        _controller.nextPage(
                          duration: kTabScrollDuration,
                          curve: Curves.easeInOutCirc,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
