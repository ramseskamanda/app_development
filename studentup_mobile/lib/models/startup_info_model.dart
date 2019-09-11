import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/util/config.dart';
import 'package:studentup_mobile/util/util.dart';

class StartupInfoModel extends BaseModel {
  String _description;
  GeoPoint _location;
  String _name;
  String _website;
  String _imageUrl;
  List<Preview> _team;
  Timestamp _creationDate;

  StartupInfoModel({
    String name,
    String imageUrl,
    DateTime creation,
  }) {
    _description = null;
    _location = null;
    _name = name;
    _website = null;
    _imageUrl = imageUrl;
    _team = [];
    _creationDate = Timestamp.fromDate(creation);
  }

  String get description => _description ?? 'No Description Provided';
  GeoPoint get location => _location ?? GeoPoint(0, 0);
  String get locationString => Util.geoPointToLocation(_location);
  String get name => _name ?? 'No Name Provided';
  String get website => _website ?? 'No Website';
  String get imageUrl => _imageUrl ?? defaultImageUrl;
  List<Preview> get team => _team ?? <String>[];
  DateTime get creationDate => _creationDate?.toDate() ?? DateTime.now();

  StartupInfoModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _description = json['description'];
    _location = json['location'];
    _name = json['name'];
    _website = json['website'];
    _imageUrl = json['image_url'];
    _creationDate = json['creation_date'];
    if (json['team'] != null) {
      _team = <Preview>[];
      Map<dynamic, dynamic>.from(json['team'])
          .forEach((k, v) => _team.add(Preview.fromJson(v, k)));
    }
  }

  StartupInfoModel.fromIndex(AlgoliaObjectSnapshot snapshot)
      : super.fromIndex(snapshot) {
    final Map<String, dynamic> json = snapshot.data;
    _description = json['description'];
    _name = json['name'];
    _website = json['website'];
    _imageUrl = json['image_url'];
    _creationDate = json['creation_date'];
    if (json['team'] != null) {
      _team = <Preview>[];
      print(json['team']);
      Map<dynamic, dynamic>.from(json['team'])
          .forEach((k, v) => _team.add(Preview.fromJson(v, k)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = _description;
    data['location'] = _location;
    data['name'] = _name;
    data['website'] = _website;
    data['image_url'] = _imageUrl;
    data['creation_date'] = _creationDate;
    final Map teamJson = {};
    team.forEach((preview) => teamJson[preview.uid] = preview.toJson());
    if (team != null) data['team'] = teamJson;
    return data;
  }
}
