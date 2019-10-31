import 'package:flutter/widgets.dart';
import 'package:ui_development/communities/enum/privacy.dart';

class CommunityPrivacyPicker extends ChangeNotifier {
  CommunityPrivacy _setting = CommunityPrivacy.public;
  CommunityPrivacy get setting => _setting;
  set setting(CommunityPrivacy value) {
    _setting = value;
    notifyListeners();
  }
}
