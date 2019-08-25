import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ChatModel extends BaseModel {
  Participants _participants;
  CollectionReference _messages;
  String _userId;
  MessageModel _lastMessage;

  ChatModel({
    Participants participants,
    CollectionReference collectionReference,
  }) {
    _participants = participants;
    _messages = collectionReference;
  }

  String get userId => _userId;
  Participants get participants => _participants;
  CollectionReference get messagesCollection => _messages;
  MessageModel get lastMessage => _lastMessage;
  Preview get otherProfile => _participants?.getOtherUserInfo(_userId);
  bool get userHasUnread =>
      _lastMessage.senderId == _userId && _lastMessage.seenAt == null;

  ChatModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    print(json);
    _userId = Locator.of<AuthService>().currentUser.uid;
    _messages = doc.reference.collection('messages');
    _lastMessage = json['latest_message'] != null
        ? MessageModel.fromJson(json['latest_message'])
        : null;
    _participants = json['participants'] != null
        ? Participants.fromJson(json['participants'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_participants != null) data['participants'] = _participants.toJson();
    if (_lastMessage != null) data['latest_message'] = _lastMessage.toJson();
    return data;
  }
}

class Participants {
  Map<String, Preview> _previews;

  Participants({Map<String, Preview> previews}) {
    _previews = previews;
  }

  Preview getOtherUserInfo(String user) {
    String otherId = _previews.keys.firstWhere((key) => key != user);
    return _previews[otherId];
  }

  Participants.fromJson(Map<String, dynamic> json) {
    if (json.keys.length == 2)
      json.forEach(
          (key, value) => _previews[key] = Preview.fromJson(json[key]));
    _previews = {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_previews != null)
      _previews.forEach((key, value) => data[key] = value.toJson());

    return data;
  }
}

class Preview {
  String _givenName;
  String _imageUrl;

  Preview({String givenName, String imageUrl}) {
    _givenName = givenName;
    _imageUrl = imageUrl;
  }

  String get givenName => _givenName;
  String get imageUrl => _imageUrl;

  Preview.fromJson(Map<String, dynamic> json) {
    _givenName = json['given_name'];
    _imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['given_name'] = _givenName;
    data['imageUrl'] = _imageUrl;
    return data;
  }
}
