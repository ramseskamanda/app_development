import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/enum/messaging_action.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class MessagingNotifier extends NetworkIO {
  CollectionReference _collectionReference;
  Stream<QuerySnapshot> _messages;

  TextEditingController _controller;
  FocusNode _focusNode;
  bool _canSend;

  MessagingNotifier({
    @required CollectionReference collection,
    @required String uid,
  }) {
    _collectionReference = collection;
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _canSend = false;
    fetchData();
  }

  Stream<QuerySnapshot> get messages => _messages;
  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;
  bool get canSend => _canSend;
  set canSend(bool value) {
    _canSend = value ?? false;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_canSend) {
      MessageModel message = MessageModel(
        seenAt: null,
        senderId: Locator.of<AuthService>().currentUser.uid,
        text: _controller.text,
        sentAt: DateTime.now(),
      );
      canSend = false;
      await writer.uploadMessage(
        messageModel: message,
        collectionPath: _collectionReference.path,
      );
      _controller.clear();
    }
  }

  Future _deleteConversation() async => await writer.removeConversation(
      collectionPath: _collectionReference.path);

  @override
  Future<void> fetchData() async {
    isReading = true;
    _messages = reader
        .fetchMessages(_collectionReference.path)
        .map((d) => d as QuerySnapshot);
    isReading = false;
  }

  @override
  Future<bool> sendData([data]) async {
    try {
      switch (data) {
        case MessagingAction.SEND:
          _sendMessage();
          break;
        case MessagingAction.DELETE:
          _deleteConversation();
          break;
        default:
          throw 'No Action for: $data';
      }
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }
}
