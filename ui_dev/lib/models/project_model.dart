import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_dev/enum/search_enum.dart';

class ProjectModel {
  String _creator;
  String _creatorMedia;
  String _creatorId;
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
  bool _userSignedUp;

  ProjectModel({
    @required String creator,
    @required String creatorMedia,
    @required String creatorId,
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
    _creatorMedia = creatorMedia;
    _creatorId = creatorId;
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
    _userSignedUp = false;
  }

  String get creator => _creator ?? '404 Error';
  String get creatorMedia => _creatorMedia ?? '404 Error';
  String get creatorId => _creatorId ?? '';
  String get title => _title ?? '404 Error';
  String get media => _media ?? '404 Error';
  String get description => _description ?? '404 Error';
  DateTime get timestamp => _timestamp?.toDate() ?? DateTime.now();
  DateTime get deadline => _deadline?.toDate() ?? DateTime.now();
  List<String> get files => _files ?? <String>[];
  String get category1 => _category1 ?? '404 Error';
  String get category2 => _category2 ?? '404 Error';
  String get category3 => _category3 ?? '404 Error';
  List<String> get favSolutions => _favSolutions ?? <String>[];
  int get maxUsersNum => _maxUsersNum ?? 0;
  int get signupsNum => _signupsNum ?? 0;
  bool get userSignedUp => _userSignedUp ?? false;

  ProjectModel.fromJson(Map<String, dynamic> json, bool userSignedUp) {
    if (json == null) return;
    _creator = json['creator'];
    _creatorMedia = json['creator_media'];
    _creatorId = json['creator_id'];
    _title = json['title'];
    _media = json['media'];
    _description = json['description'];
    _timestamp = json['timestamp'];
    _deadline = json['deadline'];
    _files = json['files']?.cast<String>() ?? <String>[];
    _category1 = json['category1'];
    _category2 = json['category2'];
    _category3 = json['category3'];
    _favSolutions = json['fav_solutions']?.cast<String>() ?? <String>[];
    _maxUsersNum = json['max_users_num'];
    _signupsNum = json['signups_num'];
    _userSignedUp = userSignedUp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator'] = _creator;
    data['creator_media'] = _creatorMedia;
    data['creator_id'] = _creatorId;
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
