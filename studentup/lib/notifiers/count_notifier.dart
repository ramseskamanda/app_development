import 'package:studentup/notifiers/base_notifier.dart';

class CountNotifier extends BaseNotifier {
  int _count = 0;

  int get count => _count;
  bool get countIsZero => _count == 0;

  //Look up if it's worth having a try catch block here
  set count(int newCount) {
    _count = newCount;
    notifyListeners();
  }
}
