import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class MessagingService extends ChangeNotifier {
  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;

  CollectionReference _collectionReference;

  TextEditingController _controller;
  FocusNode _focusNode;
  bool _canSend;

  MessagingService({
    @required CollectionReference collection,
    @required String uid,
  }) {
    _collectionReference = collection;
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _canSend = false;
    _firestoreReader = Locator.of<FirestoreReader>();
    _firestoreWriter = Locator.of<FirestoreWriter>();
  }

  Stream<QuerySnapshot> get messages =>
      _firestoreReader.fetchMessages(_collectionReference);
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

  Future<void> sendMessage() async {
    if (_canSend) {
      try {
        MessageModel message = MessageModel(
          seenAt: null,
          senderId: Locator.of<AuthService>().currentUser.uid,
          text: _controller.text,
          sentAt: DateTime.now(),
        );
        canSend = false;
        bool result = await _firestoreWriter.uploadMessage(
          messageModel: message,
          to: _collectionReference,
        );
        if (result) _controller.clear();
      } catch (e) {
        //TODO: add error dialog
        print(e);
      }
    }
  }

  Future deleteConversation() async {
    await _firestoreWriter.removeConversation(
      conversation: _collectionReference,
    );
  }
}
