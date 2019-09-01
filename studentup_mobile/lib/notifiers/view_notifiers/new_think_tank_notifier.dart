import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class NewThinkTankNotifier extends NetworkNotifier {
  //TODO: change these into blocs
  //name value
  //description value
  TextEditingController _name;
  TextEditingController _description;
  FirestoreWriter _firestoreWriter;

  NewThinkTankNotifier() {
    _firestoreWriter = Locator.of<FirestoreWriter>();
    _name = TextEditingController();
    _description = TextEditingController();
  }

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  bool get canSend => _name.text.isNotEmpty && _description.text.isNotEmpty;

  Future<bool> send() async {
    if (!canSend) return false;
    isLoading = true;
    UserInfoModel user = Locator.of<ProfileNotifier>().info;
    final model = ThinkTanksModel(
      askerId: Locator.of<AuthService>().currentUser.uid,
      askerImage: user.mediaRef,
      premise: _description.text,
      title: _name.text,
      lastActivity: DateTime.now(),
      commentCount: 0,
      comments: null,
    );
    try {
      await _firestoreWriter.postNewThinkTank(model);
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

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
