import 'package:cloud_firestore/cloud_firestore.dart';

class SkillsModel {
  double _avgRating;
  String _description;
  String _name;
  String _userId;
  CollectionReference _ratings;

  SkillsModel(
      {double avgRating,
      String description,
      String name,
      String userId,
      CollectionReference ratings}) {
    _avgRating = avgRating;
    _description = description;
    _name = name;
    _userId = userId;
    _ratings = ratings;
  }

  double get avgRating => _avgRating;
  String get description => _description;
  String get name => _name;
  String get userId => _userId;
  CollectionReference get ratings => _ratings;

  SkillsModel.fromDoc(DocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data;
    _ratings = doc.reference.collection('ratings');
    _avgRating = json['avg_rating'];
    _description = json['description'];
    _name = json['name'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_rating'] = _avgRating;
    data['description'] = _description;
    data['name'] = _name;
    data['user_id'] = _userId;
    return data;
  }
}

class Ratings {
  double _rating;
  String _userId;

  Ratings({double rating, String userId}) {
    _rating = rating;
    _userId = userId;
  }

  double get rating => _rating;
  String get userId => _userId;

  Ratings.fromJson(Map<String, dynamic> json) {
    _rating = json['rating'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = _rating;
    data['user_id'] = _userId;
    return data;
  }
}
