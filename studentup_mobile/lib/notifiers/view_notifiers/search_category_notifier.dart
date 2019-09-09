import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class SearchCategoryNotifier extends NetworkSearch {
  List<UserInfoModel> _users;
  SearchCategory _searchCategory;

  SearchCategoryNotifier(SearchCategory category) : assert(category != null) {
    _searchCategory = category;
    fetchData();
  }

  List<UserInfoModel> get users =>
      (isLoading || hasError || _users == null) ? [] : _users;

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _users =
          await searchEngine.searchUsersWithFacets(category: _searchCategory);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }
}
