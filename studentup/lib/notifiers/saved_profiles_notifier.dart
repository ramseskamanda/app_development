import 'package:studentup/notifiers/count_notifier.dart';

class SavedProfilesNotifier extends CountNotifier {
  bool get hasProfiles => count > 0;

  int get numSaved => count < 99 ? count : 99;
  void incrementNumSaved() => count += 1;
  void decrementNumSaved() {
    if (count - 1 >= 0) count -= 1;
  }
}
