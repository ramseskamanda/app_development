import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_dev/models/base_model.dart';
import 'package:ui_dev/models/message_model.dart';
import 'package:ui_dev/models/user_info_model.dart';

class ChatModel extends BaseModel {
  List<String> _participants;
  CollectionReference _messages;
  String _userId;
  UserInfoModel _other;
  Map<dynamic, dynamic> _unread;
  MessageModel _lastMessage;

  ChatModel({List<String> participants, CollectionReference messages}) {
    _participants = participants;
    _messages = messages;
  }

  String get userId => _userId;
  List<String> get participants => _participants;
  CollectionReference get messagesCollection => _messages;
  int get userUnread => _unread[userId];
  MessageModel get lastMessage => _lastMessage;
  set lastMessage(MessageModel value) => _lastMessage = value ?? MessageModel();
  UserInfoModel get other => _other;
  set other(UserInfoModel value) => _other = value ?? UserInfoModel();

  ChatModel.fromJson(DocumentSnapshot doc, String uid) : super.fromJson(doc) {
    final Map<String, dynamic> json = doc.data;
    _userId = uid;
    _participants = json['participants'].cast<String>();
    _messages = doc.reference.collection('messages');
    _unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participants'] = _participants;
    data['messages'] = _messages;
    data['unread'] = _unread;
    return data;
  }
}
