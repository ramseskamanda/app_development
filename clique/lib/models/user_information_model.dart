import 'package:clique/util/env.dart';

class UserInformation {
  String _bio;
  List<dynamic> _eventsAttended;
  String _username;
  String _token;

  UserInformation.fromDoc(Map<String, dynamic> data) {
    if (data == null) return;
    _bio = data['bio'] ?? Environment.defaultBio;
    _eventsAttended = data['events_attended'] as List<dynamic> ?? <String>[];
    _username = data['username'];
    _token = data['token'] ?? 'No Token';
  }

  String get bio => _bio;
  List<dynamic> get eventsAttended => _eventsAttended;
  String get username => _username;
  String get deviceToken => _token;
}
