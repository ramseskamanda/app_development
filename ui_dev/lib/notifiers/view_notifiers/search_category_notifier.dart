import 'package:ui_dev/enum/search_enum.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class SearchCategoryNotifier extends ViewNotifier {
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
  Future fetchData([dynamic data]) async {
    isLoading = true;
    _users = await _firestoreService.fetchUsersByCategory(_searchCategory);
    isLoading = false;
  }

  @override
  Future onRefresh() async => fetchData();
}
