import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

class StartupInfoModel extends BaseModel {
  String _description;
  GeoPoint _location;
  //TODO: make sure this only gets fetched if the user is the owner of this document
  List<String> _savedProfiles;
  String _name;
  String _website;
  String _imageUrl;
  List<String> _team;
  String locationString;
  Timestamp _creationDate;

  StartupInfoModel({
    String name,
    String imageUrl,
    DateTime creation,
  }) {
    _description = null;
    _location = null;
    _savedProfiles = [];
    _name = name;
    _website = null;
    _imageUrl = imageUrl;
    _team = [];
    _creationDate = Timestamp.fromDate(creation);
  }

  String get description => _description ?? '500 Error';
  GeoPoint get location => _location ?? GeoPoint(0, 0);
  List<String> get savedProfiles => _savedProfiles ?? <String>[];
  String get name => _name ?? '500 Error';
  String get website => _website ?? '500 Error';
  String get imageUrl => _imageUrl ?? '500 Error';
  List<String> get team => _team ?? <String>[];
  DateTime get creationDate => _creationDate?.toDate() ?? DateTime.now();

  StartupInfoModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _description = json['description'];
    _location = json['location'];
    _savedProfiles = json['saved_profiles'].cast<String>();
    _name = json['name'];
    _website = json['website'];
    _imageUrl = json['image_url'];
    _team = json['team'].cast<String>();
    _creationDate = json['creation_date'];
  }

  StartupInfoModel.fromIndex(AlgoliaObjectSnapshot snapshot)
      : super.fromIndex(snapshot) {
    final Map<String, dynamic> json = snapshot.data;
    _description = json['description'];
    _savedProfiles = json['saved_profiles'].cast<String>();
    _name = json['name'];
    _website = json['website'];
    _imageUrl = json['image_url'];
    _team = json['team'].cast<String>();
    _creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = _description;
    data['location'] = _location;
    data['saved_profiles'] = _savedProfiles;
    data['name'] = _name;
    data['website'] = _website;
    data['image_url'] = _imageUrl;
    data['team'] = _team;
    data['creation_date'] = _creationDate;
    return data;
  }
}
