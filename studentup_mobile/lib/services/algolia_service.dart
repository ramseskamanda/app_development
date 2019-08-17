import 'package:algolia/algolia.dart';
import 'package:studentup_mobile/models/user_info_model.dart';

const String studentIndex = 'students';
const String studentSuggestionsIndex = 'Student Suggestions';

//TODO: switch this to a locator service to save resources
//TODO: add Timer.periodic() cache cleaner that checks if cache entry has been there for a long time
class AlgoliaService {
  static final Algolia algolia = Algolia.init(
    applicationId: 'MEXHNSSQ8F',
    apiKey: '3dd31bc0e8065789b946689b8f4eff61',
  );

  static final Map<String, dynamic> cache = <String, dynamic>{};

  Future<List<String>> suggestUsers(String queryString) async {
    //TODO: make this more "sophisticated" by getting the number of people that searched for a certain query etc.
    try {
      AlgoliaQuery query =
          algolia.instance.index(studentSuggestionsIndex).setLength(10);
      query = query.search(queryString);

      List _results = (await query.getObjects()).hits;

      _results.forEach((result) => print(result));
      // return _results.map((snapshot) => snapshot.data['given_name']).toList();
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserInfoModel>> searchUsers(String queryString) async {
    try {
      if (cache.containsKey(queryString)) return cache[queryString];

      print('fetching from network');

      AlgoliaQuery query = algolia.instance.index(studentIndex).setLength(10);
      query = query.search(queryString);

      AlgoliaQuerySnapshot _objects = await query.getObjects();

      List<AlgoliaObjectSnapshot> _results = _objects.hits;

      List<UserInfoModel> _mappedResults = _results
          .map((snapshot) => UserInfoModel.fromJson(snapshot.data))
          .toList();

      cache[queryString] = _mappedResults;

      return _mappedResults;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
