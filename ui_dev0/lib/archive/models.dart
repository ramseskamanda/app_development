import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  final String name;
  final String photoUrl;

  const UserModel({
    @required this.name,
    @required this.photoUrl,
  });
}

class ProjectModel {
  final UserModel creator;
  final String name;
  final String description;
  final Duration duration;
  final DateTime applicationDeadline;
  final Map<String, dynamic> tags;
  final FileAsset image;
  final bool featured;

  String get stringDuration => (duration.inDays ~/ 30).toString() + ' months';
  String get stringDeadline {
    Duration difference = applicationDeadline.difference(DateTime.now());
    if (difference.inDays > 0) return difference.inDays.toString() + ' day(s)';
    if (difference.inHours > 0)
      return difference.inHours.toString() + ' hour(s)';
    if (!difference.isNegative) return 'less than an hour';
    return 'passed';
  }

  const ProjectModel({
    @required this.creator,
    @required this.name,
    @required this.description,
    @required this.duration,
    @required this.applicationDeadline,
    @required this.tags,
    this.featured = false,
    this.image,
  });
}

class FileAsset {
  final String downloadUrl;

  const FileAsset({@required this.downloadUrl});
}
