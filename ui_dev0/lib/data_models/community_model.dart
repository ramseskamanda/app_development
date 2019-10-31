import 'package:flutter/foundation.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/data_models/user_model.dart';

class CommunityModel {
  final String id;
  final String name;
  final String description;
  final bool public;
  final List<CommunityPostModel> posts;
  final UserModel creator;
  final int memberCount;
  final List<UserModel> members;

  const CommunityModel({
    @required this.id,
    @required this.name,
    @required this.public,
    @required this.creator,
    @required this.description,
    this.memberCount = 1,
    this.posts = const [],
    this.members = const [],
  });
}
