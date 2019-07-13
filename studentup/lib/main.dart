import 'package:provider/provider.dart';
import 'package:catcher/catcher_plugin.dart';
//import 'package:studentup/app_settings.dart';
import 'package:studentup/router.dart';
import 'package:studentup/services/provider_service.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/services/application_service.dart';
import 'package:studentup/ui/ui.dart';
import 'package:studentup/util/env.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupLocator();
  await setupApplicationSettings();

  /* Catcher(
    MyApp(),
    debugConfig: Settings.debugOptions,
    releaseConfig: Settings.releaseOptions,
  ); */
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: setupProviders(),
      child: MaterialApp(
        navigatorKey: Catcher.navigatorKey,
        title: Environment.appName,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }

  @override
  void dispose() {
    disposeLocatorResources();
    super.dispose();
  }
}
