import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';

abstract class BaseSearchAPI {
  final Map<String, dynamic> cache = <String, dynamic>{};

  Future<List<ProjectModel>> searchProjects(String queryString);
  Future<List<UserInfoModel>> searchUsers(String queryString);
  Future<List<StartupInfoModel>> searchStartups(String queryString);
  Future<List<UserInfoModel>> searchUsersWithFacets({
    SearchCategory category = SearchCategory.ALL,
    String queryString = '',
  });

  Future<Map<int, List<dynamic>>> searchUsersAndStartups(
      String queryString) async {
    final List<UserInfoModel> _users = await searchUsers(queryString);
    final List<StartupInfoModel> _startups = await searchStartups(queryString);
    return {0: _users, 1: _startups};
  }

  @protected
  searchCache<T>(String queryString, SearchCategory category) {
    return null;
    // if (cache.containsKey(queryString) &&
    //     cache[queryString].runtimeType is List<T>) return cache[queryString];
  }
}
