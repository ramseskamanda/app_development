import 'package:flutter/material.dart';
import 'package:ui_dev0/enums/device_screen_types.dart';
import 'package:ui_dev0/responsive/base_widget.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({Key key, this.mobile, this.tablet, this.desktop})
      : assert(
          mobile != null,
          'You must specify a mobile layout to use this widget.',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        switch (sizingInfo.deviceScreenType) {
          case DeviceScreenType.Tablet:
            return tablet ?? desktop ?? mobile;
            break;
          case DeviceScreenType.Desktop:
            return desktop ?? tablet ?? mobile;
            break;
          default:
            return mobile;
        }
      },
    );
  }
}
