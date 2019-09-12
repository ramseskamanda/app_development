import 'package:equatable/equatable.dart';
import 'package:studentup_mobile/enum/notification_type.dart';

class FirebaseNotificationModel extends Equatable {
  final String _body;
  final String _title;
  final Map<dynamic, dynamic> _data;

  FirebaseNotificationModel(
    this._body,
    this._title,
    this._data,
  );

  factory FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    return FirebaseNotificationModel(
      json['body'],
      json['title'],
      Map<dynamic, dynamic>.from(json['data'] ?? {}),
    );
  }

  String get body => _body ?? 'Notification';
  String get title => _title ?? 'Studentup';
  Map<dynamic, dynamic> get data => _data ?? {};
  NotificationType get type => _data == null
      ? NotificationType.DEFAULT
      : notificationType[data['type'] ?? 'default'];
}
