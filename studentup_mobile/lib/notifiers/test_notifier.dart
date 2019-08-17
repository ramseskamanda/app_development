import 'package:flutter/widgets.dart';

class ProfileNotifier extends ChangeNotifier {
  Map<String, dynamic> data;

  ProfileNotifier() {
    initialize();
  }

  Future<void> initialize() async {}
}
