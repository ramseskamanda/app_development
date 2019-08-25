import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/ui/home/feed/startup_stories.dart';
import 'package:studentup_mobile/ui/home/feed/think_tanks.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              Provider.of<PageController>(context).animateToPage(
                1,
                duration: kTabScrollDuration,
                curve: Curves.easeInOutQuad,
              );
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider<FeedNotifier>(
        builder: (_) => FeedNotifier(),
        child: Consumer<FeedNotifier>(builder: (context, notifier, child) {
          return LiquidPullToRefresh(
            onRefresh: () => notifier.onRefresh(),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: StartupStories(),
                ),
                const SizedBox(height: 24.0),
                ThinkTankPreviewsList(),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
