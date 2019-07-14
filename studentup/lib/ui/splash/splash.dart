import 'dart:async';

import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/routers/global_router.dart';
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
    final GlobalRouter globalRouter = Provider.of(context);
    switch (globalRouter.initialRoute(context)) {
      case GlobalRouter.homeRoute:
        if (await Provider.of<AuthenticationNotifier>(context)
            .handleAutoLogin())
          globalRouter.push(GlobalRouter.homeRoute, replaceCurrentView: true);
        else
          globalRouter.push(
            GlobalRouter.loginRoute,
            replaceCurrentView: true,
            arguments: true,
          );
        break;
      case GlobalRouter.loginRoute:
        globalRouter.push(GlobalRouter.loginRoute, replaceCurrentView: true);
        break;
      case GlobalRouter.signupRoute:
        globalRouter.push(GlobalRouter.onboarding, replaceCurrentView: true);
        break;
      default:
        globalRouter.push(GlobalRouter.loginRoute, replaceCurrentView: true);
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
