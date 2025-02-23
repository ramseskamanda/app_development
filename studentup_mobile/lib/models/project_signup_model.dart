import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/models/chat_model.dart';

class ProjectSignupModel extends BaseModel {
  String _userId;
  Preview _user;
  String _message;
  String _projectId;
  Timestamp _timestamps;
  String _file;

  ProjectSignupModel({
    String userId,
    Preview user,
    String message,
    String projectId,
    DateTime timestamps,
    String file,
  }) {
    _userId = userId;
    _user = user;
    _message = message;
    _projectId = projectId;
    _timestamps = Timestamp.fromDate(timestamps);
    _file = file;
  }

  String get userId => _userId ?? '';
  Preview get user => _user;
  String get message => _message ?? '';
  String get projectId => _projectId ?? '';
  DateTime get timestamps => _timestamps?.toDate() ?? DateTime.now();
  String get file => _file;

  ProjectSignupModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _userId = json['user_id'];
    _message = json['message'];
    _projectId = json['project_id'];
    _timestamps = json['timestamps'];
    _file = json['file'];
    _user = Preview.fromJson(json['user'], _userId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['message'] = _message;
    data['project_id'] = _projectId;
    data['timestamps'] = _timestamps;
    data['file'] = _file;
    data['user'] = _user?.toJson();
    return data;
  }
}
