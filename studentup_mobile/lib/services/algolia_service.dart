import 'package:algolia/algolia.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

const String studentIndex = 'students';
const String startupIndex = 'startups';
const String skillsIndex = 'skills';
const String studentSuggestionsIndex = 'Student Suggestions';

class AlgoliaService {
  FirestoreReader _reader = Locator.of<FirestoreReader>();
  static final Algolia algolia = Algolia.init(
    applicationId: 'MEXHNSSQ8F',
    apiKey: '3dd31bc0e8065789b946689b8f4eff61',
  );

  static final Map<String, dynamic> cache = <String, dynamic>{};

  _removeDuplicates({List<AlgoliaObjectSnapshot> list, String property}) {
    final List<String> _valuesPresent = [];
    return list.where((value) {
      if (_valuesPresent.contains(value.data[property])) return false;
      _valuesPresent.add(value.data[property]);
      return true;
    }).toList();
  }

  _searchCache<T>(String queryString, SearchCategory category) {
    return null;
    // if (cache.containsKey(queryString) &&
    //     cache[queryString].runtimeType is List<T>) return cache[queryString];
  }

  Future<List<UserInfoModel>> searchUsersWithFacets({
    SearchCategory category = SearchCategory.ALL,
    String queryString = '',
  }) async {
    try {
      final cacheResult = _searchCache<UserInfoModel>(queryString, category);
      if (cacheResult != null) return cacheResult;
      print('fetching from network');

      String facet = category.toString().split('.')[1].toLowerCase();
      AlgoliaQuery query = category == SearchCategory.ALL
          ? algolia.instance.index(skillsIndex).setLength(10)
          : algolia.instance
              .index(skillsIndex)
              .setLength(10)
              .setFilters('category:$facet');
      query = query.search(queryString);

      AlgoliaQuerySnapshot _objects = await query.getObjects();

      List<AlgoliaObjectSnapshot> _results = _removeDuplicates(
        list: _objects.hits,
        property: 'user_id',
      );

      print(_results.length);

      List<UserInfoModel> _mappedResults = await _reader.fetchAllUsers(
          _results.map((r) => r.data['user_id'] as String).toList());

      cache[queryString] = _mappedResults;

      return _mappedResults;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserInfoModel>> searchUsers(String queryString) async {
    try {
      final cacheResult =
          _searchCache<UserInfoModel>(queryString, SearchCategory.ALL);
      if (cacheResult != null) return cacheResult;

      print('fetching from network');

      AlgoliaQuery query = algolia.instance.index(studentIndex).setLength(10);
      query = query.search(queryString);

      AlgoliaQuerySnapshot _objects = await query.getObjects();

      List<AlgoliaObjectSnapshot> _results = _objects.hits;

      List<UserInfoModel> _mappedResults = _results
          .map((snapshot) => UserInfoModel.fromIndex(snapshot))
          .toList();

      cache[queryString] = _mappedResults;

      return _mappedResults;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<StartupInfoModel>> searchStartups(String queryString) async {
    try {
      final cacheResult =
          _searchCache<StartupInfoModel>(queryString, SearchCategory.ALL);
      if (cacheResult != null) return cacheResult;

      print('fetching from network');

      AlgoliaQuery query = algolia.instance.index(startupIndex).setLength(10);
      query = query.search(queryString);

      AlgoliaQuerySnapshot _objects = await query.getObjects();

      List<AlgoliaObjectSnapshot> _results = _objects.hits;

      List<StartupInfoModel> _mappedResults = _results
          .map((snapshot) => StartupInfoModel.fromIndex(snapshot))
          .toList();

      cache[queryString] = _mappedResults;

      return _mappedResults;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<int, List<dynamic>>> searchUsersAndStartups(
      String queryString) async {
    final List<UserInfoModel> _users = await searchUsers(queryString);
    final List<StartupInfoModel> _startups = await searchStartups(queryString);
    return {0: _users, 1: _startups};
  }
}
