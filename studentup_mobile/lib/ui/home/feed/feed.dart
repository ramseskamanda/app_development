import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/ui/home/feed/startup_stories.dart';
import 'package:studentup_mobile/ui/home/feed/think_tanks.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
        ],
      ),
      body: ChangeNotifierProvider<FeedNotifier>(
        builder: (_) => FeedNotifier(),
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
      ),
    );
  }
}
