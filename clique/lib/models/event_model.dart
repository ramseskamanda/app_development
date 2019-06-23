import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  int _capacity;
  GeoPoint _location;
  int _estimatedAttending;
  List<String> _medias;
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
  List<String> get medias => _medias ?? <String>[];
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
    _medias = doc['medias'].cast<String>();
    _creatorId = doc['creator_id'];
    _public = doc['public'];
    _time = doc['start_time'];
    _type = doc['type'];
    _name = doc['name'];
    _attendingCount = doc['attending_count'];
  }
}
