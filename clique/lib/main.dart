import 'package:clique/router.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/services/application_service.dart';
import 'package:clique/ui/ui.dart';
import 'package:clique/util/env.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupLocator();
  await setupApplicationSettings();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Environment.appName,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      onGenerateRoute: Router.generateRoute,
    );
  }

  @override
  void dispose() {
    disposeLocatorResources();
    super.dispose();
  }
}
