import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class UserSearchNotifier extends NetworkNotifier {
  List<UserInfoModel> _users;
  Map<String, List<UserInfoModel>> cache = {};

  UserSearchNotifier([SearchCategory category]) : assert(category != null) {
    _users = [];
  }

  List<UserInfoModel> get users => isLoading || hasError ? [] : _users;

  @override
  Future fetchData() async {
    isLoading = true;
    // _users = await _firestoreService.fetchUsersByCategory(_searchCategory);
    isLoading = false;
  }

  @override
  Future onRefresh() async => fetchData();

  Future<List<UserInfoModel>> searchFor(String query) async {
    //check the cache
    if (cache.containsKey(query)) return cache[query];
    //if not, search for it with firestore
    List<UserInfoModel> results = [];
    if (results == null)
      error = NetworkError(message: 'Network search went wrong...');
    cache[query] = results;
    return results;
  }
}
