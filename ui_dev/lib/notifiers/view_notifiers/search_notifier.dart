import 'package:flutter/material.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';

abstract class SearchNotifier extends ViewNotifier {
  // ! TODO: Add Algolia
  Map<String, dynamic> cache = {};

  Future<List<UserInfoModel>> searchFor(String query);

  @protected
  Future<bool> searchInCache(String query) async {
    if (cache.keys.contains(query))
      return true;
    else
      return false;
  }

  @override
  void dispose() {
    cache.clear();
    super.dispose();
  }
}
