import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

class LaborExeprienceModel extends BaseModel {
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
    _periodStart = periodStart == null ? null : Timestamp.fromDate(periodStart);
    _periodEnd = periodEnd == null ? null : Timestamp.fromDate(periodEnd);
    _position = position;
  }

  String get userId => _userId ?? '';
  String get companyName => _companyName ?? 'No Company';
  String get periodStart => Util.format(_periodStart);
  String get periodEnd => Util.format(_periodEnd, allowNow: true);
  String get position => _position ?? 'No Position';
  bool get canEdit => _userId == Locator.of<BaseAuth>().currentUserId;

  LaborExeprienceModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
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
