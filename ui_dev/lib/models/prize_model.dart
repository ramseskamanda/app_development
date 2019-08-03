import 'package:cloud_firestore/cloud_firestore.dart';

class PrizeModel {
  Timestamp _batch;
  String _mediaRef;
  String _name;
  bool _sponsored;

  PrizeModel({
    DateTime batch,
    String media,
    String name,
    bool sponsored,
  }) {
    _batch = Timestamp.fromDate(batch) ?? Timestamp.now();
    _mediaRef = media;
    _name = name;
    _sponsored = sponsored;
  }

  DateTime get batch => _batch?.toDate() ?? DateTime.now();
  String get media => _mediaRef ?? '404 Error';
  String get name => _name ?? '404 Error';
  bool get sponsored => _sponsored ?? false;

  PrizeModel.fromJson(Map<String, dynamic> json) {
    _batch = json['batch'];
    _mediaRef = json['media_ref'];
    _name = json['name'];
    _sponsored = json['sponsored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch'] = _batch;
    data['media_ref'] = _mediaRef;
    data['name'] = _name;
    data['sponsored'] = _sponsored;
    return data;
  }
}
