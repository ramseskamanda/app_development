import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/ui/home/feed/startup_stories.dart';
import 'package:studentup_mobile/ui/home/feed/think_tanks.dart';
import 'package:studentup_mobile/ui/think_tank/new_think_tank_route.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  final FeedNotifier notifier = FeedNotifier();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<FeedNotifier>.value(
      value: notifier,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // leading: IconButton(
          //   icon: const Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          title: const Text('Home'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.send),
          //     onPressed: () {
          //       Provider.of<PageController>(context).animateToPage(
          //         1,
          //         duration: kTabScrollDuration,
          //         curve: Curves.easeInOutQuad,
          //       );
          //     },
          //   ),
          // ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewThinkTankRoute(),
              ),
            );
            if (result) notifier.onRefresh();
          },
        ),
        body: Consumer<FeedNotifier>(builder: (context, notifier, child) {
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
