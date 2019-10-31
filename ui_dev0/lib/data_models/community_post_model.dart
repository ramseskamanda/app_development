import 'package:flutter/foundation.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/data_models/user_model.dart';

class CommunityPostModel {
  final String id;
  final String communityId;
  final String communityName;
  final UserModel originalPoster;
  final String content;
  final List<FileAsset> files;
  final List<CommunityPostModel> replies;
  final int replyCount;
  final int replyGeneration; //0: original post, 1: reply, 2: reply to reply
  final DateTime postedAt;
  final Map<String, int> reactions;

  const CommunityPostModel({
    @required this.id,
    @required this.communityId,
    @required this.communityName,
    @required this.originalPoster,
    @required this.content,
    @required this.postedAt,
    this.replies = const [],
    this.reactions = const {},
    this.files = const [],
    this.replyCount = 0,
    this.replyGeneration = 0,
  });
}
