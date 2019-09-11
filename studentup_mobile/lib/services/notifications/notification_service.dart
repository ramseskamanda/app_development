import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:studentup_mobile/enum/initial_routes.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging;
  String _token;
  InitialRoute _initialRoute;

  Future initialize() async {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _token = await _firebaseMessaging.getToken();
    _firebaseMessaging.onTokenRefresh.listen((newToken) => _token = newToken);
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
  String get deviceToken => _token;

  Future test() async {
    print(await _firebaseMessaging.getToken());
    final bool enabled = await _firebaseMessaging.autoInitEnabled();
    print('Auto Init Status:${enabled ? '' : 'NOT'} enabled');
  }
}
