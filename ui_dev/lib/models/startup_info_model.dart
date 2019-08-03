import 'package:cloud_firestore/cloud_firestore.dart';

class StartupInfoModel {
  String _description;
  GeoPoint _location;
  List<String> _savedProfiles;
  String _name;
  String _website;
  String _imageUrl;

  StartupInfoModel({
    String description,
    GeoPoint location,
    List<String> savedProfiles,
    String name,
    String website,
    String imageUrl,
  }) {
    _description = description;
    _location = location;
    _savedProfiles = savedProfiles;
    _name = name;
    _website = website;
    _imageUrl = imageUrl;
  }

  String get description => _description ?? '404 Error';
  GeoPoint get location => _location ?? GeoPoint(0, 0);
  List<String> get savedProfiles => _savedProfiles ?? <String>[];
  String get name => _name ?? '404 Error';
  String get website => _website ?? '404 Error';
  String get imageUrl => _imageUrl ?? '404 Error';

  StartupInfoModel.fromJson(Map<String, dynamic> json) {
    _description = json['description'];
    _location = json['location'];
    _savedProfiles = json['saved_profiles'].cast<String>();
    _name = json['name'];
    _website = json['website'];
    _imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = _description;
    data['location'] = _location;
    data['saved_profiles'] = _savedProfiles;
    data['name'] = _name;
    data['website'] = _website;
    data['image_url'] = _imageUrl;
    return data;
  }
}
