import 'package:flutter/widgets.dart';
import 'package:ui_dev0/enums/device_screen_types.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  final double deviceWidth = mediaQueryData.size.shortestSide;
  if (deviceWidth > 950) return DeviceScreenType.Desktop;
  if (deviceWidth > 600) return DeviceScreenType.Tablet;
  return DeviceScreenType.Mobile;
}
