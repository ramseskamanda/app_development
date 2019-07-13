import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup/ui/home/trending.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';
import 'package:studentup/util/env.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = Provider.of<PageController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.11,
          ),
          child: ListView(
            children: <Widget>[
              TrendingCompetitions(),
              //DiscussionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
