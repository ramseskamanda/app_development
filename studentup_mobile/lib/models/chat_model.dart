import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/config.dart';

class ChatModel extends BaseModel {
  Participants _participants;
  CollectionReference _messages;
  String _userId;
  MessageModel _lastMessage;

  ChatModel({
    Participants participants,
    MessageModel lastMessage,
  }) {
    _participants = participants;
    _lastMessage = lastMessage;
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
    _userId = Locator.of<AuthService>().currentUser.uid;
    _messages = doc.reference.collection('messages');
    _lastMessage = json['latest_message'] != null
        ? MessageModel.fromJson(
            Map<dynamic, dynamic>.from(json['latest_message']))
        : null;
    _participants = json['participants'] != null
        ? Participants.fromJson(
            Map<dynamic, dynamic>.from(json['participants']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_participants != null) data['participants'] = _participants.toJson();
    if (_participants != null)
      data['list_participants'] = _participants._previews.keys.toList();
    if (_lastMessage != null) data['latest_message'] = _lastMessage.toJson();
    return data;
  }

  @override
  String toString() {
    return '${participants.toString()}';
  }
}

class Participants {
  Map<String, Preview> _previews;

  Participants({Map<String, Preview> previews}) {
    _previews = previews;
  }

  Preview getOtherUserInfo(String user) {
    String otherId =
        _previews.keys.firstWhere((key) => key != user, orElse: () => user);
    return _previews[otherId];
  }

  Participants.fromJson(Map<dynamic, dynamic> json) {
    _previews = {};

    if (json.keys.length > 0 && json.keys.length <= 2)
      json.forEach(
          (key, value) => _previews[key] = Preview.fromJson(json[key], key));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_previews != null)
      _previews.forEach((key, value) => data[key] = value.toJson());

    return data;
  }

  @override
  String toString() {
    return '${_previews.toString()}';
  }
}

class Preview {
  String _givenName;
  String _imageUrl;
  String _uid;

  Preview({String givenName, String imageUrl, String uid}) {
    _givenName = givenName;
    _imageUrl = imageUrl;
    _uid = uid;
  }

  String get givenName => _givenName ?? 'No Name Provided';
  String get imageUrl => _imageUrl ?? defaultImageUrl;
  String get uid => _uid ?? '';

  Preview.fromJson(Map<dynamic, dynamic> json, String uid) {
    _givenName = json['given_name'];
    _imageUrl = json['imageUrl'];
    _uid = uid;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['given_name'] = _givenName;
    data['imageUrl'] = _imageUrl;
    return data;
  }

  @override
  String toString() {
    return '$_givenName :: $_uid';
  }
}
