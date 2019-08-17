import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

class ProjectSignupModel extends BaseModel {
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

  String get userId => _userId ?? 'Error 500';
  String get message => _message ?? 'Error 500';
  String get projectId => _projectId ?? 'Error 500';
  DateTime get timestamps => _timestamps?.toDate() ?? DateTime.now();
  String get file => _file ?? 'Error 500';

  ProjectSignupModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
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
