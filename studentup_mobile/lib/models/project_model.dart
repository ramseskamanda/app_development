import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';
import 'package:studentup_mobile/util/util.dart';

class ProjectModel extends BaseModel {
  String _creator;
  String _creatorMedia;
  String _creatorId;
  String _title;
  String _media;
  String _description;
  Timestamp _timestamp;
  Timestamp _deadline;
  String _category1;
  String _category2;
  String _category3;
  List<String> _favSolutions;
  int _maxUsersNum;
  int _signupsNum;
  List<String> _files;

  ProjectModel({
    @required String creator,
    @required String creatorMedia,
    @required String creatorId,
    @required String title,
    @required String media,
    @required String description,
    @required DateTime timestamp,
    @required DateTime deadline,
    @required int maxUsersNum,
    @required List<SearchCategory> categories,
    @required List<String> files,
  }) {
    _creator = creator;
    _creatorMedia = creatorMedia;
    _creatorId = creatorId;
    _title = title;
    _media = media;
    _description = description;
    _timestamp = Timestamp.fromDate(timestamp);
    _deadline = Timestamp.fromDate(deadline);
    _category1 = categories[0].toString().split('.')[1];
    _category2 =
        categories.length > 1 ? categories[1].toString().split('.')[1] : null;
    _category3 =
        categories.length > 2 ? categories[2].toString().split('.')[1] : null;
    _favSolutions = <String>[];
    _maxUsersNum = maxUsersNum;
    _signupsNum = 0;
    _files = files;
  }

  String get creator => _creator ?? '500 Error';
  String get creatorMedia => _creatorMedia ?? defaultImageUrl;
  String get creatorId => _creatorId ?? '';
  String get title => _title ?? '500 Error';
  String get media => _media ?? defaultImageUrl;
  String get description => _description ?? '500 Error';
  DateTime get timestamp => _timestamp?.toDate() ?? DateTime.now();
  DateTime get deadline => _deadline?.toDate() ?? DateTime.now();
  String get formattedDeadline => Util.format(_deadline ?? Timestamp.now());
  String get category1 => _category1 ?? '500 Error';
  String get category2 => _category2 ?? '500 Error';
  String get category3 => _category3 ?? '500 Error';
  List<String> get favSolutions => _favSolutions ?? <String>[];
  int get maxUsersNum => _maxUsersNum ?? 0;
  int get signupsNum =>
      _signupsNum != null && _signupsNum > 0 ? _signupsNum : 0;
  double get percentSignedUp => signupsNum / maxUsersNum;
  bool get userIsOwner =>
      creatorId == Locator.of<BaseAuth>().currentUserId ?? false;
  List<String> get files => _files ?? [];

  ProjectModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _creator = json['creator'];
    _creatorMedia = json['creator_media'];
    _creatorId = json['creator_id'];
    _title = json['title'];
    _media = json['media'];
    _description = json['description'];
    _timestamp = json['timestamp'];
    _deadline = json['deadline'];
    _category1 = json['category1'];
    _category2 = json['category2'];
    _category3 = json['category3'];
    _favSolutions = json['fav_solutions']?.cast<String>() ?? <String>[];
    _maxUsersNum = json['max_users_num'];
    _signupsNum = json['signups_num'];
    _files = json['files']?.cast<String>() ?? <String>[];
  }

  ProjectModel.fromIndex(AlgoliaObjectSnapshot snapshot)
      : super.fromIndex(snapshot) {
    final Map<String, dynamic> json = snapshot.data;
    _creator = json['creator'];
    _creatorMedia = json['creator_media'];
    _creatorId = json['creator_id'];
    _title = json['title'];
    _media = json['media'];
    _description = json['description'];
    _timestamp = Util.algoliaTimestamp(json['timestamp']);
    _deadline = Util.algoliaTimestamp(json['deadline']);
    _category1 = json['category1'];
    _category2 = json['category2'];
    _category3 = json['category3'];
    _favSolutions = json['fav_solutions']?.cast<String>() ?? <String>[];
    _maxUsersNum = json['max_users_num'];
    _signupsNum = json['signups_num'];
    _files = json['files']?.cast<String>() ?? <String>[];
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
    data['category1'] = _category1;
    data['category2'] = _category2;
    data['category3'] = _category3;
    data['fav_solutions'] = _favSolutions;
    data['max_users_num'] = _maxUsersNum;
    data['signups_num'] = _signupsNum;
    data['files'] = _files;
    return data;
  }
}
