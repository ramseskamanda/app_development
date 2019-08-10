import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_dev/test_data.dart';

class LaborExeprienceModel {
  String _userId;
  String _companyName;
  Timestamp _periodStart;
  Timestamp _periodEnd;
  String _position;

  LaborExeprienceModel({
    @required String userId,
    @required String companyName,
    @required DateTime periodStart,
    @required DateTime periodEnd,
    @required String position,
  }) {
    _userId = userId;
    _companyName = companyName;
    _periodStart = Timestamp.fromDate(periodStart);
    _periodEnd = Timestamp.fromDate(periodEnd);
    _position = position;
  }

  String get userId => _userId ?? '500 Error';
  String get companyName => _companyName ?? '500 Error';
  String get periodStart => TestData.format(_periodStart);
  String get periodEnd => TestData.format(_periodEnd, allowNow: true);
  String get position => _position ?? '500 Error';

  LaborExeprienceModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _companyName = json['company_name'];
    _periodStart = json['period_start'];
    _periodEnd = json['period_end'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['company_name'] = _companyName;
    data['period_start'] = _periodStart;
    data['period_end'] = _periodEnd;
    data['position'] = _position;
    return data;
  }
}
