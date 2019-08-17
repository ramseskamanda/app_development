import 'package:flutter/material.dart';

abstract class Router extends StatelessWidget {
  final String _home;

  @mustCallSuper
  Router({Key key, String home})
      : _home = home,
        super(key: key);

  @protected
  Route<dynamic> onGenerateRoute(RouteSettings settings);
  @protected
  Route<dynamic> onErrorRoute(RouteSettings settings);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: onGenerateRoute,
      initialRoute: _home,
      onUnknownRoute: onErrorRoute,
    );
  }
}
