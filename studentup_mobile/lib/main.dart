import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/services/analytics_service.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/app.dart';
import 'package:studentup_mobile/ui/signup/signup.dart';
import 'package:studentup_mobile/util/system.dart';
import 'package:catcher/catcher_plugin.dart';

Future<void> main() async {
  await SystemPreferences.initialize();
  await Locator.setup();
  await Locator.of<AuthService>().attemptAutoLogin();
  await Locator.of<AnalyticsService>().logger.logAppOpen();
  runApp(MyApp());
  // Catcher(
  //   MyApp(),
  //   debugConfig: debugOptions,
  //   releaseConfig: releaseOptions,
  //   profileConfig: profileOptions,
  //   enableLogger: false,
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Locator.providers,
      child: Consumer<AuthNotifier>(
        builder: (context, auth, child) {
          if (auth.userIsAuthenticated)
            return MaterialApp(
              navigatorKey: Catcher.navigatorKey,
              theme: StudentupTheme.theme,
              debugShowCheckedModeBanner: false,
              home: Application(),
            );
          return MaterialApp(
            navigatorKey: Catcher.navigatorKey,
            theme: StudentupTheme.theme,
            debugShowCheckedModeBanner: false,
            home: SignupRoot(login: auth.isRegistered),
          );
        },
      ),
    );
  }
}
