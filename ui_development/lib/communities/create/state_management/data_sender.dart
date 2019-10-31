import 'package:flutter/foundation.dart';
import 'package:ui_development/communities/enum/privacy.dart';
import 'package:ui_development/models.dart';

class DataSender extends ChangeNotifier {
  final String name;
  final String description;
  final CommunityPrivacy privacy;
  final List<UserModel> members;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  DataSender(this.name, this.description, this.privacy, this.members);

  Future<void> sendData() async {
    isLoading = true;
    print(
      'Sending ------\n $name\n$description\nprivacy: $privacy\nlist: $members',
    );
    await Future.delayed(
      Duration(seconds: 2),
      () => isLoading = false,
    );
  }
}
