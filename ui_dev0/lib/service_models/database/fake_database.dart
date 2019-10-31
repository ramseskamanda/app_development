import 'package:rxdart/rxdart.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/enums/query_order.dart';
import 'package:ui_dev0/service_models/database/base_database_service.dart';
import 'package:ui_dev0/service_models/fake_data.dart';

class FakeDatabase extends BaseDatabaseService {
  @override
  Future<List<CommunityModel>> fetchCommunities(
      {QueryOrder queryOrder = QueryOrder.INTEREST}) async {
    await Future.delayed(const Duration(seconds: 2));
    return FakeData.listCommunities
      ..sort((a, b) => a.posts.length.compareTo(b.posts.length));
  }

  @override
  Observable<List<CommunityModel>> fetchUserCommunities() {
    return Observable.periodic(const Duration(seconds: 5),
        (i) => FakeData.listCommunities.take(i).toList()).asBroadcastStream();
  }

  @override
  Observable<List<CommunityPostModel>> fetchPostsFeed({
    QueryOrder queryOrder = QueryOrder.INTEREST,
    List<String> communityIds,
  }) {
    final List<CommunityPostModel> _posts = FakeData.listCommunities
        .expand((com) => com.posts)
        .toList()
          ..sort((a, b) => a.postedAt.compareTo(b.postedAt));

    return Observable.periodic(
            const Duration(seconds: 5), (i) => _posts.take(i).toList())
        .asBroadcastStream();
  }

  @override
  Observable<List<FileAsset>> fetchCommunityFiles({List<String> communityIds}) {
    final List<FileAsset> _files = FakeData.listCommunities
        .expand((com) => com.posts)
        .expand((post) => post.files)
        .toList()
          ..sort((a, b) => a.postedAt.compareTo(b.postedAt));

    return Observable.periodic(
            const Duration(seconds: 5), (i) => _files.take(i).toList())
        .asBroadcastStream();
  }

  @override
  Observable<List<CommunityModel>> fetchUserCommunityJoinRequests() {
    return Observable<List<CommunityModel>>.fromIterable([])
        .asBroadcastStream();
  }

  @override
  Observable<List<CommunityPostModel>> fetchConversations(
      {List<String> conversationIds}) {
    final List<CommunityPostModel> _files =
        FakeData.listCommunities[1].posts[0].replies;

    return Observable.periodic(
            const Duration(seconds: 5), (i) => _files.take(i).toList())
        .asBroadcastStream();
  }
}
