import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/signup/signup.dart';
import 'package:studentup_mobile/util/system.dart';
import 'package:catcher/catcher_plugin.dart';

Future<void> main() async {
  await SystemPreferences.initialize();
  await Locator.setup();
  await Locator.of<AuthService>().attemptAutoLogin();
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
      child: MaterialApp(
        navigatorKey: Catcher.navigatorKey,
        theme: StudentupTheme.theme,
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthNotifier>(
          builder: (context, auth, child) {
            if (auth.userIsAuthenticated)
              return Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Logged In!'),
                    RaisedButton(
                      child: const Text('Log out'),
                      onPressed: () => auth.logout(),
                    ),
                  ],
                ),
              );
            else if (auth.needsRegistration)
              return SignupRoot();
            else
              return Scaffold(
                body: Center(
                  child: Text('Whoops you gotta login'),
                ),
              );
          },
        ),
      ),
    );
  }
}
