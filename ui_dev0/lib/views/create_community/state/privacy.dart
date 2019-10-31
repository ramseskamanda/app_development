import 'package:flutter/widgets.dart';
import 'package:ui_dev0/enums/privacy_types.dart';

class CommunityPrivacyPicker extends ChangeNotifier {
  CommunityPrivacy _setting = CommunityPrivacy.public;
  CommunityPrivacy get setting => _setting;
  set setting(CommunityPrivacy value) {
    _setting = value;
    notifyListeners();
  }
}
