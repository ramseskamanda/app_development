import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

class MessageModel extends BaseModel {
  Timestamp _seenAt;
  Timestamp _sentAt;
  String _text;
  String _senderId;

  MessageModel(
      {DateTime seenAt, DateTime sentAt, String text, String senderId}) {
    _seenAt = null;
    _sentAt = Timestamp.fromDate(sentAt);
    _text = text;
    _senderId = senderId;
  }

  DateTime get seenAt => _seenAt?.toDate() ?? null;
  DateTime get sentAt => _sentAt.toDate();
  String get text => _text;
  String get senderId => _senderId;

  MessageModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _seenAt = json['seenAt'];
    _sentAt = json['sentAt'];
    _text = json['text'];
    _senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seenAt'] = _seenAt;
    data['sentAt'] = _sentAt;
    data['text'] = _text;
    data['sender_id'] = _senderId;
    return data;
  }
}
