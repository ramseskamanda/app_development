import 'dart:async';

import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/router.dart';
import 'package:studentup/util/env.dart';
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

  Timer _startTimer() => Timer(Environment.splashScreenDuration, _navigate);

  Future<void> _navigate() async {
    switch (Router.initialRoute(context)) {
      case Router.homeRoute:
        if (await Provider.of<AuthenticationNotifier>(context)
            .handleAutoLogin())
          Navigator.of(context).pushReplacementNamed(Router.homeRoute);
        else
          Navigator.of(context).pushReplacementNamed(
            Router.loginRoute,
            arguments: true,
          );
        break;
      case Router.loginRoute:
        Navigator.of(context).pushReplacementNamed(Router.loginRoute);
        break;
      case Router.signupRoute:
        Navigator.of(context).pushReplacementNamed(Router.onboarding);
        break;
      default:
        Navigator.of(context).pushReplacementNamed(Router.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightGreen,
      child: Center(
        child: Hero(
          tag: Environment.logoHeroTag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 16.0),
              Text(
                Environment.appName,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (Provider.of<AuthenticationNotifier>(context).isLoading) ...[
                SizedBox(height: 16.0),
                CircularProgressIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
