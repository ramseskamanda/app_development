import 'package:flutter/foundation.dart';

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
