import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/home/feed/startup_stories.dart';
import 'package:studentup_mobile/ui/home/feed/think_tanks.dart';
import 'package:studentup_mobile/ui/inner_drawer/inner_drawer.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  final FeedNotifier notifier = FeedNotifier();

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.25;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) print('loading once?');

    if (maxScroll - currentScroll <= delta) //notifier.loadMore();
      print('loading');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<FeedNotifier>.value(
      value: notifier,
      child: Scaffold(
        drawer: InnerDrawerMenu(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => Provider.of<InnerRouter>(context).goToPage(1),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () async {
            final result =
                await Navigator.of(context).pushNamed(Router.newThinkTank);
            if (result) notifier.fetchData();
          },
        ),
        body: NetworkSensitive(
          child: Consumer<FeedNotifier>(
            builder: (context, notifier, child) {
              return LiquidPullToRefresh(
                onRefresh: () => notifier.fetchData(),
                child: ListView(
                  controller: _scrollController,
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
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
