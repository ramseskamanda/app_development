import 'dart:io';
//import 'package:studentup/bloc/notification_bloc.dart';
//import 'package:studentup/services/service_locator.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  //FirebaseMessaging _firebaseMessaging;

  MessagingService(); // : _firebaseMessaging = FirebaseMessaging();

  Future<String> get deviceToken async =>
      'testToken'; //_firebaseMessaging.getToken();

  void setupMessagingService() {
    if (Platform.isIOS) _iOSPersmissionsRequest();

    /* _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async =>
          locator<NotificationBloc>().sink.add(message),
      onResume: (Map<String, dynamic> message) async =>
          locator<NotificationBloc>().sink.add(message),
      onLaunch: (Map<String, dynamic> message) async =>
          locator<NotificationBloc>().sink.add(message),
    ); */
  }

  void _iOSPersmissionsRequest() {
    print('[Requesting iOS Notification Permissions]');
    /* _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    }); */
  }
}
