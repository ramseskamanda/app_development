import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/locator.dart';

class ChatsNotifier extends NetworkReader {
  String _uid;
  BaseAPIReader _firestoreReader;
  Stream<QuerySnapshot> _chats;

  ChatsNotifier() {
    _firestoreReader = Locator.of<BaseAPIReader>();
    _uid = Locator.of<AuthService>().currentUser.uid;
    fetchData();
  }

  Stream<QuerySnapshot> get chatPreviews => _chats;

  @override
  Future fetchData() async {
    isLoading = true;
    _chats = _firestoreReader.fetchChatPreviews(_uid).asBroadcastStream();
    isLoading = false;
  }
}
