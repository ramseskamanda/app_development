import 'package:flutter/widgets.dart';
import 'package:ui_development/models.dart';

const UserModel testUser = UserModel(
  name: 'USER #!',
  photoUrl: 'assets/portrait.jpeg',
  adminRoles: [],
);

class CommunityMemberAdderViewModel extends ChangeNotifier {
  final List<UserModel> _earlyMembers = [];

  List<UserModel> get earlyMembers => _earlyMembers;

  void addMember(UserModel value) {
    _earlyMembers.add(testUser);
    notifyListeners();
  }

  void removeMember(UserModel value) {
    _earlyMembers.remove(value);
    notifyListeners();
  }
}
