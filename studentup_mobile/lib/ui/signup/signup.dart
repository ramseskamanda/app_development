import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/signup/signin.dart';
import 'package:studentup_mobile/ui/signup/signup_form.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

export './disclaimer.dart';

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

  final List<Widget> _onboardingPages = <Widget>[
    Container(color: Colors.blue),
    Container(color: Colors.red),
    Container(color: Colors.green),
  ];

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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.login ? _onboardingPages.length : 0,
    );
    _authPage = widget.login;
    _pages = <Widget>[
      ..._onboardingPages,
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: _onPageChanged,
              children: _pages,
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
    );
  }
}
