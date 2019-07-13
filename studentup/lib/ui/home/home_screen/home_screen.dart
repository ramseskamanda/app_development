import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup/notifiers/message_notifier.dart';
import 'package:studentup/ui/home/trending.dart';
import 'package:studentup/ui/widgets/notifiable_icon.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';
import 'package:studentup/util/env.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    Future.delayed(Duration(seconds: 1), () => print('Refreshed'));
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = Provider.of<PageController>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'home_screen',
        child: const Icon(FeatherIcons.server),
        onPressed: () => Provider.of<MessageNotifier>(context).count += 1,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: ProfileDrawerButton(),
        actions: <Widget>[
          IconButton(
            icon: NotifiableIcon<MessageNotifier>(
              iconData: FeatherIcons.send,
            ),
            onPressed: () => _pageController.animateToPage(
              Environment.messagingPageIndex,
              duration: Environment.pageTransitionDuration,
              curve: Environment.pageTransitionCurve,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.11,
          ),
          child: LiquidPullToRefresh(
            key: _key,
            height: 50.0,
            showChildOpacityTransition: true,
            onRefresh: _onRefresh,
            child: ListView(
              children: <Widget>[
                TrendingCompetitions(),
                //DiscussionsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
