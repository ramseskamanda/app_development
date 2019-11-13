import 'package:flutter/widgets.dart';
import 'package:ui_dev0/data_models/user_model.dart';

//TODO: add this to fake data
const UserModel testUser = UserModel(
  name: 'USER #1',
  photoUrl: 'https://via.placeholder.com/150',
  adminRoles: [],
);

class CommunityMemberAdderController extends ChangeNotifier {
  final List<UserModel> _earlyMembers = [];

  List<UserModel> get earlyMembers => _earlyMembers;

  void addMember(UserModel value) {
    print('asdvaosdinf');
    _earlyMembers.add(value);
    notifyListeners();
  }

  void removeMember(UserModel value) {
    _earlyMembers.remove(value);
    notifyListeners();
  }
}
