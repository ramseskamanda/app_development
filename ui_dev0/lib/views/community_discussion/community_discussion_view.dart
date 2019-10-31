import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/responsive/orientation_layout.dart';
import 'package:ui_dev0/responsive/screen_type_layout.dart';
import 'package:ui_dev0/views/community_discussion/community_discussion_view_mobile.dart';
import 'package:ui_dev0/views/community_discussion/state/discussion_controller.dart';
import 'package:ui_dev0/views/home/home_view_tablet.dart';
import 'package:ui_dev0/widgets/base_widget.dart';

class CommunityDiscussionView extends StatelessWidget {
  final CommunityPostModel discussion;

  CommunityDiscussionView({Key key, this.discussion})
      : assert(discussion != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DiscussionController>(
      viewModel: DiscussionController(discussion),
      modelInitializer: (model) async => model.fetchData(),
      builder: (context) {
        return ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: (context) => CommunityDiscussionViewMobilPortrait(),
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
