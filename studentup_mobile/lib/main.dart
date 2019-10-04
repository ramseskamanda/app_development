import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/theme_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/notifications/notification_service.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/app.dart';
import 'package:studentup_mobile/ui/signup/signup.dart';
import 'package:studentup_mobile/util/config.dart';
import 'package:studentup_mobile/util/dev_settings.dart';
import 'package:studentup_mobile/util/system.dart';
import 'package:catcher/catcher_plugin.dart';

Future<void> main() async {
  await Locator.setup();
  await SystemPreferences.initialize();
  await Locator.of<BaseAuth>().initialize();
  await Locator.of<AnalyticsService>().initialize();
  await Locator.of<NotificationService>().initialize();
  Catcher(
    MyApp(),
    debugConfig: DevSettings.debugOptions,
    releaseConfig: DevSettings.releaseOptions,
    profileConfig: DevSettings.profileOptions,
    enableLogger: false,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Locator.providers,
      child: Consumer<ProfileNotifier>(
        builder: (context, profile, child) {
          if (profile == null)
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SignupRoot(
                login: Locator.of<LocalStorageService>()
                        .getFromDisk(SIGNUP_STORAGE_KEY) ??
                    false,
              ),
              theme: StudentupTheme.lightTheme,
              darkTheme: StudentupTheme.darkTheme,
              themeMode: ThemeMode.system,
            );
          return FutureBuilder(
            initialData: null,
            future: profile.fetchData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState != ConnectionState.done)
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(child: const CircularProgressIndicator()),
                  ),
                  theme: StudentupTheme.lightTheme,
                  darkTheme: StudentupTheme.darkTheme,
                  themeMode: ThemeMode.system,
                );

              return ChangeNotifierProvider<ProfileNotifier>(
                builder: (_) => profile,
                child: child,
              );
            },
          );
        },
        child: MultiProvider(
          providers: Locator.userProviders,
          child: Consumer<ThemeNotifier>(
            builder: (context, theme, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: Catcher.navigatorKey,
                home: Application(),
                theme: StudentupTheme.lightTheme,
                darkTheme: StudentupTheme.darkTheme,
                themeMode: theme.mode,
                onGenerateRoute: Router.onGenerateRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ProfileNotifier>(
              builder: (context, profile, child) {
                print(profile.preview.uid);
                if (profile.isLoading) return CircularProgressIndicator();
                return Text(profile.preview.givenName);
              },
            ),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: () => Locator.of<BaseAuth>().logout(),
            ),
          ],
        ),
      ),
    );
  }
}
