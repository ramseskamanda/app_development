import 'dart:async';

import 'package:studentup/router.dart';
import 'package:studentup/services/authentication_service.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/util/env.dart';
import 'package:studentup/util/error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    //TODO: set to 2110 for production
    Duration _duration = Duration(milliseconds: 100);
    return Timer(_duration, _navigate);
  }

  Future<FirebaseUser> _handleAutoLogin() async {
    AuthService _auth = locator<AuthService>();
    //UserService _userService = locator<UserService>();
    FirebaseUser _user = await _auth.currentUser;
    return _user; //_userService.createUserProfile(_user);
  }

  _navigate() async {
    switch (Router.initialRoute) {
      case Router.homeRoute:
        FirebaseUser _user = await _handleAutoLogin();
        if (_user != null) {
          Navigator.of(context).pushReplacementNamed(Router.homeRoute);
        } else {
          ErrorMessage _error = ErrorMessage(
            code: 'ACCOUNT_DISCONNECTED',
            importance: ErrorImportance.medium,
            details: 'This account was disconnected. Please login again.',
          );
          Navigator.of(context).pushReplacementNamed(
            Router.loginRoute,
            arguments: _error,
          );
        }
        break;
      case Router.loginRoute:
        Navigator.of(context).pushReplacementNamed(Router.loginRoute);
        break;
      case Router.signupRoute:
        Navigator.of(context).pushReplacementNamed(Router.signupRoute);
        break;
      default:
        Navigator.of(context).pushReplacementNamed(Router.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Hero(
          tag: Environment.logoHeroTag,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
