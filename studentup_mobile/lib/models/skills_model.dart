import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';

class SkillsModel extends BaseModel {
  double _avgRating;
  String _description;
  String _name;
  String _userId;
  String _category;
  CollectionReference _ratings;

  SkillsModel(
      {double avgRating,
      String description,
      String name,
      String userId,
      String category,
      CollectionReference ratings}) {
    _avgRating = avgRating;
    _description = description;
    _name = name;
    _userId = userId;
    _ratings = ratings;
    _category = category;
  }

  double get avgRating => _avgRating ?? 0.0;
  String get description => _description ?? 'No Description';
  String get name => _name ?? 'No Name';
  String get userId => _userId ?? '';
  String get category => _category ?? 'No Category';
  CollectionReference get ratings => _ratings;
  bool get canEdit => _userId == Locator.of<BaseAuth>().currentUserId;

  SkillsModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _ratings = doc.reference.collection('ratings');
    _avgRating = json['avg_rating'];
    _description = json['description'];
    _name = json['name'];
    _userId = json['user_id'];
    _category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_rating'] = _avgRating;
    data['description'] = _description;
    data['name'] = _name;
    data['user_id'] = _userId;
    data['category'] = _category;
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
