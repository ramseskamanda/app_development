import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/locator.dart';

class ChatsNotifier extends NetworkIO {
  String _uid;
  BaseAPIReader _firestoreReader;
  Stream<List<ChatModel>> _chats;

  ChatsNotifier() {
    _firestoreReader = Locator.of<BaseAPIReader>();
    _uid = Locator.of<AuthService>().currentUser.uid;
    fetchData();
  }

  Stream<List<ChatModel>> get chatPreviews => _chats;

  @override
  Future fetchData() async {
    isReading = true;
    _chats = _firestoreReader.fetchChatPreviews(_uid).asBroadcastStream();
    isReading = false;
  }

  @override
  Future<bool> sendData([data]) async {
    try {
      print('Marking as seen.');
      final String docId = data as String;
      await writer.markAsRead(docId: docId);
      print('Done marking as seen.');
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }
}
