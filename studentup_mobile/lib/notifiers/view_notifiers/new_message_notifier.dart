import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class NewMessageNotifier extends NetworkWriter {
  TextEditingController _newMessage;
  ChatModel _ref;

  UserInfoModel selectedUser;
  Preview user;

  NewMessageNotifier({this.selectedUser, this.user})
      : _newMessage = TextEditingController();

  TextEditingController get newMessage => _newMessage;
  ChatModel get newChat => _ref;
  bool get canSend => selectedUser != null && _newMessage.text.isNotEmpty;

  @override
  void dispose() {
    _newMessage.dispose();
    super.dispose();
  }

  @override
  Future<bool> sendData() async {
    if (!canSend) return false;
    if (canSend) print('sending');
    isLoading = true;
    //make models
    final message = MessageModel(
      seenAt: null,
      sentAt: DateTime.now(),
      text: _newMessage.text,
      senderId: user.uid,
    );
    final chat = ChatModel(
      lastMessage: message,
      participants: Participants(
        previews: {
          user.uid: user,
          selectedUser.docId: Preview(
            givenName: selectedUser.givenName,
            imageUrl: selectedUser.mediaRef,
            uid: selectedUser.docId,
            isStartup: false,
          ),
        },
      ),
    );
    //send message
    try {
      _ref = await writer.createChatRoom(
        chat: chat,
        initialMessage: message,
      );
      print(_ref);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.runtimeType.toString());
    }
    isLoading = false;
    return _ref != null;
  }
}
