import 'package:flutter/foundation.dart';
import 'package:ui_dev/models/message_model.dart';

class ChatModel {
  /*
    TODO: Maybe save the last message's id
    in memory to check the ones that haven't
    been read yet.
  */
  String _id;
  String _interlocutorId;
  List<MessageModel> _messages;
  bool _status;
  int _numUnread;
  String _imageUrl;

  ChatModel({
    @required String id,
    @required String interlocutorId,
    @required List<MessageModel> messages,
    @required bool status,
    @required int numUnread,
  })  : _id = id,
        _interlocutorId = interlocutorId,
        _messages = messages,
        _status = status,
        _numUnread = numUnread,
        _imageUrl = 'https://via.placeholder.com/150';

  String get id => _id ?? 'Error id';
  String get interlocutorId => _interlocutorId ?? 'Error id';
  List<MessageModel> get messages => _messages ?? <String>[];
  bool get status => _status ?? false;
  int get numUnread => _numUnread ?? 0;
  String get imageUrl => _imageUrl ?? '';
}
