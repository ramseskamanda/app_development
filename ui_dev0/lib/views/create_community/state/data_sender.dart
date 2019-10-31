import 'package:ui_dev0/data_models/user_model.dart';
import 'package:ui_dev0/enums/controller_states.dart';
import 'package:ui_dev0/enums/privacy_types.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class DataSender extends BaseController {
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
    if (!_validate()) return;
    state = ControllerState.BUSY;
    print(
      'Sending ------\n $name\n$description\nprivacy: $privacy\nlist: $members',
    );
    await Future.delayed(Duration(seconds: 2));
    state = ControllerState.IDLE;
  }
}
