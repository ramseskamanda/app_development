import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup/ui/home/trending.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';
import 'package:studentup/ui/widgets/screen_title.dart';
import 'package:studentup/util/env.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = Provider.of<PageController>(context);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: ProfileDrawerButton(),
            actions: <Widget>[
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(FeatherIcons.send),
                  onPressed: () => _pageController.animateToPage(
                    Environment.messagingPageIndex,
                    duration: Environment.pageTransitionDuration,
                    curve: Environment.pageTransitionCurve,
                  ),
                ),
              ),
            ],
          ),
        ];
      },
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.11,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ScreenTitle('Home'),
                  TrendingCompetitions(),
                  //DiscussionsList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
