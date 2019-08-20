import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class ThinkTankNotifier extends NetworkNotifier {
  final ThinkTanksModel model;

  ThinkTankNotifier(this.model);

  Stream<Object> get comments => null;

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
//TODO: make think tanks live
