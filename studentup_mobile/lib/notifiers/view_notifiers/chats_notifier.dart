import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ChatsNotifier extends NetworkNotifier {
  String _uid;
  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;

  ChatsNotifier() {
    _firestoreReader = FirestoreReader();
    _firestoreWriter = FirestoreWriter();
    _uid = Locator.of<AuthService>().currentUser.uid;
  }

  Stream<QuerySnapshot> get chatPreviews =>
      _firestoreReader.fetchChatPreviews(_uid);

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
