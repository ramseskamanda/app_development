import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/app.dart';
import 'package:studentup_mobile/ui/signup/signup.dart';
import 'package:studentup_mobile/util/dev_settings.dart';
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
  //   debugConfig: DevSettings.debugOptions,
  //   releaseConfig: DevSettings.releaseOptions,
  //   profileConfig: DevSettings.profileOptions,
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
              onGenerateRoute: Router.onGenerateRoute,
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
