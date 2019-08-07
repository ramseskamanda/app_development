import 'package:ui_dev/models/chat_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class ChatsNotifier extends ViewNotifier {
  //user info
  String _uid;
  //chats for that user
  List<ChatModel> _conversations;
  //firestore reader
  FirestoreReaderService _firestoreReaderService;

  ChatsNotifier(String uid) {
    _uid = uid;
    _conversations = [];
    _firestoreReaderService = FirestoreReaderService();
    fetchData();
  }

  List<ChatModel> get conversations =>
      !(isLoading || hasError) ? _conversations : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _conversations = await _firestoreReaderService.fetchConversations(_uid);
      if (_conversations == null || !_checkConversations())
        error = NetworkError('Something went wrong...');
    } catch (e) {
      print(e);
      error = NetworkError('Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() async => await fetchData();

  bool _checkConversations() {
    for (ChatModel convo in _conversations)
      if (convo.other == null) return false;
    return true;
  }
}
