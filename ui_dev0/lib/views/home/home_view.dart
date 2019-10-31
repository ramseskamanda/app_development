import 'package:flutter/material.dart';
import 'package:ui_dev0/responsive/orientation_layout.dart';
import 'package:ui_dev0/responsive/screen_type_layout.dart';
import 'package:ui_dev0/views/home/home_view_mobile.dart';
import 'package:ui_dev0/views/home/home_view_tablet.dart';
import 'package:ui_dev0/views/home/state/home_controller.dart';
import 'package:ui_dev0/widgets/base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeController>(
      viewModel: HomeController(),
      onModelReady: (model) async => await model.fetchData(),
      builder: (context) {
        return ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: (context) => HomeViewMobilePortrait(),
          ),
          tablet: OrientationLayout(
            portrait: (context) => HomeViewTabletPortrait(),
            landscape: (context) => HomeViewTabletLandscape(),
          ),
        );
      },
    );
  }
}
