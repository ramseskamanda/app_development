import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewThinkTankNotifier extends NetworkWriter {
  //name value
  //description value
  TextEditingController _name;
  TextEditingController _description;

  NewThinkTankNotifier()
      : _name = TextEditingController(),
        _description = TextEditingController();

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  bool get canSend => _name.text.isNotEmpty && _description.text.isNotEmpty;

  @override
  Future<bool> sendData() async {
    if (!canSend) return false;
    isLoading = true;
    final Preview user = Locator.of<ProfileNotifier>().info;
    final model = ThinkTankModel(
      askerId: Locator.of<AuthService>().currentUser.uid,
      askerImage: user.imageUrl,
      premise: _description.text,
      title: _name.text,
      lastActivity: DateTime.now(),
      commentCount: 0,
      comments: null,
    );
    try {
      await writer.postNewThinkTank(model);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
      return false;
    }
    isLoading = false;
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _description.dispose();
  }
}
