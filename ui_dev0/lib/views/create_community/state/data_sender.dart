import 'package:ui_dev0/data_models/user_model.dart';
import 'package:ui_dev0/enums/privacy_types.dart';

class DataSender {
  String name;
  String description;
  CommunityPrivacy privacy;
  List<UserModel> members;

  bool _validate() {
    if (name == null || name.isEmpty) return false;
    if (description == null || description.isEmpty) return false;
    if (privacy == null) return false;
    if (members == null || members.isEmpty) return false;
    return true;
  }

  Future<void> sendData() async {
    if (!_validate()) throw 'Invalid';
    print('Sending');
    await Future.delayed(Duration(seconds: 2));
    print('------\n$name\n$description\nprivacy: $privacy\nlist: $members');
  }

  @override
  String toString() {
    return '$name : $description : $privacy : ${members?.length ?? 0} | ${members}';
  }
}
