import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_dev/enum/search_enum.dart';

class CompetitionModel {
  String _creator;
  String _title;
  String _media;
  String _description;
  Timestamp _timestamp;
  Timestamp _deadline;
  List<String> _files;
  String _category1;
  String _category2;
  String _category3;
  List<String> _favSolutions;
  int _maxUsersNum;
  int _signupsNum;

  CompetitionModel({
    @required String creator,
    @required String title,
    @required String media,
    @required List<String> files,
    @required String description,
    @required DateTime timestamp,
    @required DateTime deadline,
    @required int maxUsersNum,
    @required List<SearchCategory> categories,
  }) {
    _creator = creator;
    _title = title;
    _media = media;
    _description = description;
    _timestamp = Timestamp.fromDate(timestamp);
    _deadline = Timestamp.fromDate(deadline);
    _files = files;
    _category1 = categories[0].toString().split('.')[1];
    _category2 =
        categories.length > 1 ? categories[1].toString().split('.')[1] : null;
    _category3 =
        categories.length > 2 ? categories[2].toString().split('.')[1] : null;
    _favSolutions = <String>[];
    _maxUsersNum = maxUsersNum;
    _signupsNum = 0;
  }

  String get creator => _creator;
  String get title => _title;
  String get media => _media;
  String get description => _description;
  DateTime get timestamp => _timestamp.toDate();
  DateTime get deadline => _deadline.toDate();
  List<String> get files => _files;
  String get category1 => _category1;
  String get category2 => _category2;
  String get category3 => _category3;
  List<String> get favSolutions => _favSolutions;
  int get maxUsersNum => _maxUsersNum;
  int get signupsNum => _signupsNum;

  CompetitionModel.fromJson(Map<String, dynamic> json) {
    _creator = json['creator'];
    _title = json['title'];
    _media = json['media'];
    _description = json['description'];
    _timestamp = json['timestamp'];
    _deadline = json['deadline'];
    _files = json['files'].cast<String>();
    _category1 = json['category1'];
    _category2 = json['category2'];
    _category3 = json['category3'];
    _favSolutions = json['fav_solutions'].cast<String>();
    _maxUsersNum = json['max_users_num'];
    _signupsNum = json['signups_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator'] = _creator;
    data['title'] = _title;
    data['media'] = _media;
    data['description'] = _description;
    data['timestamp'] = _timestamp;
    data['deadline'] = _deadline;
    data['files'] = _files;
    data['category1'] = _category1;
    data['category2'] = _category2;
    data['category3'] = _category3;
    data['fav_solutions'] = _favSolutions;
    data['max_users_num'] = _maxUsersNum;
    data['signups_num'] = _signupsNum;
    return data;
  }
}
