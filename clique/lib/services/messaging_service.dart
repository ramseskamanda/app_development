import 'dart:io';
import 'package:clique/bloc/notification_bloc.dart';
import 'package:clique/services/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  FirebaseMessaging _firebaseMessaging;

  MessagingService() : _firebaseMessaging = FirebaseMessaging();

  Future<String> get deviceToken async => _firebaseMessaging.getToken();

  void setupMessagingService() {
    if (Platform.isIOS) _iOSPersmissionsRequest();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        locator<NotificationBloc>().sink.add(message.keys.toList().first);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void _iOSPersmissionsRequest() {
    print('[Requesting iOS Notification Permissions]');
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
