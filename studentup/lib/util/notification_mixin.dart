import 'dart:async';

import 'package:studentup/bloc/notification_bloc.dart';
import 'package:studentup/models/firebase_message.dart';
import 'package:studentup/services/service_locator.dart';
import 'package:studentup/util/message_type.dart';
import 'package:flutter/material.dart';

mixin NotificationMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<FirebaseMessage> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = locator<NotificationBloc>().stream.listen(
          _onData,
          onDone: _onDone,
          onError: _onError,
          cancelOnError: false,
        );
  }

  Future<void> _onData(FirebaseMessage message) async {
    switch (message.type) {
      case MessageType.Event:
        showAboutDialog(context: context);
        break;
      default:
        break;
    }
  }

  void _onDone() {
    print('[Notifications Stream is Done]');
  }

  void _onError(Object error) {
    print('[Notifications Stream contains an error]');
  }

  @override
  void dispose() {
    super.dispose();
    _notifications.cancel();
  }
}
