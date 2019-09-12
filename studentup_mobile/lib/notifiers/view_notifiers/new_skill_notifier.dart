import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewSkillNotifier extends NetworkWriter {
  //category value
  //name value
  //description value
  String _category;
  TextEditingController _name;
  TextEditingController _description;

  NewSkillNotifier() {
    _name = TextEditingController();
    _description = TextEditingController();
    category = 'Select a category...';
  }

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  String get category => _category;
  bool get canSend =>
      _name.text.isNotEmpty &&
      _description.text.isNotEmpty &&
      category != 'Select a category...';

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  @override
  Future<bool> sendData() async {
    try {
      if (!canSend) return false;
      isLoading = true;
      final model = SkillsModel(
        avgRating: 0,
        description: _description.text,
        name: _name.text,
        userId: Locator.of<AuthService>().currentUser.uid,
        category: _category.toLowerCase(),
        ratings: null,
      );
      await writer.postNewSkill(model);
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
