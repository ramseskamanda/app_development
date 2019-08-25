import 'package:algolia/algolia.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/firestore_service.dart';

const String studentIndex = 'students';
const String startupIndex = 'startups';
const String studentSuggestionsIndex = 'Student Suggestions';

//TODO: switch this to a locator service to save resources
//TODO: add Timer.periodic() cache cleaner that checks if cache entry has been there for a long time
class AlgoliaService {
  FirestoreReader _reader = FirestoreReader();
  static final Algolia algolia = Algolia.init(
    applicationId: 'MEXHNSSQ8F',
    apiKey: '3dd31bc0e8065789b946689b8f4eff61',
  );

  static final Map<String, dynamic> cache = <String, dynamic>{};

  Future<List<String>> suggestUsers(String queryString) async {
    //TODO: make this more "sophisticated" by getting the number of people that searched for a certain query etc.
    try {
      // AlgoliaQuery query =
      //     algolia.instance.index(studentSuggestionsIndex).setLength(10);
      // query = query.search(queryString);

      // List _results = (await query.getObjects()).hits;

      // _results.forEach((result) => print(result));
      // return _results.map((snapshot) => snapshot.data['given_name']).toList();
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserInfoModel>> searchUsersWithFacets({
    SearchCategory category = SearchCategory.ALL,
    String queryString = '',
  }) async {
    try {
      if (cache.containsKey(queryString) &&
          cache[queryString].runtimeType is List<UserInfoModel>)
        return cache[queryString];

      print('fetching from network');

      String facet = category.toString().split('.')[1].toLowerCase();
      AlgoliaQuery query = algolia.instance
          .index(studentIndex)
          .setLength(10)
          .setFilters('category = $facet');
      query = query.search(queryString);

      AlgoliaQuerySnapshot _objects = await query.getObjects();

      List<AlgoliaObjectSnapshot> _results = _objects.hits;

      List<UserInfoModel> _mappedResults = await _reader
          .fetchAllUsers(_results.map((r) => r.data['user_id']).toList());

      cache[queryString] = _mappedResults;

      return _mappedResults;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserInfoModel>> searchUsers(String queryString) async {
    try {
      if (cache.containsKey(queryString) &&
          cache[queryString].runtimeType is List<UserInfoModel>)
        return cache[queryString];

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
      if (cache.containsKey(queryString) &&
          cache[queryString].runtimeType is List<StartupInfoModel>)
        return cache[queryString];

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
