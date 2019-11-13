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
    return Observable.fromFuture(
      Future.delayed(
        const Duration(seconds: 2),
        () => FakeData.listCommunities,
      ),
    ).asBroadcastStream();
  }

  @override
  Observable<List<CommunityPostModel>> fetchPostsFeed({
    QueryOrder queryOrder = QueryOrder.INTEREST,
    List<CommunityModel> communities,
  }) {
    final List<CommunityPostModel> _posts = FakeData.listCommunities
        .expand((com) => com.posts)
        .toList()
          ..sort((a, b) => a.postedAt.compareTo(b.postedAt));

    return Observable.fromFuture(
      Future.delayed(
        const Duration(seconds: 2),
        () => _posts,
      ),
    ).asBroadcastStream();
  }

  @override
  Observable<List<FileAsset>> fetchCommunityFiles(
      {List<CommunityModel> communities}) {
    final List<FileAsset> _files = FakeData.listCommunities
        .expand((com) => com.posts)
        .expand((post) => post.files)
        .toList()
          ..sort((a, b) => a.postedAt.compareTo(b.postedAt));

    return Observable.fromFuture(
      Future.delayed(
        const Duration(seconds: 2),
        () => _files,
      ),
    ).asBroadcastStream();
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

    return Observable.fromFuture(
      Future.delayed(
        const Duration(seconds: 2),
        () => _files,
      ),
    ).asBroadcastStream();
  }
}
