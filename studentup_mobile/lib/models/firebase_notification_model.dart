import 'package:studentup_mobile/models/base_model.dart';

class FirebaseNotificationModel extends BaseModel {
  String _content;
  String _type;
  String _userId;
  List<String> _tokens;

  FirebaseNotificationModel(
      {String content, String type, String userId, List<String> tokens}) {
    this._content = content;
    this._type = type;
    this._userId = userId;
    this._tokens = tokens;
  }

  String get content => _content;
  String get type => _type;
  String get userId => _userId;
  List<String> get tokens => _tokens;

  FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _type = json['type'];
    _userId = json['user_id'];
    _tokens = json['tokens'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['type'] = this._type;
    data['user_id'] = this._userId;
    data['tokens'] = this._tokens;
    return data;
  }
}
