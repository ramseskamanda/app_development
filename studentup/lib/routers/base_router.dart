import 'package:flutter/material.dart';

abstract class BaseRouter {
  String initialRoute(BuildContext context);
  Route<dynamic> generateRoutes(RouteSettings settings);
}
