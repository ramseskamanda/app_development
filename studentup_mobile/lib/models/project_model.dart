import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/base_model.dart';
// import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
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
  String _attachement;
  String _category1;
  String _category2;
  String _category3;
  List<String> _favSolutions;
  int _maxUsersNum;
  int _signupsNum;
  // ProjectSignupModel _userSignUp;

  ProjectModel({
    @required String creator,
    @required String creatorMedia,
    @required String creatorId,
    @required String title,
    @required String media,
    @required String attachment,
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
    _attachement = attachment;
    _category1 = categories[0].toString().split('.')[1];
    _category2 =
        categories.length > 1 ? categories[1].toString().split('.')[1] : null;
    _category3 =
        categories.length > 2 ? categories[2].toString().split('.')[1] : null;
    _favSolutions = <String>[];
    _maxUsersNum = maxUsersNum;
    _signupsNum = 0;
    // _userSignUp = null;
  }

  String get creator => _creator ?? '500 Error';
  String get creatorMedia => _creatorMedia ?? '500 Error';
  String get creatorId => _creatorId ?? '';
  String get title => _title ?? '500 Error';
  String get media => _media ?? '500 Error';
  String get description => _description ?? '500 Error';
  DateTime get timestamp => _timestamp?.toDate() ?? DateTime.now();
  DateTime get deadline => _deadline?.toDate() ?? DateTime.now();
  String get formattedDeadline => Util.format(_deadline ?? Timestamp.now());
  String get attachment => _attachement ?? '500 Error';
  String get category1 => _category1 ?? '500 Error';
  String get category2 => _category2 ?? '500 Error';
  String get category3 => _category3 ?? '500 Error';
  List<String> get favSolutions => _favSolutions ?? <String>[];
  int get maxUsersNum => _maxUsersNum ?? 0;
  int get signupsNum =>
      _signupsNum != null && _signupsNum > 0 ? _signupsNum : 0;
  // bool get userSignedUp => _userSignUp != null;
  // ProjectSignupModel get userSignUpFile => _userSignUp;
  // set userSignUpFile(ProjectSignupModel value) => _userSignUp = value ?? null;
  double get percentSignedUp => signupsNum / maxUsersNum;
  bool get userIsOwner =>
      creator == Locator.of<AuthService>().currentUser.uid ?? false;

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
    _attachement = json['attachment'];
    _category1 = json['category1'];
    _category2 = json['category2'];
    _category3 = json['category3'];
    _favSolutions = json['fav_solutions']?.cast<String>() ?? <String>[];
    _maxUsersNum = json['max_users_num'];
    _signupsNum = json['signups_num'];
    // _userSignUp = userSignUp;
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
    data['attachment'] = _attachement;
    data['category1'] = _category1;
    data['category2'] = _category2;
    data['category3'] = _category3;
    data['fav_solutions'] = _favSolutions;
    data['max_users_num'] = _maxUsersNum;
    data['signups_num'] = _signupsNum;
    return data;
  }
}
