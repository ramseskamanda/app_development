import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/services/firestore_service.dart';

class MessagingService extends ChangeNotifier {
  CollectionReference _collection;
  Stream<List<MessageModel>> _messages;
  FirestoreReader _firestoreReaderService;
  FirestoreWriter _firestoreWriter;
  String _userId;

  TextEditingController _controller;
  FocusNode _focusNode;
  bool _canSend;

  MessagingService({
    @required CollectionReference collection,
    @required String uid,
  }) : _collection = collection {
    _firestoreReaderService = FirestoreReader();
    _firestoreWriter = FirestoreWriter();
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

  void initialize() {
    // _messages = _firestoreReaderService.fetchMessages(_collection);
  }

  @override
  void dispose() {
    _messages = null;
    _collection = null;
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
        // await _firestoreWriter.uploadMessage(
        //   messageModel: message,
        //   to: _collection,
        // );
      } catch (e) {
        //TODO: add error dialog
        print(e);
      }
    }
  }

  Future deleteConversation() async {
    // await _firestoreWriter.removeConversation(_collection);
  }
}
