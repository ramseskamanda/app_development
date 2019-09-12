import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/enum/initial_routes.dart';
import 'package:studentup_mobile/models/firebase_notification_model.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging;
  String _token;
  InitialRoute _initialRoute;
  BehaviorSubject<FirebaseNotificationModel> _onMessage;

  Future initialize() async {
    _onMessage = BehaviorSubject();
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _token = await _firebaseMessaging.getToken();
    _firebaseMessaging.onTokenRefresh.listen((newToken) => _token = newToken);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> data) async {
        print(data);
        _onMessage.sink.add(FirebaseNotificationModel.fromJson(data));
      },
      onLaunch: (Map<String, dynamic> data) async =>
          _initialRoute = InitialRoute.Notifications,
      onResume: (Map<String, dynamic> data) async =>
          _initialRoute = InitialRoute.Notifications,
    );
  }

  int get initialRoute => initialRoutes[_initialRoute ?? InitialRoute.Home];
  String get deviceToken => _token;
  Observable<FirebaseNotificationModel> get onMessage =>
      _onMessage.stream.distinct((a, b) => a == b);

  Future test() async {
    print(await _firebaseMessaging.getToken());
    final bool enabled = await _firebaseMessaging.autoInitEnabled();
    print('Auto Init Status:${enabled ? '' : 'NOT'} enabled');
  }

  Future dispose() async => _onMessage.close();
}
