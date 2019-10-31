import 'package:flutter/material.dart';
import 'package:ui_dev0/enums/device_screen_types.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType\n'
        'ScreenSize: $screenSize\n'
        'LocalWidgetSize: $localWidgetSize';
  }
}
