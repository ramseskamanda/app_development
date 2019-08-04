import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/search_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class GeneralSearchNotifier extends SearchNotifier {
  FirestoreReaderService _firestoreService;

  GeneralSearchNotifier() : _firestoreService = FirestoreReaderService();

  @override
  Future fetchData() async => null;

  @override
  Future onRefresh() async => null;

  @override
  Future<List<UserInfoModel>> searchFor(String query) async {
    //check the cache
    if (await searchInCache(query))
      //if in cache, return values
      return cache[query];
    //if not, search for it with firestore
    var results = await _firestoreService.fetchUsersByQuery(query);
    if (results == null) error = NetworkError('Network search went wrong...');
    return results;
  }
}
