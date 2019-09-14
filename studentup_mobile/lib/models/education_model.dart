import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

class EducationModel extends BaseModel {
  String _userId;
  String _university;
  String _faculty;
  String _degree;
  Timestamp _gradDate;
  Timestamp _periodStart;
  Timestamp _periodEnd;
  String _studyDescription;

  EducationModel({
    String userId,
    String university,
    String faculty,
    String degree,
    DateTime gradDate,
    DateTime periodStart,
    DateTime periodEnd,
    String studyDescription,
  }) {
    _userId = userId;
    _university = university;
    _faculty = faculty;
    _degree = degree;
    _periodStart = periodStart == null ? null : Timestamp.fromDate(periodStart);
    _periodEnd = periodEnd == null ? null : Timestamp.fromDate(periodEnd);
    _gradDate = periodEnd == null ? null : Timestamp.fromDate(gradDate);
    _studyDescription = studyDescription;
  }

  String get userId => _userId ?? '';
  String get university => _university ?? 'No University';
  String get faculty => _faculty ?? 'No Faculty';
  String get degree => _degree ?? '';
  String get gradDate => Util.format(_gradDate);
  String get periodStart => Util.format(_periodStart);
  String get periodEnd => Util.format(_periodEnd, allowNow: true);
  String get studyDescription => _studyDescription ?? 'No Description';
  bool get canEdit => _userId == Locator.of<AuthService>().currentUser.uid;

  EducationModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _userId = json['user_id'];
    _university = json['university'];
    _faculty = json['faculty'];
    _degree = json['degree'];
    _gradDate = json['grad_date'];
    _periodStart = json['period_start'];
    _periodEnd = json['period_end'];
    _studyDescription = json['study_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['university'] = _university;
    data['faculty'] = _faculty;
    data['degree'] = _degree;
    data['grad_date'] = _gradDate;
    data['period_start'] = _periodStart;
    data['period_end'] = _periodEnd;
    data['study_description'] = _studyDescription;
    return data;
  }
}
