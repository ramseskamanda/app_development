import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:studentup_mobile/enum/initial_routes.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging;
  InitialRoute _initialRoute;

  void initialize() {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> data) async {
        //TODO: show a toast here
        print(data);
      },
      onLaunch: (Map<String, dynamic> data) async {
        _initialRoute = InitialRoute.Notifications;
        print(data);
      },
      onResume: (Map<String, dynamic> data) async {
        _initialRoute = InitialRoute.Notifications;
        print(data);
      },
    );
  }

  int get initialRoute => initialRoutes[_initialRoute] ?? 0;

  Future test() async {
    print(await _firebaseMessaging.getToken());
    final bool enabled = await _firebaseMessaging.autoInitEnabled();
    print('Auto Init Status:${enabled ? '' : 'NOT'} enabled');
  }
}
