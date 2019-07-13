import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup/ui/home/message_screen/message_thread_tile.dart';
import 'package:studentup/ui/widgets/search_bar.dart';
import 'package:studentup/util/env.dart';

class MessagesList extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    Future.delayed(Duration(seconds: 1), () => print('Refreshed'));
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = Provider.of<PageController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: const Text('Direct Messages'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => _pageController.animateToPage(
            Environment.homePageIndex,
            duration: Environment.pageTransitionDuration,
            curve: Environment.pageTransitionCurve,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FeatherIcons.plusCircle),
            onPressed: () => print('New Message'),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        key: _key,
        height: 50.0,
        showChildOpacityTransition: true,
        onRefresh: _onRefresh,
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 4.0),
          itemBuilder: (context, index) {
            if (index == 0)
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: SearchBar(FocusNode()),
              );
            return MessageThreadTile(
              index: index,
            );
          },
        ),
      ),
    );
  }
}
