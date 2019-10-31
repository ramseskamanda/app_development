import 'package:rxdart/rxdart.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/enums/query_order.dart';

abstract class BaseDatabaseService {
  Future<List<CommunityModel>> fetchCommunities(
      {QueryOrder queryOrder = QueryOrder.INTEREST});
  Observable<List<CommunityModel>> fetchUserCommunities();
  Observable<List<CommunityModel>> fetchUserCommunityJoinRequests();
  Observable<List<CommunityPostModel>> fetchPostsFeed(
      {QueryOrder queryOrder = QueryOrder.INTEREST, List<String> communityIds});
  Observable<List<FileAsset>> fetchCommunityFiles({List<String> communityIds});
  Observable<List<CommunityPostModel>> fetchConversations(
      {List<String> conversationIds});
}
