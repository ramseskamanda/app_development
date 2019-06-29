import 'dart:async';

import 'package:clique/bloc/notification_bloc.dart';
import 'package:clique/models/event_model.dart';
import 'package:clique/models/firebase_message.dart';
import 'package:clique/services/events_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/ui/widgets/event_dialog.dart';
import 'package:clique/util/message_type.dart';
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
        Event _event = await locator<EventsService>().getEventById(message.id);
        if (_event != null) showEventDialog(context, _event);
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
