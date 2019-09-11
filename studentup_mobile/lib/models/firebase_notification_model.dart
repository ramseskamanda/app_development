import 'package:studentup_mobile/models/base_model.dart';

class FirebaseNotificationModel extends BaseModel {
  Map<dynamic, dynamic> _content;
  String _type;
  String _topic;

  FirebaseNotificationModel({
    Map<dynamic, dynamic> content,
    String type,
    String userId,
    String topic,
  }) {
    _content = content;
    _type = type;
    _topic = topic;
  }

  Map<dynamic, dynamic> get content => _content ?? '';
  String get type => _type ?? '';

  FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = _content;
    data['type'] = _type;
    data['topic'] = _topic;
    return data;
  }
}
