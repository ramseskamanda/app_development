import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup/util/env.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _pageController = Provider.of<PageController>(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          pinned: true,
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
        SliverPadding(padding: EdgeInsets.only(top: 16.0)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => MessageThreadTile(index: index),
          ),
        ),
      ],
    );
  }
}

class MessageThreadTile extends StatelessWidget {
  final int index;

  MessageThreadTile({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
