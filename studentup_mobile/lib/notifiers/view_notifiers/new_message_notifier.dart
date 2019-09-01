import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewMessageNotifier extends NetworkNotifier {
  FirestoreWriter _firestoreWriter;

  TextEditingController _newMessage;
  ChatModel _ref;

  UserInfoModel selectedUser;

  NewMessageNotifier() {
    _firestoreWriter = FirestoreWriter();
    _newMessage = TextEditingController();
  }

  TextEditingController get newMessage => _newMessage;
  ChatModel get newChat => _ref;
  bool get canSend => selectedUser != null && _newMessage.text.isNotEmpty;

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}

  @override
  void dispose() {
    _newMessage.dispose();
    super.dispose();
  }

  Future<bool> send() async {
    if (!canSend) return false;
    if (canSend) print('sending');
    isLoading = true;
    //make models
    final UserInfoModel user = Locator.of<ProfileNotifier>().info;
    final chat = ChatModel(
      participants: Participants(
        previews: {
          user.docId: Preview(
            givenName: user.givenName,
            imageUrl: user.mediaRef,
          ),
          selectedUser.docId: Preview(
            givenName: selectedUser.givenName,
            imageUrl: selectedUser.mediaRef,
          ),
        },
      ),
    );
    final message = MessageModel(
      seenAt: null,
      sentAt: DateTime.now(),
      text: _newMessage.text,
      senderId: Locator.of<AuthService>().currentUser.uid,
    );
    //send message
    try {
      _ref = await _firestoreWriter.createChatRoom(
          chat: chat, initialMessage: message);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
      return false;
    }
    isLoading = false;
    return _ref != null;
  }
}
