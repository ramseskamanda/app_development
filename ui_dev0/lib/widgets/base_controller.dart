import 'package:flutter/material.dart';
import 'package:ui_dev0/enums/controller_states.dart';

abstract class BaseController extends ChangeNotifier {
  ControllerState _state;
  ControllerState get state => _state;
  bool get isLoading => _state == ControllerState.BUSY;
  bool get isIdle => _state == ControllerState.IDLE;
  bool get hasError => _state == ControllerState.HAS_ERROR;

  set state(ControllerState value) {
    _state = value;
    notifyListeners();
  }
}
