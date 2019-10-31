import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev0/responsive/orientation_layout.dart';
import 'package:ui_dev0/responsive/screen_type_layout.dart';
import 'package:ui_dev0/views/create_community/create_community_mobile_view.dart';
import 'package:ui_dev0/views/create_community/state/data_sender.dart';
import 'package:ui_dev0/views/create_community/state/info.dart';
import 'package:ui_dev0/views/create_community/state/members.dart';
import 'package:ui_dev0/views/create_community/state/privacy.dart';
import 'package:ui_dev0/views/home/home_view_tablet.dart';

class CreateCommunityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CommunityInfoBloc>(builder: (_) => CommunityInfoBloc()),
        ChangeNotifierProvider<CommunityPrivacyPicker>(
            builder: (_) => CommunityPrivacyPicker()),
        ChangeNotifierProvider<CommunityMemberAdderController>(
            builder: (_) => CommunityMemberAdderController()),
        ChangeNotifierProxyProvider3<CommunityInfoBloc, CommunityPrivacyPicker,
            CommunityMemberAdderController, DataSender>(
          initialBuilder: (_) => DataSender(),
          builder: (context, info, privacy, members, controller) {
            print('Im proxying some values');
            return controller
              ..name = info.name.value
              ..description = info.description.value
              ..members = members.earlyMembers
              ..privacy = privacy.setting;
          },
        ),
      ],
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => CreateCommunityViewMobilePortrait(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => HomeViewTabletPortrait(),
          landscape: (context) => HomeViewTabletLandscape(),
        ),
      ),
    );
  }
}
