import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewSkillNotifier extends NetworkNotifier {
  //TODO: change these into blocs
  //category value
  //name value
  //description value
  String _category;
  TextEditingController _name;
  TextEditingController _description;
  FirestoreWriter _firestoreWriter;

  NewSkillNotifier() {
    _firestoreWriter = FirestoreWriter();
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

  Future send() async {
    if (!canSend) return;
    final model = SkillsModel(
      avgRating: 0,
      description: _description.text,
      name: _name.text,
      userId: Locator.of<AuthService>().currentUser.uid,
      category: _category.toLowerCase(),
      ratings: null,
    );
    try {
      await _firestoreWriter.postNewSkill(model);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _description.dispose();
  }

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
