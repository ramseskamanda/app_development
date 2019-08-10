import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_dev/test_data.dart';

class EducationModel {
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
    _gradDate = Timestamp.fromDate(gradDate);
    _periodStart = Timestamp.fromDate(periodStart);
    _periodEnd = Timestamp.fromDate(periodEnd);
    _studyDescription = studyDescription;
  }

  String get userId => _userId ?? '500 Error';
  String get university => _university ?? '500 Error';
  String get faculty => _faculty ?? '500 Error';
  String get degree => _degree ?? '500 Error';
  String get gradDate => TestData.format(_gradDate);
  String get periodStart => TestData.format(_periodStart);
  String get periodEnd => TestData.format(_periodEnd, allowNow: true);
  String get studyDescription => _studyDescription ?? '500 Error';

  EducationModel.fromJson(Map<String, dynamic> json) {
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
