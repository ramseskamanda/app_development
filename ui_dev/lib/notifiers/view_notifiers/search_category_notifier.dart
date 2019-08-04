import 'package:ui_dev/enum/search_enum.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/search_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class SearchCategoryNotifier extends SearchNotifier {
  List<UserInfoModel> _users;
  FirestoreReaderService _firestoreService;
  SearchCategory _searchCategory;

  SearchCategoryNotifier(SearchCategory category) : assert(category != null) {
    _users = [];
    _searchCategory = category;
    _firestoreService = FirestoreReaderService();
    fetchData();
  }

  List<UserInfoModel> get users => isLoading || hasError ? [] : _users;

  @override
  Future fetchData() async {
    isLoading = true;
    _users = await _firestoreService.fetchUsersByCategory(_searchCategory);
    isLoading = false;
  }

  @override
  Future onRefresh() async => fetchData();

  @override
  Future<List<UserInfoModel>> searchFor(String query) async {
    //check the cache
    if (await searchInCache(query))
      //if in cache, return values
      return cache[query];
    //if not, search for it with firestore
    var results = await _firestoreService.fetchUsersByQueryAndCategory(
      query,
      _searchCategory,
    );
    if (results == null) error = NetworkError('Network search went wrong...');
    return results;
  }
}
