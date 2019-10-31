import 'package:ui_dev0/enums/controller_states.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class HomeController extends BaseController {
  Future<void> fetchData() async {
    state = ControllerState.BUSY;
    await Future.delayed(const Duration(seconds: 2));
    state = ControllerState.IDLE;
  }
}
