import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewThinkTankNotifier extends NetworkWriter {
  TextEditingController _name;
  TextEditingController _description;
  ThinkTankModel _model;
  Preview _user;

  NewThinkTankNotifier({ThinkTankModel model, Preview user})
      : _model = model,
        _user = user,
        _name = TextEditingController(text: model != null ? model.title : null),
        _description =
            TextEditingController(text: model != null ? model.premise : null);

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  bool get canSend => _name.text.isNotEmpty && _description.text.isNotEmpty;

  @override
  Future<bool> sendData() async {
    if (!canSend) return false;
    isLoading = true;
    try {
      if (_model == null) {
        final model = ThinkTankModel(
          askerId: Locator.of<BaseAuth>().currentUserId,
          askerImage: _user.imageUrl,
          premise: _description.text,
          title: _name.text,
          lastActivity: DateTime.now(),
          commentCount: 0,
          comments: null,
        );
        await writer.postNewThinkTank(model);
      } else {
        Map<String, dynamic> _data = {
          'premise': _description.text,
          'title': _name.text,
        };
        _data.removeWhere((key, value) => value == null || value.isEmpty);
        await writer.editThinkTank(
          model: _model,
          data: _data,
        );
      }
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
