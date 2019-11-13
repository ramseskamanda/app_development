import 'package:flutter/foundation.dart';
import 'package:ui_dev0/views/create_community/state/members.dart';

class UserModel {
  final String name;
  final String photoUrl;
  final List<String> adminRoles;

  bool get isUser => this == testUser;

  const UserModel({
    @required this.name,
    @required this.adminRoles,
    this.photoUrl = 'https://via.placeholder.com/150',
  });
}
