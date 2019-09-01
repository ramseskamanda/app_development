import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/algolia_service.dart';

class SearchCategoryNotifier extends NetworkNotifier {
  List<UserInfoModel> _users;
  SearchCategory _searchCategory;
  AlgoliaService _algoliaService;

  SearchCategoryNotifier(SearchCategory category) : assert(category != null) {
    _algoliaService = AlgoliaService();
    _searchCategory = category;
    fetchData();
  }

  List<UserInfoModel> get users =>
      (isLoading || hasError || _users == null) ? [] : _users;

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      if (_searchCategory == SearchCategory.ALL)
        _users = await _algoliaService.searchUsers('');
      else
        _users = await _algoliaService.searchUsersWithFacets(
            category: _searchCategory);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}
