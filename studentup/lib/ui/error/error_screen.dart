import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final RouteSettings settings;

  const ErrorScreen({Key key, @required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for ${settings.name}')),
    );
  }
}
