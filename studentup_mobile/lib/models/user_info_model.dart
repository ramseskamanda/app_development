import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

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
    int age,
    String university,
    String faculty,
    String degree,
    String gradDate,
    GeoPoint location,
    String bio,
    String mediaRef,
    bool banned,
    int experienceMonthly,
    int experienceOverall,
  }) {
    _givenName = givenName;
    _age = age;
    _university = university;
    _faculty = faculty;
    _degree = degree;
    _gradDate = gradDate;
    _location = location;
    _bio = bio;
    _mediaRef = mediaRef;
    _banned = banned;
    _experienceMonthly = experienceMonthly;
    _experienceOverall = experienceOverall;
  }

  String get givenName => _givenName ?? '500 Error';
  int get age => _age ?? 0;
  String get university => _university ?? '500 Error';
  String get faculty => _faculty ?? '500 Error';
  String get degree => _degree ?? '500 Error';
  String get gradDate => _gradDate ?? '500 Error';
  GeoPoint get location => _location ?? GeoPoint(0, 0);
  String get bio => _bio ?? '500 Error';
  String get mediaRef => _mediaRef ?? '500 Error';
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
