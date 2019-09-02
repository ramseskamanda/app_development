import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/util/config.dart';
import 'package:studentup_mobile/util/util.dart';

class UserInfoModel extends BaseModel {
  String _givenName;
  int _age;
  String _university;
  String _faculty;
  String _degree;
  String _gradDate;
  GeoPoint _location;
  String _bio;
  String _mediaRef;
  bool _banned;
  int _experienceMonthly;
  int _experienceOverall;
  String locationString;

  UserInfoModel({
    String givenName,
    String mediaRef,
  }) {
    _givenName = givenName;
    _age = null;
    _university = null;
    _faculty = null;
    _degree = null;
    _gradDate = null;
    _location = null;
    _bio = null;
    _mediaRef = mediaRef;
    _banned = false;
    _experienceMonthly = 0;
    _experienceOverall = 0;
  }

  String get givenName => _givenName ?? 'No Name';
  int get age => _age ?? 0;
  String get university => _university ?? 'No university';
  String get faculty => _faculty ?? 'No faculty';
  String get degree => _degree ?? 'No degree';
  String get gradDate => _gradDate ?? 'No graduation date';
  String get location => Util.geoPointToLocation(_location) ?? 'No Location';
  String get bio =>
      _bio ??
      'No bio yet!\n\n Write something short to introduce yourself to the community';
  String get mediaRef => _mediaRef ?? defaultImageUrl;
  bool get banned => _banned ?? true;
  int get experienceMonthly => _experienceMonthly ?? 0;
  int get experienceOverall => _experienceOverall ?? 0;

  UserInfoModel.fromIndex(AlgoliaObjectSnapshot snapshot)
      : super.fromIndex(snapshot) {
    final Map<String, dynamic> json = snapshot.data;
    _givenName = json['given_name'];
    _age = json['age'];
    _university = json['university'];
    _faculty = json['faculty'];
    _degree = json['degree'];
    _gradDate = json['grad_date'];
    _bio = json['bio'];
    _mediaRef = json['media_ref'];
    _banned = json['banned'];
    _experienceMonthly = json['experience_month'];
    _experienceOverall = json['experience_overall'];
  }

  UserInfoModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _givenName = json['given_name'];
    _age = json['age'];
    _university = json['university'];
    _faculty = json['faculty'];
    _degree = json['degree'];
    _gradDate = json['grad_date'];
    _location = json['location'];
    _bio = json['bio'];
    _mediaRef = json['media_ref'];
    _banned = json['banned'];
    _experienceMonthly = json['experience_month'];
    _experienceOverall = json['experience_overall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['given_name'] = _givenName;
    data['age'] = _age;
    data['university'] = _university;
    data['faculty'] = _faculty;
    data['degree'] = _degree;
    data['grad_date'] = _gradDate;
    data['location'] = _location;
    data['bio'] = _bio;
    data['media_ref'] = _mediaRef;
    data['banned'] = _banned;
    data['experience_month'] = _experienceMonthly;
    data['experience_overall'] = _experienceOverall;
    return data;
  }
}
