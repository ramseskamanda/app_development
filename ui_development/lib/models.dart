import 'package:flutter/foundation.dart';

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

class CommunityPostModel {
  final UserModel originalPoster;
  final String content;
  final List<FileAsset> files;
  final List<CommunityPostModel> replies;
  final int replyCount;
  final int replyGeneration; //0: original post, 1: reply, 2: reply to reply
  final DateTime postedAt;
  final Map<String, int> reactions;

  const CommunityPostModel({
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

class UserModel {
  final String name;
  final String photoUrl;
  final List<String> adminRoles;

  const UserModel({
    @required this.name,
    @required this.adminRoles,
    this.photoUrl = 'https://via.placeholder.com/150',
  });
}

class FileAsset {
  final String id;
  final String fileName;
  final String downloadUrl;
  final String fileType;

  FileAsset({
    @required this.id,
    @required this.downloadUrl,
    @required this.fileName,
    this.fileType,
  });
}
