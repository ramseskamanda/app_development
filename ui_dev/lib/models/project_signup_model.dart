import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectSignupModel {
  String _userId;
  String _message;
  String _projectId;
  Timestamp _timestamps;
  String _file;

  ProjectSignupModel({
    String userId,
    String message,
    String projectId,
    DateTime timestamps,
    String file,
  }) {
    _userId = userId;
    _message = message;
    _projectId = projectId;
    _timestamps = Timestamp.fromDate(timestamps);
    _file = file;
  }

  String get userId => _userId ?? 'Error 404';
  String get message => _message ?? 'Error 404';
  String get projectId => _projectId ?? 'Error 404';
  DateTime get timestamps => _timestamps?.toDate() ?? DateTime.now();
  String get file => _file ?? 'Error 404';

  ProjectSignupModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _message = json['message'];
    _projectId = json['project_id'];
    _timestamps = json['timestamps'];
    _file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['message'] = _message;
    data['project_id'] = _projectId;
    data['timestamps'] = _timestamps;
    data['file'] = _file;
    return data;
  }
}
