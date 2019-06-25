import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  int _capacity;
  GeoPoint _location;
  int _estimatedAttending;
  String _media;
  String _creatorId;
  bool _public;
  Timestamp _time;
  String _type;
  String _name;
  int _attendingCount;
  DocumentReference _reference;

  int get capacity => _capacity ?? 0;
  GeoPoint get location => _location;
  int get estimatedAttending => _estimatedAttending ?? 0;
  String get media => _media ?? '';
  String get creatorId => _creatorId ?? '';
  bool get public => _public ?? false;
  Timestamp get time => _time ?? Timestamp.now();
  String get type => _type ?? 'Event';
  String get name => _name ?? 'No Name';
  int get attendingCount => _attendingCount ?? 0;
  DocumentReference get reference => _reference;

  Event.fromDoc(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data;
    _reference = snapshot.reference;
    _capacity = doc['capacity'];
    _location = doc['location'];
    _estimatedAttending = doc['estimated_attending'];
    _media = doc['medias'];
    _creatorId = doc['creator_id'];
    _public = doc['public'];
    _time = doc['start_time'];
    _type = doc['type'];
    _name = doc['name'];
    _attendingCount = doc['attending_count'];
  }
}
