import 'package:flutter/material.dart';

abstract class BaseRouter {
  @mustCallSuper
  BaseRouter({@required this.key});

  String initialRoute(BuildContext context);
  Route<dynamic> generateRoutes(RouteSettings settings);

  /// Search Navigator Key.
  final GlobalKey<NavigatorState> key;

  dynamic push<T extends Object>(String route,
      {bool replaceCurrentView = false, Object arguments}) {
    if (replaceCurrentView)
      return key.currentState.pushReplacementNamed(route, arguments: arguments);
    return key.currentState.pushNamed<T>(route, arguments: arguments);
  }

  dynamic popCurrentRoute<T>({T result}) {
    if (result != null) key.currentState.pop<T>(result);
    key.currentState.pop();
  }
}
