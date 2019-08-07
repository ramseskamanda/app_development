import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_dev/models/message_model.dart';
import 'package:ui_dev/services/base_service.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class MessagingService extends BaseService {
  CollectionReference _collection;
  Stream<List<MessageModel>> _messages;
  FirestoreReaderService _firestoreReaderService;
  FirestoreUploadService _firestoreUploadService;
  String _userId;

  TextEditingController _controller;
  FocusNode _focusNode;
  bool _canSend;

  MessagingService({
    @required CollectionReference collection,
    @required String uid,
  }) : _collection = collection {
    _firestoreReaderService = FirestoreReaderService();
    _firestoreUploadService = FirestoreUploadService();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _canSend = false;
    _userId = uid;
    initialize();
  }

  Stream<List<MessageModel>> get messages => _messages;
  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;
  bool get canSend => _canSend;
  set canSend(bool value) {
    _canSend = value ?? false;
    notifyListeners();
  }

  @override
  void initialize() {
    _messages = _firestoreReaderService.fetchMessages(_collection);
  }

  @override
  void dispose() {
    super.dispose();
    _messages = null;
    _collection = null;
    _controller.dispose();
    _focusNode.dispose();
  }

  Future<void> sendMessage() async {
    if (_canSend) {
      try {
        MessageModel message = MessageModel(
          seenAt: null,
          senderId: _userId,
          text: _controller.text,
          sentAt: DateTime.now(),
        );
        _controller.clear();
        canSend = false;
        await _firestoreUploadService.uploadMessage(
          messageModel: message,
          to: _collection,
        );
      } catch (e) {
        //TODO: add error dialog
        print(e);
      }
    }
  }

  Future deleteConversation() async {
    await _firestoreUploadService.removeConversation(_collection);
  }
}
