import 'package:flutter/widgets.dart';
import 'package:ui_dev0/data_models/user_model.dart';

//TODO: add this to fake data
const UserModel testUser = UserModel(
  name: 'USER #!',
  photoUrl: 'assets/portrait.jpeg',
  adminRoles: [],
);

class CommunityMemberAdderController extends ChangeNotifier {
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
