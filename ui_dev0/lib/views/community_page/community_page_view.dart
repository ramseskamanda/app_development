import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/responsive/orientation_layout.dart';
import 'package:ui_dev0/responsive/screen_type_layout.dart';
import 'package:ui_dev0/views/community_page/community_page_view_mobile.dart';
import 'package:ui_dev0/views/community_page/state/community_controller.dart';
import 'package:ui_dev0/views/home/home_view_tablet.dart';
import 'package:ui_dev0/widgets/base_widget.dart';

class CommunityPageView extends StatelessWidget {
  final CommunityModel community;

  CommunityPageView({Key key, this.community})
      : assert(community != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommunityController>(
      viewModel: CommunityController(community),
      modelInitializer: (model) async => model.fetchData(),
      builder: (context) {
        return ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: (context) => CommunityPageViewMobilePortrait(),
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
